# == Class: nagiosclient::install
#
# Installs nagios-nrpe-server, and lm-sensors on physical hosts
class nagiosclient::install {
  package { 'nagios-nrpe-server':
    ensure => $nagiosclient::version,
  }

  @package { 'lm-sensors':
    ensure => present,
    tag    => 'physical',
  }

  Package <| tag == $::virtual |>
}
