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
