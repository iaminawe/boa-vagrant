BOA setup by vagrant
==

Using this you can setup a BOA server using vagrant and Chef.

Symlink custom modules to your site
--

By default ~/workspace/modules and ~/workspace/themes are mounted into /data/all/o_custom_modules and /data/all/o_custom_themes. If you want to use any of those on your platform, you can symlink those diretories into your sites/all folder.

  ln -s /data/all/o_custom_themes platforms/platformname/sites/all/themes/o_custom_themes
  ln -s /data/all/o_custom_modules platforms/platformname/sites/all/modules/o_custom_modules

Now you can use your usual development tools for your site.