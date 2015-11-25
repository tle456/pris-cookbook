require 'spec_helper'
require 'helpers'

describe 'merge source based requisition name \'foomerge\'' do
  let(:contents) do
    input = <<-EOL
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<model-import xmlns="http://xmlns.opennms.org/xsd/config/model-import" foreign-source="foomerge">
    <node node-label="172.0.0.3" foreign-id="172.0.0.3">
        <interface ip-addr="172.0.0.3" managed="true" snmp-primary="P"/>
    </node>
    <node node-label="127.0.0.2" foreign-id="127.0.0.2">
        <interface ip-addr="127.0.0.2" managed="true" snmp-primary="P"/>
    </node>
    <node node-label="127.0.0.1" foreign-id="127.0.0.1">
        <interface ip-addr="127.0.0.1" managed="true" snmp-primary="P"/>
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

  describe file('/opt/opennms-pris/requisitions/foomerge/requisition.properties') do
    it { should exist }
  end

  describe 'requisition contents' do
    it 'is accurate' do
      expect(requisition('foomerge')).to eq contents 
    end
  end
end
