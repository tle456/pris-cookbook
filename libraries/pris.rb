
module Opennms
  class Pris
    def initialize(node)
      @node = node
    end

    def requisition_exists?(requisition_name)
      Chef::Log.info "Checking for file #{requisition_file_path(requisition_name)}"
      ::File.exist? requisition_file_path(requisition_name)
    end

    def requisition_file(requisition_name)
      require 'java-properties'
      props = JavaProperties.load(requisition_file_path(requisition_name))
      Chef::Log.info "props: #{props}"
      props
    end

    def requisition_file_path(requisition_name)
      "#{@node[:pris][:home]}/requisitions/#{requisition_name}/requisition.properties"
    end

    def script_file_path(name)
      "#{@node[:pris][:home]}/scriptsteps/#{name}"
    end

    def thing_exists?(type, requisition_name, symbol)
      properties = requisition_file(requisition_name)
      properties[symbol] == type
    end

    def source_exists?(type, requisition_name)
      thing_exists?(type, requisition_name, :source)
    end

    def mapper_exists?(type, requisition_name)
      thing_exists?(type, requisition_name, :mapper)
    end

    def scriptstep_exists?(name, requisition_name)
      properties = requisition_file(requisition_name)
      scripts = properties[:'script.file'].split(/\s*,\s*/)
      scripts.include?(name) && ::File.exist?(script_file_path(name))
    end

    def thing_changed?(requisition_name, type, params, thing)
      properties = requisition_file(requisition_name)
      existing_params = {}
      properties.each do |key, value|
        existing_params[key.to_s] = properties[key] if key.to_s.start_with? thing
      end
      Chef::Log.debug "current params: #{existing_params}; params in resource: #{params}"
      !existing_params.eql? params
    end

    def source_changed?(requisition_name, type, params)
      thing_changed?(requisition_name, type, params, 'source.')
    end

    def mapper_changed?(requisition_name, type, params)
      thing_changed?(requisition_name, type, params, 'mapper.')
    end

    def add_thing(thing, requisition_name, type, params)
      require 'java-properties'
      props = requisition_file(requisition_name)
      Chef::Log.info "props: #{props}"
      props[thing] = type
      params.each do |key, value|
        props[key.to_sym] = value
      end
      JavaProperties.write(props, requisition_file_path(requisition_name))
    end

    def add_requisition_source(requisition_name, type, params)
      add_thing(:source, requisition_name, type, params)
    end

    def delete_thing(thing, requisition_name, params)
      require 'java-properties'
      props = requisition_file(requisition_name)
      props.delete(thing)
      params.each do |key, value|
        props.delete(key.to_sym)
      end
      JavaProperties.write(props, requisition_file_path(requisition_name))
    end

    def delete_requisition_source(requisition_name, params)
      delete_thing(:source, requisition_name, params)
    end

    def add_requisition_mapper(requisition_name, type, params)
      add_thing(:mapper, requisition_name, type, params) 
    end

    def delete_requisition_mapper(requisition_name, params)
      delete_thing(:mapper, requisition_name, params)
    end

    def add_requisition_scriptstep
    end

    def delete_requisition_scriptstep
    end
  end
end
