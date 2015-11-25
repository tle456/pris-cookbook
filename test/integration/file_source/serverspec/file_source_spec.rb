require 'spec_helper'
require 'helpers'
require 'rexml/document'

describe 'file source based requisition name \'foo\'' do
  let(:contents) do
    input = <<-EOL
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<model-import xmlns="http://xmlns.opennms.org/xsd/config/model-import" foreign-source="default">
    <node node-label="router1" foreign-id="1351706322157649000">
        <interface ip-addr="10.10.0.2" descr="" status="1" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
    </node>
    <node node-label="router2" foreign-id="1351706322158209000">
        <interface ip-addr="10.10.0.3" descr="" status="1" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
    </node>
    <node node-label="router3" foreign-id="1351706322158745000">
        <interface ip-addr="10.10.0.4" descr="" status="1" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
    </node>
    <node node-label="router4" foreign-id="1351706322159276000">
        <interface ip-addr="10.10.0.5" descr="" status="1" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
    </node>
    <node node-label="router5" foreign-id="1351706322159854000">
        <interface ip-addr="10.10.0.6" descr="" status="1" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
    </node>
</model-import>
EOL
    doc = REXML::Document.new(input)
    output = ""
    doc.write output
    output
  end

  describe service('opennms-pris') do
    it { should be_running }
  end

  describe file('/opt/opennms-pris/requisitions/foo/requisition.properties') do
    it { should exist }
  end

  describe 'requisition contents' do
    it 'is accurate' do
      expect(requisition('foo')).to eq contents 
    end
  end
end
