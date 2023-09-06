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

app_home = node[:pris][:home]

filename = "#{Chef::Config['file_cache_path']}/#{node[:pris][:archive]}"
remote_file filename do
  source node[:pris][:download_url]
  owner 'root'
  group 'root'
  mode 00644
end

directory app_home do
  owner 'root'
  group 'root'
  mode 00755
end

bash 'extract tarball' do
  code "tar -zxvf #{filename} --strip 1 && touch #{app_home}/configured"
  cwd app_home
  not_if{ File.exists?("#{app_home}/configured") }
end

template "#{app_home}/global.properties" do
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

template '/etc/systemd/system/opennms-pris.service' do
  source 'opennms-pris.service.erb'
  owner 'root'
  group 'root'
  mode 00755
  variables(
    app_home: app_home
  )
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  not_if { node['platform_version'].to_i < 7 }
end

template '/etc/init.d/opennms-pris' do
  source 'opennms-pris-v6.service.erb'
  owner 'root'
  group 'root'
  mode 00755
  variables(
    app_home: app_home
  )
  only_if { node['platform_version'].to_i < 7 }
end

execute 'systemctl-daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

service 'opennms-pris' do
  action [:enable, :start]
end

