# Private params class
class cron::params {

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $package_name   = 'cronie'
      $service_name   = 'crond'
      $crontab_file   = '/etc/crontab'
      $crond_dir      = '/etc/cron.d'
      $crond_hourly   = '/etc/cron.hourly'
      $crond_daily    = '/etc/cron.daily'
      $crond_weekly   = '/etc/cron.weekly'
      $crond_monthly  = '/etc/cron.monthly'
      $user           = 'root'
      $group          = 'root'
    }
    'Debian', 'Ubuntu': {
      $package_name   = 'cron'
      $service_name   = 'cron'
      $crontab_file   = '/etc/crontab'
      $crond_dir      = '/etc/cron.d'
      $crond_hourly   = '/etc/cron.hourly'
      $crond_daily    = '/etc/cron.daily'
      $crond_weekly   = '/etc/cron.weekly'
      $crond_monthly  = '/etc/cron.monthly'
      $user           = 'root'
      $group          = 'root'
    }
    default: { fail('Unsupported OS') }
  }

}
