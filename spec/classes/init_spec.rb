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


end

