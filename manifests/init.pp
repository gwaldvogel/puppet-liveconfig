
# Class: liveconfig
# ===========================
#
# A module to install and update Liveconfig webhosting panel from
# the offical Liveconfig package server.
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

class liveconfig {

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
}
