# Class to install cron
class cron::install {

  package { $cron::package_name:
    ensure    => $cron::package_ensure,
  }

}
