# Sets up cron defaults
class cron (
  $package_name = $cron::params::package_name,
  $package_ensure = 'latest',
  $service_name = $cron::params::service_name,
  $service_ensure = 'running',
  $service_enable = true,
) inherits cron::params {

  validate_re($service_ensure, '^(running|stopped)$')
  validate_bool($service_enable)

  anchor { 'cron_first': }
  ->
  class { 'cron::install': } ->
  class { 'cron::service': } ->
  anchor { 'cron_final': }

}
