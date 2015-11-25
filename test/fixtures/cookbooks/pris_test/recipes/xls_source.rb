include_recipe 'pris::default'

pris_requisition 'fooxls'

cookbook_file "#{node[:pris][:home]}/requisitions/fooxls/myInventory.xls" do
  source 'myInventory.xls'
end

pris_source 'foobar' do
  requisition_name 'fooxls'
  type 'xls'
  params(
    'source.file' => 'myInventory.xls'
  )
end

pris_mapper 'foobar' do
  requisition_name 'fooxls'
  type 'echo'
end
