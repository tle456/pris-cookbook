contrib = value_for_platform(%w(centos redhat xenserver) => {
                               '>= 7.0' => 'cr',
                               :default => 'contrib',
                             })

default['yum-centos']['repos'] = %W(
  base
  updates
  extras
  centosplus
  fasttrack
  #{contrib}
)

if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 6
  default['yum']['base']['mirrorlist'] = nil
  default['yum']['updates']['mirrorlist'] = nil
  default['yum']['extras']['mirrorlist'] = nil
end
