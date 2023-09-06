#
# Cookbook Name:: opennms-pris
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'pris::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.8.2003')
      runner.converge(described_recipe)
    end

    it 'downloads pris' do
      expect(chef_run).to create_remote_file("#{Chef::Config['file_cache_path']}/opennms-pris-release-2.0.0-b1051.tar.gz").with(source: 'https://github.com/OpenNMS/opennms-provisioning-integration-server/releases/download/2.0.0-b1051/opennms-pris-release-2.0.0-b1051.tar.gz')
    end

    it 'creates a template with the global.properties' do
      expect(chef_run).to create_template("/opt/opennms-pris/global.properties")
    end

    it 'create pris home directory' do
      expect(chef_run).to create_directory('/opt/opennms-pris')
    end

    it 'start opennms-pris service' do
      expect(chef_run).to start_service('opennms-pris')
    end

    it 'enable opennms-pris service' do
      expect(chef_run).to enable_service('opennms-pris')
    end

    it 'creates a template with the opennms-pris.service' do
      expect(chef_run).to create_template("/etc/systemd/system/opennms-pris.service")
    end

  end

  context 'When all attributes are default, on the platform centos 6.10' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '6.10')
      runner.converge(described_recipe)
    end

     it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a template with the opennms-pris-v6.service' do
      expect(chef_run).to create_template("/etc/init.d/opennms-pris")
    end
  end
end
