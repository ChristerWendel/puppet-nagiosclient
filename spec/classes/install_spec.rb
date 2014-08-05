require 'spec_helper'

describe 'nagiosclient', :type => :class do
  let(:title) { 'nagiosclient::install' }

  context 'with default parameters' do
    it { should contain_package('nagios-nrpe-server')
        .with_ensure('present')
    }
  end

  context 'version => present' do
    let(:params) { {:version => 'present'} }

    it { should contain_package('nagios-nrpe-server')
        .with_ensure('present')
    }
  end

  context 'version => latest' do
    let(:params) { {:version => 'latest'} }

    it { should contain_package('nagios-nrpe-server')
        .with_ensure('latest')
    }
  end

  context 'physical machine' do
    let(:facts) { {:is_virtual => 'false'} }

    it { should contain_package('lm-sensors')
        .with_ensure('present')
    }
  end

  context 'virtual machine' do
    let(:facts) { {:is_virtual => 'true'} }

    it { should_not contain_package('lm-sensors') }
  end
end
