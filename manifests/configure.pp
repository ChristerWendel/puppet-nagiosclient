# == Class: nagiosclient::configure
#
# Configures the nfs server
class nagiosclient::configure {
  $allowed_hosts = $nagiosclient::allowed_hosts
  $parameters = $nagiosclient::export_parameters

  augeas { 'nrpe.cfg':
    context => '/files/etc/nagios/nrpe.cfg',
    changes => "set allowed_hosts ${allowed_hosts}",
  }

  file { '/etc/nagios/nrpe.d/check_nrpe.cfg':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('nagiosclient/check_nrpe.erb'),
  }
}
