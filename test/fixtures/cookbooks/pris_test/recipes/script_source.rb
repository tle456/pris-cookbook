include_recipe 'pris::default'

pris_requisition 'create fooscript' do
  requisition_name 'fooscript'
  source 'script'
  source_properties(
    'file' => 'myGroovySource.groovy',
    'count' => '3'
  )
end

cookbook_file "#{node[:pris][:home]}/requisitions/fooscript/myGroovySource.groovy" do
  source 'myGroovySource.groovy'
end

