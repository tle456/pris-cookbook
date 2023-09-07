describe pris_requisition('myRouter') do
  its('requisition_name') { should eq 'myRouter' }
  its('source') { should eq 'xls' }
  its('source_properties') { should eq 'file' => '../myInventory.xls' }
  its('mapper') { should eq 'echo' }
end

describe pris_requisition('myServer') do
  its('requisition_name') { should eq 'myServer' }
  its('source') { should eq 'xls' }
  its('source_properties') { should eq 'file' => '../myInventory.xls' }
  its('mapper') { should eq 'echo' }
end
