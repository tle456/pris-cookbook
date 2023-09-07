bash 'remove DST Root CA X3 from Chef\'s cacert file' do
  code <<-EOH
  c=$(grep -n "DST Root CA X3" /opt/chef/embedded/ssl/certs/cacert.pem | cut -d ':' -f 1)
  let e=c+19
  sed -i -e "${c},${e}d" /opt/chef/embedded/ssl/certs/cacert.pem
  EOH
  only_if 'grep -q "DST Root CA X3" /opt/chef/embedded/ssl/certs/cacert.pem'
end
node.default['postgresql']['version'] = '11'
node.default['postgresql']['password']['postgres'] = 'md5c23797e9a303da48b792b4339c426700'
postgresql_client_install 'PostgreSQL Client' do
  version node['postgresql']['version']
end
postgresql_server_install 'package' do
  password node['postgresql']['password']['postgres']
  version node['postgresql']['version']
  setup_repo false
  action [:install, :create]
end
find_resource(:service, 'postgresql') do
  extend PostgresqlCookbook::Helpers
  service_name(lazy { platform_service_name })
  supports restart: true, status: true, reload: true
  action [:enable, :start]
end
postgresql_server_conf 'PostgreSQL Config' do
  notifies :reload, 'service[postgresql]'
end
postgresql_user 'opennms' do
  superuser true
  createdb true
end
postgresql_database 'opennms' do
  owner 'opennms'
end
