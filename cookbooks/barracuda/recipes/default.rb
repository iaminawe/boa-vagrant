Chef::Log.debug("Running barracuda recipe")

remote_file "/tmp/BOA.sh" do
  source "http://files.aegir.cc/BOA.sh.txt"
  mode 00755
end

execute "/tmp/BOA.sh" do
  creates "/usr/local/bin/boa"
end

execute "Run the BOA Installer o1" do
  command "boa in-stable local lars@intraface.dk aegir.local o1 mini"
end

execute "Run the BOA Installer o2" do
  command "boa in-stable local lars@intraface.dk aegir.local o2 mini"
end

execute "Run the BOA Installer o3" do
  command "boa in-stable local lars@intraface.dk aegir.local o3 mini"
end

(1..3).each do |boa_user|

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

end

# Rebuild VirtualBox Guest Additions
# http://vagrantup.com/v1/docs/troubleshooting.html
execute "Rebuild VirtualBox Guest Additions" do
  command "sudo /etc/init.d/vboxadd setup"
end
