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

The `cron::job` type can:

  - Set up locking, using `flock`, meaning cronjobs don't clobber each other
  - If you use sensu, alert when they fail, using [sensu-wrapper](https://github.com/jaxxstorm/sensu-wrapper)

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
  * [`cron`](#cron): Installs and configures cron in your environment.
  * [`cron::job`](#cronjob): Installs and configures a cronjob in `$crond_dir`

#### Private Classes
  * [`cron::install`]: Installs the required cron package
  * [`cron::configure`]: Configures cron's required directories
  * [`cron::service`]: Manages the cron service
  

### `cron`

#### Parameters

##### `package_name` [String]

Specifies the package to install for cron

##### `package_ensure` [String]

Specifies the version of the cron package to install (default: os dependent)

##### `service_name` [String]

Specifies the cron service to manage (default: latest)

##### `service_ensure` [String]

Specifies the state of the cron service (running, stopped - default: running)

##### `service_enable` [Bool]

Specifies whether the crond service should be enabled on startup (true, false - default: true)

##### `crontab_file` [String]

Specifies the path to the OS crontab file (default: os dependent)

##### `crond_dir` [String]

Specifies the path to the cron.d dir (default: `/etc/cron.d`)

##### `crond_hourly` [String]

Specifies the path to the cron.hourly scripts directory (default: `/etc/cron.hourly`)

##### `crond_weekly` [String]

Specifies the path to the cron.weekly scripts directory (default: `/etc/cron.weekly`)

##### `crond_monthly` [String]

Specifies the path to the cron.monthly scripts directory (default: `/etc/cron.monthly`)

##### `user` [String]

Specifies the user to own the crond dirs and files (default: 'root' - _CHANGE WITH CAUTION_)

##### `group` [String]

Specifies the group to own the crond dirs and files (default: 'root' - _CHANGE WITH CAUTION_)

##### `purge` [Bool]

Specifies whether to purge the $crond_dir directory of jobs not specified by puppet (default: false)


### `cron::job`

#### Parameters

##### `command` [String]

Specifies the command to run in the job (required)

##### `ensure` [String]

Specifies whether the job should exist or not (default: present)

##### `minute` [String]

Specifies the cron style minute the job should run (default: '*')

##### `hour` [String]

Specifies the cron style hour the should run (default: '*')

##### `day_of_month` [String]

Specifies the cron style day of the month the job should run (default: '*')

##### `month` [String]

Specifies the cron style montht the job should run (default: '*')

##### `day_of_week` [String]

Specifies the cron style day of the week the job should run (default: '*')

##### `user` [String]

Specifies the user the cron job should run as (default: 'root')

##### `environment` [Array]

Specifies an array of environment variables for the job in fhe format `ENV=value` (default: [])

##### `lock` [Bool]

Specifies whether the cron job should lock itself using `flock` (default: false)

##### `monitor_job` [Bool]

Specifies whether you want to monitor the job using sensu-wrapper (default: undef)

##### `monitor_ttl` [Integer]

Specifies a TTL for the job for sensu-wrapper (default: undef)

##### `monitor_source` [String]

Specifies a source string for the alert generated in sensu (default: undef)

##### `monitor_timeout` [Integer]

Specifies a timeout for sensu-wrapper before the job should halt and fail (default: undef)


## Limitations
