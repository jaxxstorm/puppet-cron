# Sets up cron defaults
class cron (
  $enabled = true,
  $package_name = 'cronie',
  $package_ensure = 'latest',
  $service_name = 'crond',
  $service_ensure = 'running',
  $service_enable = true,
) {

  package { $package_name:
    ensure => $package_ensure,
  } ->
  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

}
