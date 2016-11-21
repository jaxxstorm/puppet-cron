require 'spec_helper'

describe 'cron::job', :type => 'define'  do

  context 'with title set' do
    let(:title) { 'test' } # Set the default defined type title

    context 'with ensure => absent' do
      let(:params) { { :ensure => 'absent', :command => '/bin/true' } }
      it { should contain_file('/etc/cron.d/job_test').with_ensure('absent') }
    end # Ensure ensure absent check

    context 'basic cronjob' do
      let(:params) {{ 
        :command      => '/bin/true',
        :minute       => '10',
        :hour         => '8',
        :day_of_month => '8',
        :month        => '10',
        :day_of_week  => '5',
        :user         => 'nobody',
      }}
      it { should contain_file('/etc/cron.d/job_test').with({
        'owner' => 'root',
        'group' => 'root'
      }).with_content(/10 8 8 10 5 nobody \/bin\/true/)
      }
    end # End basic cronjob

    context 'setting environment' do
      let(:params) {{
        :command => '/bin/true',
        :environment => [ 'MAILTO=""', 'PATH="/usr/local/bin"' ]
      }}
      it { should contain_file('/etc/cron.d/job_test').with_content(/MAILTO=""\nPATH="\/usr\/local\/bin"/ )}
    end # End setting environment vars

    context 'with locking' do
      let(:params) {{
        :command => '/bin/true',
        :lock    => true,
      }}
      it { should contain_file('/etc/cron.d/job_test').with_content(/flock -n "\/var\/lock\/test.lock" \/bin\/true/) }
    end

    context 'with monitoring' do
      let(:params) {{
        :command     => '/bin/true',
        :monitor_job => true,
      }}
      it { is_expected.to contain_class('sensu_wrapper') }
      it { should contain_file('/etc/cron.d/job_test').with_content(/\/usr\/local\/bin\/sensu-wrapper -n "cron_test" \/bin\/true/) }
    end

    context 'monitoring with options' do
      let(:params) {{
        :command          => '/bin/true',
        :monitor_job      => true,
        :monitor_ttl      => 10,
        :monitor_source   => 'mysource',
        :monitor_timeout  => 20,
      }}
      it { is_expected.to contain_class('sensu_wrapper') }
      it { should contain_file('/etc/cron.d/job_test').with_content(/\/usr\/local\/bin\/sensu-wrapper -n "cron_test" -t 10 -s "mysource" -T 20 \/bin\/true/) }
    end

    context 'with monitoring and locking' do
      let(:params) {{
        :command     => '/bin/true',
        :monitor_job => true,
        :lock        => true,
      }}
      it { is_expected.to contain_class('sensu_wrapper') }
      it { should contain_file('/etc/cron.d/job_test').with_content(/flock -n "\/var\/lock\/test.lock" \/usr\/local\/bin\/sensu-wrapper -n "cron_test" \/bin\/true/) }
    end

  end # End default title context

end
