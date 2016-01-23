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

  context 'defaults' do
    it { should compile }
  end

end

