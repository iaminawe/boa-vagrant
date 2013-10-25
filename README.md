BOA Vagrant Installer
==

Using this script you can easily setup a local Barracuda/Octopus/Aegir development environment using Vagrant and Chef.

- https://drupal.org/project/boa
- https://drupal.org/project/barracuda
- https://drupal.org/project/octopus

If you setup the hostmaster remote import module (instructions at bottom) correctly, you can import sites from a remote octopus instance that shares the same octopus username as this local one.

View how this dev/local/staging workflow can work with this screencast https://vimeo.com/76546448

Requirements
-- 

- http://vagrantup.com/

Getting vagrant in place
--

Make sure you have added a ´base´ box already, see http://docs.vagrantup.com/v2/getting-started/

    vagrant box add base http://files.vagrantup.com/lucid32.box

When you are ready, run the following (takes about 60 minutes)

    vagrant up

If you want to see the content in the browser on your system, you need to add the ip of the VM to ´/etc/hosts´, and let it point to the addresses, you are going to run from the vm.

Step by Step instructions on getting up and running
--

1.) Fork this repo https://github.com/iaminawe/boa-vagrant and clone it locally

2.) Edit this file /cookbooks/barracuda/recipes/default.rb and replace iaminaweoctopus (my octopus username) with your octopus username and my e-mail with your e-mail - you can read more about the other additional options here http://drupalcode.org/project/barracuda.git/blob/HEAD:/docs/INSTALL.txt

3.) Edit the patch filename and contents to replace all instances of iaminaweoctopus with your own octopus username https://github.com/iaminawe/boa-vagrant/tree/master/patches

4.) Edit the Vagrantfile in the root to and add what folder you want mounted on your guest OS - in my case I have mounted the platforms directory of my octopus instance to my ~/workspaces/platforms/folder on my mac

5.) Run "Vagrant up" from within the folder and wait around 60 mins

6.) When its complete you should receive e-mails with links to your new aegir instances (check spam folder if you don't get anything)
Another way to find the logins for barracuda is in /var/aegir/logs/install.log
Another way to find the logins for an octopus instance is in /data/disk/octopus_user/logs/install.log

7.) In your /etc/hosts/ file point the domain names you would like to use (for main barracuda, octopus instance and each site) at 192.168.10.88
Its possible to setup a wilcard dns on mac osx but I have not succeeded in doing so yet.

8.) You can rename the domain to access an octopus instance by unlocking the hostname platform in aegir and then editing the site and adding additional site aliases.

Default Shared Folder
--
This host folder "~/workspace/platforms" is automatically mounted to "/data/disk/octopus_user/static" within the guest.
The platforms folder needs to exist before running the installer


Optional Step: Symlink custom modules to your site
--

Additionally `~/workspace/modules and ~/workspace/themes` can be mounted into `/data/all/o_custom_modules` and `/data/all/o_custom_themes` by adding them to the vagrant file.

Follow the pattern of the default folder mount in the Vagrantfile to add these additional folders

If you want to use any of those on your platform, you can symlink those diretories into your `sites/all` folder.

    ln -s /data/all/o_custom_themes platforms/platformname/sites/all/themes/o_custom_themes
    ln -s /data/all/o_custom_modules platforms/platformname/sites/all/modules/o_custom_modules

Now you can use your usual development tools for your site.

Remote import
--

Remember to check whether ´/data/disk/octopus_user/.drush/provision/remote_import´ has been deleted.

If you want to be able to do remote imports, you need to do the following manually:

Copy the key to the remote server (also see http://larsolesen.dk/node/358)

    ssh-copy-id -i .ssh/id_rsa.pub octopus_user@remote-server

Go to ´admin/hosting/features´under ´Experimental´ and add remote import.
Go to ´Servers´ and add server. Choose hostmaster.


