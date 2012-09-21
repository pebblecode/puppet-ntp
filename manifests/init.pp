# == Class: ntp
#
# Installs and starts ntp. Write a configuration file to /etc/ntp.conf
#
# === Parameters
#
# none
#
# === Variables
# 
# none
#
# === Examples
#
# include ntp
#  
# === Authors
#
# Author Name <george@shapeshed.com>
#
# === Copyright
#
# Copyright 2012 George Ornbo, unless otherwise noted.
#
class ntp {
  package { 'ntp':
    ensure => installed,
  }

  file { '/etc/ntp.conf':
    ensure  => file,
    source  => 'puppet:///modules/ntp/ntp.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    require => Package['ntp'],
    notify  => Service['ntp'],
  }

  service { 'ntp':
    ensure => 'running',
    enable => 'true',
  }

  exec {
    'set time':
      path    => '/bin:/usr/bin',
      command => 'echo "Europe/London" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata',
      require => [Service['ntp']],
  }
}
