package 'httpd'
app_dir = '/var/www/html'

file "#{app_dir}/index.html" do
  content <<-EOL
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<model-import xmlns="http://xmlns.opennms.org/xsd/config/model-import" foreign-source="localhosts">
    <node node-label="127.0.0.1" foreign-id="127.0.0.1">
        <interface ip-addr="127.0.0.1" managed="true" snmp-primary="P"/>
    </node>
    <node node-label="127.0.0.2" foreign-id="127.0.0.2">
        <interface ip-addr="127.0.0.2" managed="true" snmp-primary="P"/>
    </node>
    <node node-label="172.0.0.3" foreign-id="172.0.0.3">
        <interface ip-addr="172.0.0.3" managed="true" snmp-primary="P"/>
    </node>
</model-import>
EOL
  action :create
end

service 'httpd' do
  action [:enable, :start]
end
