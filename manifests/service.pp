# Managed the crond service
class cron::service {


  service { $cron::service_name:
    ensure => $cron::service_ensure,
    enable => $cron::service_enable,
  }


}
