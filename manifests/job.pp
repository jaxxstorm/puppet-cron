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
) {

  file { "/etc/cron.d/job_${title}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    content => template('cron/job.erb'),
  }

}
