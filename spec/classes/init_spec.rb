require 'spec_helper'

describe 'cron', :type => :class do

  RSpec.configure do |c|
    c.default_facts = {
      :architecture           => 'x86_64',
      :operatingsystem        => 'CentOS',
      :osfamily               => 'RedHat',
      :operatingsystemrelease => '6.6',
      :kernel                 => 'Linux',
    }
  end

  # defaults
  context 'defaults' do
    it { should compile }
  end
  
  context "should install cron package" do
    it { should contain_package('cronie').with(:ensure => 'latest') }
  end

  context "should ensure service running" do
    it { should contain_service('crond').with(:ensure => 'running', :enable => true) }
  end

  context "should ensure crontab exists" do
    it { should contain_file('/etc/crontab').with(:ensure => 'file', :owner=> 'root', :group => 'root', :mode => '0600') }
  end

  context "should ensure directories exist" do
    it { should contain_file('/etc/cron.d').with(:ensure => 'directory', :owner=> 'root', :group => 'root', :mode => '0700') }
    it { should contain_file('/etc/cron.hourly').with(:ensure => 'directory', :owner=> 'root', :group => 'root', :mode => '0700') }
    it { should contain_file('/etc/cron.daily').with(:ensure => 'directory', :owner=> 'root', :group => 'root', :mode => '0700') }
    it { should contain_file('/etc/cron.weekly').with(:ensure => 'directory', :owner=> 'root', :group => 'root', :mode => '0700') }
    it { should contain_file('/etc/cron.monthly').with(:ensure => 'directory', :owner=> 'root', :group => 'root', :mode => '0700') }
  end

  context "with purge enabled" do
    let(:params) {{
      :purge => true
    }}
    it { should contain_file('/etc/cron.d').with(:ensure => 'directory', :owner=> 'root', :group => 'root', :mode => '0700', :recurse => true, :purge => true) }
  end


end

