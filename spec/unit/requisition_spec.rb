#
# Cookbook Name:: opennms-pris
# Spec:: requisition
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'pris_test::requisition' do
  context 'When all attributes are default, on the platform centos 7.8.2003' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.8.2003')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'create requisition myRouter' do
      expect(chef_run).to create_pris_requisition('create myRouter').with(source: 'xls', source_properties: {'file' => '../myInventory.xls'}, requisition_name: 'myRouter')
    end

  end
end
