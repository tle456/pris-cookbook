require 'spec_helper'
require 'helpers'

describe 'xls source based requisition name \'fooxls\'' do
  let(:contents) do
    input = <<-EOL
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<model-import xmlns="http://xmlns.opennms.org/xsd/config/model-import" foreign-source="fooxls">
    <node node-label="dc01" foreign-id="dc01">
        <interface ip-addr="172.16.23.10" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
        <category name="Core-Infrastructure"/>
    </node>
    <node node-label="dc02" foreign-id="dc02">
        <interface ip-addr="172.16.23.10" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
        <category name="Core-Infrastructure"/>
    </node>
    <node node-label="filesrv01" foreign-id="filesrv01">
        <interface ip-addr="172.16.23.11" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
        <interface ip-addr="172.16.23.12" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
        <category name="Core-Infrastructure"/>
        <category name="Core-Infrastructure"/>
    </node>
    <node node-label="exch01" foreign-id="exch01">
        <interface ip-addr="172.16.23.20" snmp-primary="P">
            <monitored-service service-name="ICMP"/>
            <monitored-service service-name="IMAP"/>
            <monitored-service service-name="SMTP"/>
            <monitored-service service-name="SNMP"/>
        </interface>
        <category name="Mail"/>
        <category name="Core-Infrastructure"/>
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

  describe file('/opt/opennms-pris/requisitions/fooxls/requisition.properties') do
    it { should exist }
  end

  describe 'requisition contents' do
    it 'is accurate' do
      expect(requisition('fooxls')).to eq contents 
    end
  end
end
