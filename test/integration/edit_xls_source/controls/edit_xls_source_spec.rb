
describe pris_requisition('myRouter') do
  its('requisition_name') { should eq 'myRouter' }
  its('source') { should eq 'xls' }
  its('source_properties') { should eq 'file' => '../myInventory.csv', 'count' => '3' }
  its('mapper') { should eq 'echo' }
end
