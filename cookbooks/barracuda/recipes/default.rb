Chef::Log.debug("Running barracuda recipe")

execute "update package index" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

execute "Install linux headers to allow guest additions to update properly" do
  command "apt-get install dkms build-essential linux-headers-generic -y"
end

remote_file "/tmp/BOA.sh" do
  source "http://files.aegir.cc/BOA.sh.txt"
  mode 00755
end

execute "/tmp/BOA.sh" do
  creates "/usr/local/bin/boa"
end

execute "Run the BOA Installer iaminaweoctopus" do
  command "boa in-head local gregg@iaminawe.com mini iaminaweoctopus"
end

  user "iaminaweoctopus" do
    supports :manage_home => true
    home "/data/disk/iaminaweoctopus"
    shell "/bin/bash"
  end

  directory "/data/disk/iaminaweoctopus/.ssh" do
    owner "iaminaweoctopus"
    group "users"
    mode 00700
    recursive true
  end

  execute "Add ssh key to user" do
    command "ssh-keygen -b 4096 -t rsa -N \"\" -f /data/disk/iaminaweoctopus/.ssh/id_rsa"
    creates "/data/disk/iaminaweoctopus/.ssh/id_rsa"
  end

  file "/data/disk/iaminaweoctopus/.ssh/id_rsa" do
    owner "iaminaweoctopus"
    group "users"
    mode 00600
  end
  
  file "/data/disk/iaminaweoctopus/.ssh/id_rsa.pub" do
    owner "iaminaweoctopus"
    group "users"
    mode 00600
  end  

  # Only necessary as long as there is a but
remote_file "/tmp/fix-remote-import-hostmaster-iaminaweoctopus.patch" do
  source "https://raw.github.com/iaminawe/boa-vagrant/master/patches/fix-remote-import-hostmaster-iaminaweoctopus.patch"
  mode 00755
end

execute "Apply Remote Import hostmaster patch" do
  cwd "/data/disk/iaminaweoctopus/.drush/provision/remote_import"
  command "patch -p1 < /tmp/fix-remote-import-hostmaster-iaminaweoctopus.patch"
end

#execute "Run BOA Tool to fix permissions" do
 # user "root"
#  command "bash /var/xdrago/usage.sh"
#end

# Rebuild VirtualBox Guest Additions
# http://vagrantup.com/v1/docs/troubleshooting.html
execute "Rebuild VirtualBox Guest Additions" do
  command "sudo /etc/init.d/vboxadd setup"
end
