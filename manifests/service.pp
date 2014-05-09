# == Class: nagiosclient::service
#
# Controls the nagios-nrpe-server service
class nagiosclient::service {
  $ensure = $nagiosclient::start ? {true => running, default => stopped}

  service { 'nagios-nrpe-server':
    ensure => $ensure,
    enable => $nagiosclient::enable,
  }
}
