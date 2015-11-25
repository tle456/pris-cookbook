include_recipe 'pris::default'
include_recipe 'pris_test::file_source'
include_recipe 'pris_test::http_source'

pris_requisition 'foomerge'

pris_source 'foobar' do
  requisition_name 'foomerge'
  type 'merge'
  params(
    'source.A.url' => 'http://localhost:8000/requisitions/foo',
    'source.A.keepAll' => 'false',
    'source.B.url' => 'http://localhost:8000/requisitions/foohttp',
    'source.B.keepAll' => 'false'
  )
end

pris_mapper 'foobar' do
  requisition_name 'foomerge'
  type 'echo'
end
