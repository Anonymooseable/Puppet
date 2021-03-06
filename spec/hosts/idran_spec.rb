require 'spec_helper'
require 'shared_context.rb'

describe 'idran.geeksoc.org' do
    include_context "centos node"
  let(:node) { 'idran.geeksoc.org' }
  
  it {should compile}
  
  it { should contain_service('sshd') }
  
  it { should contain_mount('/home') }
  
  it { should contain_custom__apache__website('geeksoc.org') }

  
  it do
       should_not contain_file('/etc/ssh/sshd_config') \
       .with_content(/AllowGroups.*members/)
  end
  
  it { should contain_package('mysql-server') }
     
  it do
      should_not contain_file('/etc/ssh/sshd_config') \
      .with_content(/AllowGroups.*(sysadmin-apprentice)/)
  end
    
  it do
      should contain_file('/etc/ssh/sshd_config') \
      .with_content(/AllowGroups.*sysadmin([^-]|$)/)
  end
end
