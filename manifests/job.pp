# Define: cron::job
# Generate a cron job in /etc/cron.d
#
# @example Create a cron job
#   ::cron::job { 'my_job':
#     command  => '/bin/echo "hello"',
#   }
#
# @param [String] command Specifies the command to run in the job (required)
# @param [String] ensure Specifies whether the job should exist or not
# @param [String] minute Specifies the cron style minute the job should run
# @param [String] hour Specifies the cron style hour the should run
# @param [String] day_of_month Specifies the cron style day of the month the job should run
# @param [String] month Specifies the cron style month the job should run
# @param [String] day_of_week Specifies the cron style day of the week the job should run
# @param [String] user Specifies the user the cron job should run as
# @param [String] environment Specifies an array of environment variables for the job in fhe format `ENV=value`
# @param [String] lock Specifies whether the cron job should lock itself using `flock`
# @param [String] monitor_job Specifies whether you want to monitor the job using sensu-wrapper
# @param [String] monitor_ttl Specifies a TTL for the job for sensu-wrapper
# @param [String] monitor_source Specifies a TTL for the job for sensu-wrapper
# @param [String] monitor_timeout Specifies a timeout for sensu-wrapper before the job should halt and fail
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
