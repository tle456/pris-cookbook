include_recipe 'pris::default'

pris_requisition 'foohttp'

pris_source 'httpbar' do
  requisition_name 'foohttp'
  type 'http'
  params(
    'source.url' => 'http://demo.opennms.org/opennms/rest/requisitions',
    'source.username' => 'demo',
    'source.password' => 'demo'
  )
end

pris_mapper 'httpbar' do
  requisition_name 'foohttp'
  type 'echo'
end
