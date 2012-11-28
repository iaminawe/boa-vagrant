Chef::Log.debug("Running barracuda recipe")

execute "Download BOA-installer" do
  command "wget -q -U iCab http://files.aegir.cc/BOA.sh.txt"
end

execute "Run installer" do
  command "bash BOA.sh.txt"
end  

# Add o1

execute "Setup a BOA instance" do
  command "boa in-stable local lars@intraface.dk mini"
end

execute "Prepare user with ssh directory" do
  command "chsh -s /bin/bash o1"
  command "su o1"
  command "mkdir -p ~/.ssh"
  command "chmod 700 ~/.ssh"
end

execute "Add ssh key to user" do
  command "ssh-keygen -b 4096 -t rsa -N "" -f ~/.ssh/id_rsa"
end

# Add o2

execute "Setup a BOA instance" do
  command "boa in-stable local lars@intraface.dk aegir.local o2 mini"
end

execute "Prepare user with ssh directory" do
  command "chsh -s /bin/bash o2"
  command "su o2"
  command "mkdir -p ~/.ssh"
  command "chmod 700 ~/.ssh"
end

execute "Add ssh key to user" do
  command "ssh-keygen -b 4096 -t rsa -N "" -f ~/.ssh/id_rsa"
end

# Add o3

execute "Setup a BOA instance" do
  command "boa in-stable local lars@intraface.dk aegir.local o3 mini"
end

execute "Prepare user with ssh directory" do
  command "chsh -s /bin/bash o3"
  command "su o3"
  command "mkdir -p ~/.ssh"
  command "chmod 700 ~/.ssh"
end

execute "Add ssh key to user" do
  command "ssh-keygen -b 4096 -t rsa -N "" -f ~/.ssh/id_rsa"
end

# Rebuild VirtualBox Guest Additions
# http://vagrantup.com/v1/docs/troubleshooting.html
execute "Add ssh key to user" do
  command "sudo /etc/init.d/vboxadd setup"
end
