# Define: cron::job
# 
# Generate a cron job in /etc/cron.d
define cron::job (
  $command,
  $ensure = 'present',
  $minute = '*',
  $hour = '*',
  $day_of_month = '*',
  $month = '*',
  $day_of_week = '*',
  $user = 'root',
  $environment = [],
  $lock = false,
  $monitor_job = undef,
  $monitor_ttl = undef,
  $monitor_source = undef,
  $monitor_timeout = undef,
) {

  if $monitor_job {
    validate_bool($monitor_job)

    include ::sensu_wrapper
    if $monitor_ttl {
      validate_integer($monitor_ttl)
    }
    if $monitor_timeout {
      validate_integer($monitor_timeout)
    }
  }

  file { "/etc/cron.d/job_${title}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    content => template('cron/job.erb'),
  }

}
