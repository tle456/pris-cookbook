# frozen_string_literal: true
require 'java-properties'
class PrisRequisition < Inspec.resource(1)
  name 'pris_requisition'

  desc '
    OpenNMS PRIS Requisition
  '

  example '
    describe pris_requisition(\'myRouter\') do
      its(\'source\') { should eq \'xls\' }
      its(\'source_properties\') { should eq \'file\' => \'../myInventory.xls\' }
      its(\'mapper\') { should eq \'echo\' }
    end
  '

  def initialize(req_name)
    puts "ehlo"
    @requisition_name = req_name
    requisition_file = "/opt/opennms-pris/requisitions/#{@requisition_name}/requisition.properties"
    props = JavaProperties.parse(inspec.file(requisition_file).content)
    @source = props[:'source'].to_s
    @mapper = props[:'mapper'].to_s
    @source_properties = {}
    @mapper_properties = {}
    props.each do |k,v|
      source_properties[k.to_s[7..-1]] = v if k.to_s.start_with?('source.')
      mapper_properties[k.to_s[7..-1]] = v if k.to_s.start_with?('mapper.')
    end
    @script_file = []
    @script_file = props[:'script_file'].split(',') unless props[:'script_file'].nil?
  end

  attr_reader :requisition_name

  attr_reader :source

  attr_reader :source_properties

  attr_reader :mapper

  attr_reader :mapper_properties

  attr_reader :script_file

  private

end
