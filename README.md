puppet-liveconfig [![Build status](https://api.travis-ci.org/gwaldvogel/puppet-liveconfig.svg)](https://travis-ci.org/gwaldvogel/puppet-liveconfig)
===================================================================================================================================================

Puppet module to install and update [Liveconfig](https://www.liveconfig.com/de)

Parameters
----------

`meta_package` If set to true the liveconfig-meta package will be installed

`meta_package_nginx` If set to true the liveconfig-meta-nginx package will be installed

`licensekey` Set the licensekey here to automatically actiavte liveconfig

Compatibility
-------------

This module is currently only compatible with Debian and Ubuntu.

Requirements
------------

-	[puppetlabs/apt](https://forge.puppetlabs.com/puppetlabs/apt)

Changelog
---------

-	0.1.0 - Added basic manifest
-	0.2.0 - Added options for the liveconfig-meta and liveconfig-meta-nginx packages
