Role Name
=========

Installs the latest version of WordPress

Requirements
------------

Needs Apache, MySQL and PHP

Role Variables
--------------

wp_install_path : '/var/www/html'
wp_directory_name: 'wordpress'
wp_db_host: '127.0.0.1'
wp_table_prefix: 'wp_'
wp_debug_mode: 'TRUE'
website_address: 'http://www.wordpress.local'

Dependencies
------------

apache
mysql
php

Example Playbook
----------------

    - hosts: webserver
      roles:
         - { role: wordpress }

License
-------

BSD

Author Information
------------------

Soroush Atarod atarod@infinitypp.com