if defined?(ChefSpec)
  def create_pris_requisition(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pris_requisition, :create, name)
  end

  def delete_pris_requisition(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pris_requisition, :delete, name)
  end

  def create_pris_source(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pris_source, :create, name)
  end

  def create_pris_mapper(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pris_mapper, :create, name)
  end
end
