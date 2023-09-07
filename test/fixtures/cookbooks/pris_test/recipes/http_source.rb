include_recipe 'pris::default'
include_recipe 'pris_test::apache'

pris_requisition 'create foohttp' do
  requisition_name 'foohttp'
  source 'http'
  source_properties(
    'url' => 'http://localhost/'
  )
end
