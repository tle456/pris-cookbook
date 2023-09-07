include_recipe 'pris::default'

pris_requisition 'create foo' do
  requisition_name 'foo'
  source 'file'
  source_properties(
    'file' => 'foobar.xml'
  )
end

cookbook_file "#{node[:pris][:home]}/requisitions/foo/foobar.xml" do
  source 'foobar.xml'
end

