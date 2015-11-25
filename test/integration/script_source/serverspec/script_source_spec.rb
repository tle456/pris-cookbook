require 'spec_helper'
require 'helpers'

describe 'script source based requisition name \'fooscript\'' do
  let(:contents) do
    input = <<-EOL
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<model-import xmlns="http://xmlns.opennms.org/xsd/config/model-import" foreign-source="fooscript">
    <node node-label="MyNodeLabel0" foreign-id="MyForeignId0">
        <interface ip-addr="127.0.0.0" status="1" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
            <monitored-service service-name="HTTP"/>
        </interface>
        <asset name="city" value="Fulda"/>
        <asset name="zip" value="36039"/>
        <asset name="country" value="Germany"/>
    </node>
    <node node-label="MyNodeLabel1" foreign-id="MyForeignId1">
        <interface ip-addr="127.0.0.1" status="1" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
            <monitored-service service-name="HTTP"/>
        </interface>
        <asset name="city" value="Fulda"/>
        <asset name="zip" value="36039"/>
        <asset name="country" value="Germany"/>
    </node>
    <node node-label="MyNodeLabel2" foreign-id="MyForeignId2">
        <interface ip-addr="127.0.0.2" status="1" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
            <monitored-service service-name="HTTP"/>
        </interface>
        <asset name="city" value="Fulda"/>
        <asset name="zip" value="36039"/>
        <asset name="country" value="Germany"/>
    </node>
</model-import>
EOL
    doc = REXML::Document.new input
    output = ''
    doc.write output
    output
  end

  describe service('opennms-pris') do
    it { should be_running }
  end

  describe file('/opt/opennms-pris/requisitions/fooscript/requisition.properties') do
    it { should exist }
  end

  describe 'requisition contents' do
    it 'is accurate' do
      expect(requisition('fooscript')).to eq contents 
    end
  end
end
