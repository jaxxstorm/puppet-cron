# Install & manage cron
#
# @example Declaring the class
#   include ::cron
#
# @param [String] package_name the cron package to install
# @param [String] package_ensure the version of the cron package to install
# @param [String] service_name the name of the cron service to manage
# @param [String] service_ensure state of the cron service
# @param [String] crontab_file path to the crontab file
# @param [String] crond_dir path to the crond dir
# @param [String] crond_hourly path to the crond hourly scripts dir
# @param [String] crond_weekly path to the crond weekly scripts dir
# @param [String] crond_weekly path to the crond monthly scripts dir
# @param [String] user username to own the cron directories and files
# @param [String] group group to own the cron directories and files
# @param [String] purge whether to purge the contents of $crond_dir of resources not managed by Puppet
class cron (
  $package_name   = $cron::params::package_name,
  $package_ensure = 'installed',
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
  -> class { 'cron::install': }
  -> class { 'cron::config': }
  -> class { 'cron::service': }
  -> anchor { 'cron_final': }

}
