BOA setup by vagrant
==

Using this you can setup a BOA server using vagrant and Chef.

Requirements
-- 

- http://vagrantup.com/

Getting vagrant in place
--

Make sure you have added a ´base´ box already, see http://vagrantup.com/v1/docs/getting-started/index.html

    vagrant box add base http://files.vagrantup.com/lucid32.box

When you are ready, run the following (takes about 20 minutes)

    vagrant up

If you want to see the content in the browser on your system, you need to add the ip of the VM to ´/etc/hosts´, and let it point to the addresses, you are going to run from the vm.

Symlink custom modules to your site
--

Default shared folder
This folder is automatically mounted "~/workspace/platforms", "/data/disk/octopus_user/static", nfs: true


Additional shared folders 

Additionally `~/workspace/modules and ~/workspace/themes` can be mounted into `/data/all/o_custom_modules` and `/data/all/o_custom_themes` by adding them to the vagrant file.

If you want to use any of those on your platform, you can symlink those diretories into your `sites/all` folder.

    ln -s /data/all/o_custom_themes platforms/platformname/sites/all/themes/o_custom_themes
    ln -s /data/all/o_custom_modules platforms/platformname/sites/all/modules/o_custom_modules

Now you can use your usual development tools for your site.

Remote import
--

Remember to check whether ´/data/disk/o1/.drush/provision/remote_import´ has been deleted.

If you want to be able to do remote imports, you need to do the following manually:

Copy the key to the remote server (also see http://larsolesen.dk/node/358)

    ssh-copy-id -i .ssh/id_rsa.pub user@remote-server

Go to ´admin/hosting/features´under ´Experimental´ and add remote import.
Go to ´Servers´ and add server. Choose hostmaster.

