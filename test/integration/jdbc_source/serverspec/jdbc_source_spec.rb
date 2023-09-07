require 'spec_helper'
require 'helpers'

describe 'jdbc source based requisition name \'foojdbc\'' do
  let(:contents) do
    input = <<-EOL
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<model-import xmlns="http://xmlns.opennms.org/xsd/config/model-import" foreign-source="foojdbc">
    <node node-label="jdbc-nodelabel" foreign-id="jdbc-node-fs-id">
        <interface ip-addr="127.0.0.1" status="1" snmp-primary="P"/>
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

  describe file('/opt/opennms-pris/requisitions/foojdbc/requisition.properties') do
    it { should exist }
  end

  describe 'requisition contents' do
    it 'is accurate' do
      expect(requisition('foojdbc')).to eq contents 
    end
  end
end
