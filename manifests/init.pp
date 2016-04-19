
# Class: liveconfig
# ===========================
#
# A module to install and update Liveconfig webhosting panel from
# the offical Liveconfig package server.
#
# Parameters
# --------
#
# [*meta_package*]
#   If set to true the liveconfig-meta package will be installed
# [*meta_package_nginx*]
#   If set to true the liveconfig-meta-nginx package will be installed
#
# Examples
# --------
#
# @example
#    class { 'liveconfig': }
#
# Authors
# -------
#
# Gregor Waldvogel <gregor@waldvogel.io>
#
# Copyright
# ---------
#
# Copyright 2016 Gregor Waldvogel.
#

include apt

class liveconfig(
  $meta_package = any2bool(params_lookup('meta_package')),
  $meta_package_nginx = any2bool(params_lookup('meta_package_nginx')),
  $licensekey = ''
) {

  $meta_package_ensure = $liveconfig::meta_package ? {
    true    => 'latest',
    false   => 'absent',
    default => 'absent',
  }

  $meta_package_nginx_ensure = $liveconfig::meta_package_nginx ? {
    true    => 'latest',
    false   => 'absent',
    default => 'absent',
  }

  # Installing liveconfig key & apt repo
  apt::source { 'liveconfig':
    key      => {
      id     => 'E0783ADDB3382926C072D1471059DFB908708961',
      source => 'https://www.liveconfig.com/liveconfig.key',
    },
    location => 'http://repo.liveconfig.com/debian/',
    repos    => 'main',
    release  => 'main',
    include  => {
      deb => true,
    },
  }

  # Install liveconfig
  package { 'liveconfig':
    ensure  => 'latest',
    require => apt::source['liveconfig'],
  }

  package { 'liveconfig-meta':
    ensure  => $meta_package_ensure,
    require => apt::source['liveconfig'],
  }

  package { 'liveconfig-meta-nginx':
    ensure  => $meta_package_nginx_ensure,
    require => apt::source['liveconfig'],
  }

  if $licensekey != '' {
    exec { 'liveconfig-activation':
      require     => Package['liveconfig'],
      command     => 'liveconfig --activate',
      environment => "LCLICENSEKEY=$licensekey",
      # TODO: once we give the user the option to modify the config file replace
      # the path here with the one set by the user
      creates     => '/etc/liveconfig/liveconfig.key',
      logoutput   => 'on_failure',
    }
  }
}
