# Private params class
class cron::params {

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $package_name = 'cronie'
      $service_name = 'crond'
    }
    'Debian', 'Ubuntu': {
      $package_name = 'cron'
      $service_name = 'cron'
    }
    default: { fail('Unsupported OS') }
  }

}
