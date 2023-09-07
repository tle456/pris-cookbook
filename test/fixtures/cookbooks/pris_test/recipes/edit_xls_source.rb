include_recipe 'pris_test::xls_source'

pris_requisition 'edit myRouter' do
  requisition_name 'myRouter'
  source 'xls'
  source_properties(
    'file' => '../myInventory.csv',
    'count' => '3'
  )
end
