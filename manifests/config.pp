# Private class to config cron
class cron::config {

  file { $cron::crontab_file :
    ensure  => file,
    owner   => $cron::user,
    group   => $cron::group,
    mode    => '0600',
    require => Package[$cron::package_name]
  }

  file { $cron::crond_dir :
    ensure  => directory,
    owner   => $cron::user,
    group   => $cron::group,
    mode    => '0700',
    purge   => $cron::purge,
    recurse => $cron::purge,
    require => Package[$cron::package_name]
  }

  file { $cron::crond_hourly :
    ensure  => directory,
    owner   => $cron::user,
    group   => $cron::group,
    mode    => '0700',
    require => Package[$cron::package_name]
  }

  file { $cron::crond_daily :
    ensure  => directory,
    owner   => $cron::user,
    group   => $cron::group,
    mode    => '0700',
    require => Package[$cron::package_name]
  }

  file { $cron::crond_weekly :
    ensure  => directory,
    owner   => $cron::user,
    group   => $cron::group,
    mode    => '0700',
    require => Package[$cron::package_name]
  }

  file { $cron::crond_monthly :
    ensure  => directory,
    owner   => $cron::user,
    group   => $cron::group,
    mode    => '0700',
    require => Package[$cron::package_name]
  }

}
