include_recipe 'pris::default'
include_recipe 'pris_test::file_source'
include_recipe 'pris_test::http_source'

pris_requisition 'create foomerge' do
  requisition_name 'foomerge'
  source 'merge'
  source_properties(
    'A.url' => 'http://localhost:8000/requisitions/foo',
    'A.keepAll' => 'false',
    'B.url' => 'http://localhost:8000/requisitions/foohttp',
    'B.keepAll' => 'true'
  )
end
