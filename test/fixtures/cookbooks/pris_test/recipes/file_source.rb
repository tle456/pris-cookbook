include_recipe 'pris::default'

pris_requisition 'foo'

cookbook_file "#{node[:pris][:home]}/requisitions/foo/foobar.xml" do
  source 'foobar.xml'
end

pris_source 'foobar' do
  requisition_name 'foo'
  type 'file'
  params(
    'source.file' => 'foobar.xml'
  )
end

pris_mapper 'foobar' do
  requisition_name 'foo'
  type 'echo'
end
