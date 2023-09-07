include_recipe 'pris::default'
include_recipe 'pris_test::minimal_postgres'

pris_requisition 'create foojdbc' do
  requisition_name 'foojdbc'
  source 'jdbc'
  source_properties(
    'driver' => 'org.postgresql.Driver',
    'url' => 'jdbc:postgresql://localhost:5432/opennms',
    'user' => 'opennms',
    'password' => 'opennms',
    'selectStatement' => 'SELECT \'jdbc-node-fs-id\' AS Foreign_Id, \'jdbc-nodelabel\' AS Node_Label, \'127.0.0.1\' AS IP_Address, \'P\' AS MgmtType, 1 AS InterfaceStatus'
  )
end
