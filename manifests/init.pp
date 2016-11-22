# Sets up cron defaults
class cron (
  $package_name   = $cron::params::package_name,
  $package_ensure = 'latest',
  $service_name   = $cron::params::service_name,
  $service_ensure = 'running',
  $service_enable = true,
  $crontab_file   = $cron::params::crontab_file,
  $crond_dir      = $cron::params::crond_dir,
  $crond_hourly   = $cron::params::crond_hourly,
  $crond_weekly   = $cron::params::crond_weekly,
  $crond_monthly  = $cron::params::crond_monthly,
  $user           = $cron::params::user,
  $group          = $cron::params::group,
  $purge          = $cron::params::purge,
) inherits cron::params {

  validate_re($service_ensure, '^(running|stopped)$')
  validate_bool($service_enable)

  anchor { 'cron_first': }
  ->
  class { 'cron::install': } ->
  class { 'cron::config': } ->
  class { 'cron::service': } ->
  anchor { 'cron_final': }

}
