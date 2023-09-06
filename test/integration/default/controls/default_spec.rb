# frozen_string_literal: true
describe 'pris::default' do
  it 'installs opennms-pris' do
    expect(file('/opt/opennms-pris')).to be_directory
  end
end
describe service('opennms-pris') do
  it { should be_enabled }
  it { should be_installed }
  it { should be_running }
end
