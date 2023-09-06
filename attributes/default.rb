default[:pris][:home] = '/opt/opennms-pris'
default[:pris][:version] = '2.0.0-b1051'
default[:pris][:archive] = "opennms-pris-release-#{node[:pris][:version]}.tar.gz"
default[:pris][:download_url] = "https://github.com/OpenNMS/opennms-provisioning-integration-server/releases/download/#{node[:pris][:version]}/#{node[:pris][:archive]}"
default[:pris][:service_url] = "https://raw.githubusercontent.com/dschlenk/opennms-provisioning-integration-server/PRIS-132/opennms-pris-dist/src/main/resources/opennms-pris.service"default[:pris][:service_url] = "https://raw.githubusercontent.com/dschlenk/opennms-provisioning-integration-server/PRIS-132/opennms-pris-dist/src/main/resources/opennms-pris.service"
default[:pris][:global] = {
  driver: 'http',
  host: '0.0.0.0',
  port: 8000
}
