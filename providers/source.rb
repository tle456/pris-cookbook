#
# Cookbook Name: pris
# Provider: source
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

action :create do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} already exists - checking for changes."
    if @current_resource.changed
      Chef::Log.info "#{@new_resource} has changed - updating."
      converge_by("Update #{ @new_resource}") do
        add_source # same as adding
        new_resource.updated_by_last_action(true)
      end
    else
      Chef::Log.info "#{@new_resource} has not changed - nothing to do."
    end
  else
    Chef::Log.info "#{@new_resource} does not exist - creating."
    converge_by("Create #{ @new_resource}") do
      add_source
      new_resource.updated_by_last_action(true)
    end
  end
end

action :delete do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} exists - deleting."
    converge_by("Delete #{@new_resource}") do
      delete_source
      new_resource.updated_by_last_action(true)
    end
  else
    Chef::Log.info "#{@new_resource} does not exist - nothing to do."
  end
end

action :create_if_missing do
  if @current_resource.exists
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Create #{@new_resource}") do
      add_source
      new_resource.updated_by_last_action(true)
    end
  end
end

def pris
  Opennms::Pris.new(node)
end

def load_current_resource
  @current_resource = Chef::Resource::PrisSource.new(@new_resource.name)
  @current_resource.requisition_name(@new_resource.requisition_name)
  @current_resource.type(@new_resource.type)
  @current_resource.params(@new_resource.params)

  if pris.requisition_exists?(@current_resource.requisition_name)
    @current_resource.requisition_exists = true
    if pris.source_exists?(@current_resource.type, @current_resource.requisition_name)
      @current_resource.exists = true
      if pris.source_changed?(@current_resource.requisition_name, @current_resource.type, @current_resource.params)
        @current_resource.changed = true
      end
    end
  end
end

private

def add_source
  pris.add_requisition_source(new_resource.requisition_name, new_resource.type, new_resource.params)
end

def delete_source
  pris.delete_requisition_source(new_resource.requisition_name, new_resource.params)
end
