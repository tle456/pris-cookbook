include_recipe 'pris_test::postgres'
include_recipe 'opennms::notemplates'
bash 'set java alternatives to auto' do 
  code 'alternatives --auto java; alternatives --auto javac' 
end 
include_recipe 'pris_test::chef_provision'
include_recipe 'pris::default'

pris_requisition 'foohttp'

pris_source 'httpbar' do
  requisition_name 'foohttp'
  type 'http'
  params(
    'source.url' => 'http://localhost:8980/opennms/rest/requisitions/localhosts',
    'source.username' => 'admin',
    'source.password' => 'admin'
  )
end

pris_mapper 'httpbar' do
  requisition_name 'foohttp'
  type 'echo'
end
