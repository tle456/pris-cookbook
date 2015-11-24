default[:pris][:home] = '/opt/opennms-pris'
default[:pris][:version] = '1.1.4'
default[:pris][:archive] = "opennms-pris-dist-#{node[:pris][:version]}-release-archive.tar.gz"
default[:pris][:download_url] = "https://github.com/OpenNMS/opennms-provisioning-integration-server/releases/download/#{node[:pris][:version]}/#{node[:pris][:archive]}"
default[:pris][:global] = {
  driver: 'http',
  host: '0.0.0.0',
  port: 8000
}
