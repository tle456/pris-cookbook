if defined?(ChefSpec)
  def create_pris_requisition(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pris_requisition, :create, name)
  end

  def delete_pris_requisition(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pris_requisition, :delete, name)
  end

  def create_if_missing_pris_requisition(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pris_requisition, :create_if_missing, name)
  end
end
