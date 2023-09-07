include_recipe "pris::default"

pris_requisition 'create myRouter' do
  action :create
  requisition_name 'myRouter'
  source 'xls'
  source_properties 'file' => "../myInventory.xls"
end

pris_requisition 'create myServer' do
  action :create
  requisition_name 'myServer'
  source 'xls'
  source_properties 'file' => "../myInventory.xls"
end
