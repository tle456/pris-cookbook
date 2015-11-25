require 'spec_helper'
require 'java-properties'

describe 'pris_test::file_source' do
  let(:file_source_run) do
    ChefSpec::SoloRunner.new(
      step_into: ['pris_requisition', 'pris_source', 'pris_mapper']
    ).converge(described_recipe)
  end
  
  before do
    empty_file = "#{File.expand_path File.dirname(__FILE__)}/../../test/fixtures/files/empty_requisition.properties"
    sourced_contents = "source=file\nsource.file=foobar.xml"
    mapped_contents = "source=file\nsource.file=foobar.xml\nmapper=echo"
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('/opt/opennms-pris/requisitions/foo/requisition.properties').and_return(false)
    allow(File).to receive(:open).and_call_original
    allow(File).to receive(:open).with('/opt/opennms-pris/requisitions/foo/requisition.properties', "r:bom|utf-8").and_return(JavaProperties.load(File.open(empty_file, "r:bom|utf-8")))
    allow(File).to receive(:write).and_call_original
    allow(File).to receive(:write).with('/opt/opennms-pris/requisitions/foo/requisition.properties', sourced_contents).and_return(46)
    allow(File).to receive(:write).with('/opt/opennms-pris/requisitions/foo/requisition.properties', mapped_contents).and_return(46)
  end

  context 'creating a file source requisition with echo mapper' do
    it 'includes default pris recipe' do
      expect(file_source_run).to include_recipe('pris::default')
    end

    it 'creates pris_requisition[foo]' do
      expect(file_source_run).to create_pris_requisition('foo')
    end

    it 'creates source file' do
      expect(file_source_run).to create_cookbook_file('/opt/opennms-pris/requisitions/foo/foobar.xml')
    end

    it 'steps into pris_source and creates the source' do
      expect(file_source_run).to create_pris_source('foobar')
    end

    it 'steps into pris_mapper and creates echo mapper' do
      expect(file_source_run).to create_pris_mapper('foobar')
    end
  end
end
