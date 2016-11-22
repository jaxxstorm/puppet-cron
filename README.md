# puppet-cron

[![Build Status](https://travis-ci.org/jaxxstorm/puppet-cron.svg?branch=master)](https://travis-ci.org/jaxxstorm/puppet-cron)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with puppet-cron](#setup)
    * [What puppet-cron affects](#what-puppet-cron-affects)
    * [Beginning with puppet-cron](#beginning-with-puppet-cron)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)


## Module description

This is yet another puppet-cron module. It will set up cron (by installed the package and making sure the service is running) and also includes a defined type which will put cron jobs in `/etc/cron.d`

This module has some similarities to Yelp's [puppet-cron](https://github.com/Yelp/puppet-cron) with the intention of being much simpler while still providing some of the cool stuff in that module

## Setup

### What puppet-cron affects

  * puppet-cron will ensure the cronie or cron package is installed
  * It will may modify the permissions of several cron directories, like `/etc/crond.d`

### Beginning with puppet-cron

Simply include the cron module like so:

```puppet
  include ::cron
```

You may want to use a class include if you wish to override parameters:

```puppet
  class { '::cron' :
		crond_dir => '/etc/cron'
  }
```

## Usage

### I just want to manage cron, what's the minimum I need

```puppet
  include ::cron
```

### I want to create a cron job

Use the `cron::job` defined type:

```puppet
  ::cron::job {
		minute => '02',
    hour   => '1',
    lock   => true
  }
```

This will create a cronjob file in `$crond_dir` (default: `/etc/cron.d`) which will run on the schedule you specified.


## Reference

### Classes

#### Public Classes
  *[`cron`](#cron): Installs and configures cron in your environment.
  *[`cron::job`](#cronjob): Installs and configures a cronjob in `$crond_dir`

#### Private Classes
  *[`cron::install`]: Installs the required cron package
  *[`cron::configure`]: Configures cron's required directories
  *[`cron::service`]: Manages the cron service
  

### `cron`

#### Parameters

##### `package_name`

Specifies the package to install for cron

##### `package_ensure`

Specifies the version of the cron package to install (default: os dependent)

##### `service_name`

Specifies the cron service to manage (default: latest)

##### `service_ensure`

Specifies the state of the cron service (running, stopped - default: running)

##### `service_enable`

Specifies whether the crond service should be enabled on startup (true, false - default: true)

##### `crontab_file`

Specifies the path to the OS crontab file (default: os dependent)

##### `crond_dir`

Specifies the path to the cron.d dir (default: `/etc/cron.d`)

##### `crond_hourly`

Specifies the path to the cron.hourly scripts directory (default: `/etc/cron.hourly`)

##### `crond_weekly`

Specifies the path to the cron.weekly scripts directory (default: `/etc/cron.weekly`)

##### `crond_monthly`

Specifies the path to the cron.monthly scripts directory (default: `/etc/cron.monthly`)

##### `user`

Specifies the user to own the crond dirs and files (default: 'root' - _CHANGE WITH CAUTION_)

##### `group`

Specifies the group to own the crond dirs and files (default: 'root' - _CHANGE WITH CAUTION_)

##### `purge`

Specifies whether to purge the $crond_dir directory of jobs not specified by puppet (default: false)


### `cron::job`

#### Parameters

Coming soon

## Limitations
