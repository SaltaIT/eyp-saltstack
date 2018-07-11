require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'saltstack class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'saltstack::minion':
        master => '127.0.0.1'
      }

      class { 'saltstack::master': }

      saltstack::master::fileroot { 'base':
        files => [ '/srv/salt-data/base' ],
      }

      saltstack::master::pillar { 'base':
        files => [ '/srv/salt-data/pillar' ],
      }

      class { 'saltstack::cloud': }

      class { 'saltstack::api': }


      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe file('/etc/salt/master') do
      it { should be_file }
      its(:content) { should match 'puppet managed file' }
    end

    describe file('/etc/salt/cloud') do
      it { should be_file }
      its(:content) { should match 'puppet managed file' }
    end

    describe file('/etc/salt/master.d/salt-api.conf') do
      it { should be_file }
      its(:content) { should match 'puppet managed file' }
    end

    describe file('/etc/salt/minion') do
      it { should be_file }
      its(:content) { should match 'puppet managed file' }
    end

  end
end
