describe pris_requisition('foo') do
  its('requisition_name') { should eq 'foo' }
  its('source') { should eq 'file' }
  its('source_properties') { should eq 'file' => 'foobar.xml' }
  its('mapper') { should eq 'echo' }
end

# describe file('/opt/opennms-pris/requisitions/foo/foobar.xml') do
#   its{ should exist }
# end
