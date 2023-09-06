#
# Cookbook Name: pris
# Resource: requisition
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

provides :pris_requisition

property :name, String,  name_property: true
property :requisition_name, String
property :source, String, default: 'file', equal_to: ['file', 'http', 'jdbc', 'merge', 'script', 'xls', 'ocs.computers', 'ocs.devices']
property :source_properties, Hash, default: {}
property :mapper, String, default: 'echo', equal_to: ['echo', 'null', 'ocs.computers', 'ocs.devices', 'script']
property :mapper_properties, Hash, default: {}
property :script_file, Array, default: []


action :create do
    req_name = new_resource.requisition_name || new_resource.name
    directory req_dir(req_name) do
        owner 'root'
        group 'root'
        mode '0755'
        action :create
    end

    new_content = prop_content
    file req_props_path(req_name) do
        content new_content
        mode 0644
        action :create
    end
end

action :create_if_missing do
    req_name = new_resource.requisition_name || new_resource.name
    directory req_dir(req_name) do
        owner 'root'
        group 'root'
        mode '0755'
        action :create
        not_if { ::File.directory?(req_dir(req_name)) }
    end

    new_content = prop_content
    file req_props_path(req_name) do
        content new_content
        mode 0644
        action :create_if_missing
    end
end

action :delete do
    req_name = new_resource.requisition_name || new_resource.name
    directory req_dir(req_name) do
        recursive true 
        action :delete
    end
end

action_class do
    def pris_home
        node[:pris][:home]
    end
  
    def req_dir(req_name)
        "#{pris_home}/requisitions/#{req_name}"
    end
  
    def req_props_path(req_name)
        "#{pris_home}/requisitions/#{req_name}/requisition.properties"
    end
  
    def prop_content()
        ret = "source=#{new_resource.source}\n"
        new_resource.source_properties.each do |key, value|
            ret += "source.#{key}=#{value}\n"
        end
  
        ret += "\nmapper=#{new_resource.mapper}\n"
        new_resource.mapper_properties.each do |key, value|
            ret += "mapper.#{key}=#{value}\n"
        end
  
        new_resource.script_file.each do |value|
            ret += "script.file=#{new_resource.script_file.join(',')}\n"
        end
        ret
    end
end
  
