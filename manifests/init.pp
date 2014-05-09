# == Class: nagiosclient
#
# A module to configure a nagios client
#
# === Parameters
# ["version"]
#   The package version to install
#
# ["allowed_hosts"]
#   Nagios servers allowed to connect to this client
#
# ["enable"]
#   Should the service be enabled during boot time?
#
# ["start"]
#   Should the service be started by Puppet

class nagiosclient (
  $version = 'present',
  $allowed_hosts = '127.0.0.1',
  $enable = true,
  $start = true
  )  {
    class{'nagiosclient::install': } ->
    class{'nagiosclient::configure': } ~>
    class{'nagiosclient::service': } ->
    Class['nagiosclient']
  }
