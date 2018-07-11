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


      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe file('/etc/salt/master') do
      it { should be_file }
      its(:content) { should match 'puppet managed file' }
      its(:content) { should match 'hash_type: sha256' }
      its(:content) { should match 'file_roots:' }
      its(:content) { should match '- /srv/salt-data/base' }
      its(:content) { should match 'pillar_roots:' }
      its(:content) { should match '- /srv/salt-data/pillar' }
      its(:content) { should match 'interface: 0.0.0.0' }
      its(:content) { should match 'publish_port: 4505' }
      its(:content) { should match 'keep_jobs: 170' }
      its(:content) { should match 'max_event_size: 10485760' }
    end

    describe file('/etc/salt/minion') do
      it { should be_file }
      its(:content) { should match 'puppet managed file' }
      its(:content) { should match 'hash_type: sha256' }
    end

  end
end
