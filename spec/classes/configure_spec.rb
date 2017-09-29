require 'spec_helper'

describe 'nagiosclient', :type => :class do
  let(:title) { 'nagiosclient::configure' }

  context 'with default params' do
    it { should contain_augeas('nrpe.cfg')
        .with_context('/files/etc/nagios/nrpe.cfg')
        .with_changes('set allowed_hosts 127.0.0.1')
    }

    it { should contain_file('/etc/nagios/nrpe.d/check_nrpe.cfg')
        .with_content(/check_apt -t 60/)
        .with_content(/check_disk/)
        .with_content(/check_load/)
        .with_content(/check_ups/)
    }

    it { should_not contain_file('/usr/lib/nagios/plugins/check_sensors_raspberrypi')
        .with_owner('root')
    }
  end

  context 'allowed_hosts => 192.168.0.0/24' do
    let(:params) { {:allowed_hosts => '192.168.0.0/24'} }

    it { should contain_augeas('nrpe.cfg')
        .with_context('/files/etc/nagios/nrpe.cfg')
        .with_changes('set allowed_hosts 192.168.0.0/24')
    }
  end

  context 'physical machine' do
    let(:facts) { {:is_virtual => false} }

    it { should contain_file('/etc/nagios/nrpe.d/check_nrpe.cfg')
        .without_content(/check_sensors_raspberrypi/)
        .with_content(/check_sensors/)
    }
  end

  context 'virtual machine' do
    let(:facts) { {:is_virtual => true} }

    it { should contain_file('/etc/nagios/nrpe.d/check_nrpe.cfg')
        .without_content(/check_sensors_raspberrypi/)
        .without_content(/check_sensors/)
    }
  end

  context 'raspberry pi' do
    let(:facts) { {:rubyplatform => 'arm-linux-gnueabihf'} }

    it { should contain_file('/usr/lib/nagios/plugins/check_sensors_raspberrypi')
        .with_owner('root')
        .with_source('puppet:///modules/nagiosclient/check_sensors_raspberrypi')
    }

    it { should contain_file('/etc/nagios/nrpe.d/check_nrpe.cfg')
        .with_content(/check_sensors_raspberrypi/)
    }
  end
end
