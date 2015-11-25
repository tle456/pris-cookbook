include_recipe 'pris::default'

pris_requisition 'fooscript'

cookbook_file "#{node[:pris][:home]}/requisitions/fooscript/myGroovySource.groovy" do
  source 'myGroovySource.groovy'
end

pris_source 'foobar' do
  requisition_name 'fooscript'
  type 'script'
  params(
    'source.file' => 'myGroovySource.groovy',
    'source.count' => '3'
  )
end

pris_mapper 'foobar' do
  requisition_name 'fooscript'
  type 'echo'
end
