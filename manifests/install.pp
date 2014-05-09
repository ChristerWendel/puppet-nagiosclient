# == Class: nagiosclient::install
#
# Installs nagios-nrpe-server
class nagiosclient::install {
  package { 'nagios-nrpe-server':
    ensure => $nagiosclient::version,
  }
}
