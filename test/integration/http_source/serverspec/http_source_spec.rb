require 'spec_helper'
require 'helpers'

describe 'file source based requisition name \'foo\'' do
  let(:contents) do
<<-EOL
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<model-import xmlns="http://xmlns.opennms.org/xsd/config/model-import" date-stamp="2015-11-25T20:36:44.789Z" foreign-source="localhosts">
    <node node-label="127.0.0.1" foreign-id="127.0.0.1">
        <interface ip-addr="127.0.0.1" managed="true" snmp-primary="P"/>
    </node>
    <node node-label="127.0.0.2" foreign-id="127.0.0.2">
        <interface ip-addr="127.0.0.2" managed="true" snmp-primary="P"/>
    </node>
    <node node-label="172.0.0.3" foreign-id="172.0.0.3">
        <interface ip-addr="172.0.0.3" managed="true" snmp-primary="P"/>
    </node>
</model-import>
EOL
 
  end

  describe service('opennms-pris') do
    it { should be_running }
  end

  describe file('/opt/opennms-pris/requisitions/foohttp/requisition.properties') do
    it { should exist }
  end

  describe 'requisition contents' do
    it 'is accurate' do
      expect(requisition('foohttp').to_str).to eq contents 
    end
  end
end
