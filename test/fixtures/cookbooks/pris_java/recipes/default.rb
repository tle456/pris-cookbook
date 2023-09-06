if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 6
  execute 'install corretto GPG key' do
    command 'rpm --import https://yum.corretto.aws/corretto.key'
    not_if { ::File.exists?('/etc/yum.repos.d/corretto.repo') }
  end
  execute 'install corretto yum repo' do
    command 'curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo'
    not_if { ::File.exists?('/etc/yum.repos.d/corretto.repo') }
  end
  yum_package 'java-11-amazon-corretto-devel'
else
  openjdk_pkg_install node['java']['jdk_version']
end
