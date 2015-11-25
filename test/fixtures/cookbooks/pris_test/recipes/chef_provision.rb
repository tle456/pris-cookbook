log 'start opennms' do
  notifies :start, 'service[opennms]', :immediately
end
req = 'localhosts'
opennms_foreign_source req
opennms_import req
%w(127.0.0.1 127.0.0.2 172.0.0.3).each do |host, index|
  opennms_import_node host do
    foreign_source_name req
    foreign_id host
  end
  opennms_import_node_interface host do
    foreign_source_name req
    foreign_id host
    managed true
    snmp_primary 'P'
    sync_import true if index == 2
  end
end
