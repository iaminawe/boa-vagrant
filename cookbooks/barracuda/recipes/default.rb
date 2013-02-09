Chef::Log.debug("Running barracuda recipe")

remote_file "/tmp/BOA.sh" do
  source "http://files.aegir.cc/BOA.sh.txt"
  mode 00755
end

execute "/tmp/BOA.sh" do
  creates "/usr/local/bin/boa"
end

execute "Run the BOA Installer o1" do
  command "boa in-stable local gregg@iaminawe.com mini"
end


  user "o#{boa_user}" do
    supports :manage_home => true
    home "/data/disk/o#{boa_user}"
    shell "/bin/bash"
  end

  directory "/data/disk/o#{boa_user}/.ssh" do
    owner "o#{boa_user}"
    group "users"
    mode 00700
    recursive true
  end

  execute "Add ssh key to user" do
    command "ssh-keygen -b 4096 -t rsa -N \"\" -f /data/disk/o#{boa_user}/.ssh/id_rsa"
    creates "/data/disk/o#{boa_user}/.ssh/id_rsa"
  end

  file "/data/disk/o#{boa_user}/.ssh/id_rsa" do
    owner "o#{boa_user}"
    group "users"
    mode 00600
  end
  
  file "/data/disk/o#{boa_user}/.ssh/id_rsa.pub" do
    owner "o#{boa_user}"
    group "users"
    mode 00600
  end  

  # Only necessary as long as there is a but
  remote_file "/tmp/fix-remote-import-hostmaster-o#{boa_user}.patch" do
    source "https://raw.github.com/lsolesen/boa-vagrant/master/patches/fix-remote-import-hostmaster-o#{boa_user}.patch"
    mode 00755
  end

  execute "Apply Remote Import hostmaster patch" do
    cwd "/data/disk/o#{boa_user}/.drush/provision/remote_import"
    command "patch -p1 < /tmp/fix-remote-import-hostmaster-o#{boa_user}.patch"
  end


execute "Run BOA Tool to fix permissions" do
  user "root"
  command "bash /var/xdrago/usage.sh"
end

# Rebuild VirtualBox Guest Additions
# http://vagrantup.com/v1/docs/troubleshooting.html
execute "Rebuild VirtualBox Guest Additions" do
  command "sudo /etc/init.d/vboxadd setup"
end
