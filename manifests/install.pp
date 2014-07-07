# == Class: nagiosclient::install
#
# Installs nagios-nrpe-server, and lm-sensors on physical hosts
class nagiosclient::install {
  package { 'nagios-nrpe-server':
    ensure => $nagiosclient::version,
  }

  if $::is_virtual == 'false' {
    package { 'lm-sensors':
      ensure => present,
      tag    => $::physical,
    }
  }
}
