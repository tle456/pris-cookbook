#
# Cookbook Name: pris
# Provider: requisition
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
def whyrun_supported?
    true
end

use_inline_resources

def pris
  Opennms::Pris.new(node)
end

action :create do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    Chef::Log.info "#{@new_resource} does not exist - creating."
    converge_by("Create #{@new_resource}") do
      add_requisition
      new_resource.updated_by_last_action(true)
    end
  end
end

action :delete do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} exists - deleting."
    converge_by("Delete #{@new_resource}") do
      delete_requisition
      new_resource.updated_by_last_action(true)
    end
  else
    Chef::Log.info "#{@new_resource} does not exist - nothing to do."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::PrisRequisition.new(@new_resource.name)
  @current_resource.name(@new_resource.name)

  if pris.requisition_exists?(@current_resource.name)
    @current_resource.exists = true
  end
end

private 

def add_requisition
  directory "#{node[:pris][:home]}/requisitions/#{new_resource.name}" do
    owner 'root'
    user 'root'
    mode 00644
  end
  bash "touch #{pris.requisition_file_path(new_resource.name)}" do
    code "touch #{pris.requisition_file_path(new_resource.name)}"
    not_if { ::File.exist?(pris.requisition_file_path(new_resource.name)) }
  end
end

def delete_requisition
  directory "#{@node[:pris][:home]}/#{new_resource.name}" do
    recursive true
    action :delete
  end
end
