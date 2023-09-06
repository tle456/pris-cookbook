#
# Cookbook Name:: opennms-pris
# Recipe:: default
#
# Copyright (c) 2015 ConvergeOne Holdings Corp.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# chef_gem 'java-properties' do
#  compile_time true
# end

filename = "#{Chef::Config['file_cache_path']}/#{node[:pris][:archive]}"
remote_file filename do
  source node[:pris][:download_url]
  owner 'root'
  group 'root'
  mode 00644
end

directory node[:pris][:home] do
  owner 'root'
  group 'root'
  mode 00755
end

bash 'extract tarball' do
  code "tar -zxvf #{filename} --strip 1 && touch #{node[:pris][:home]}/configured"
  cwd node[:pris][:home]
  not_if{ File.exists?("#{node[:pris][:home]}/configured") }
end

template "#{node[:pris][:home]}/global.properties" do
  source 'global.properties.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    driver: node[:pris][:global][:driver],
    host: node[:pris][:global][:host],
    port: node[:pris][:global][:port]
  )
end

if platform_family?('rhel') && (Chef::VersionConstraint.new("~> 5.0").include?(node[:platform_version]) || Chef::VersionConstraint.new("~> 6.0").include?(node[:platform_version]))
  remote_file "Copy opennms-pris service file" do
    path '/etc/init.d/opennms-pris'
    source node[:pris][:service_url]
    owner 'root'
    group 'root'
    mode 00755
  end
  if node[:pris][:global][:driver] == 'http'
    service 'opennms-pris' do
      supports :status => true, :restart => false, :reload => false
      action [:enable, :start]
    end
  end
end
