# Default Apache virtualhost template
<VirtualHost *:443>
    SSLEngine on
    SSLCipherSuite HIGH:MEDIUM

    SSLProtocol all -SSLv2
    SSLCertificateFile /etc/apache2/ssl/apache.crt
    SSLCertificateKeyFile /etc/apache2/ssl/apache.key

    ServerAdmin webmaster@localhost

    VirtualDocumentRoot {{ vm.synced_folder.project_folder.guest_machine }}/%1/www
    ServerAlias     *.{{ vm.hostname }}

    SetEnv APPLICATION_ENV "{{ vm.environment }}"

    <Directory />
    Options FollowSymLinks
    AllowOverride All
    Require all granted
    Order allow,deny
    allow from all
    AddType application/x-httpd-php .html
    </Directory>
    <Directory /var/www/>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
    </Directory>

    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
    <Directory "/usr/lib/cgi-bin">
    AllowOverride None
    Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
    Require all granted
    </Directory>

    ErrorLog /var/log/apache2/error-ssl.log

    # Possible values include: debug, info, notice, warn, error, crit,
    # alert, emerg.
    LogLevel error

    LogFormat "%V %h %l %u %t \"%r\" %s %b" vcommon

    CustomLog /var/log/apache2/access-ssl.log vcommon
    # combined

</VirtualHost>

<VirtualHost *:80>

    ServerAdmin webmaster@localhost

    VirtualDocumentRoot {{ vm.synced_folder.project_folder.guest_machine }}/%1/www
    ServerAlias     *.{{ vm.hostname }}

    SetEnv APPLICATION_ENV "{{ vm.environment }}"

    <Directory />
    Options FollowSymLinks
    AllowOverride All
    Require all granted
    Order allow,deny
    allow from all
    AddType application/x-httpd-php .html
    </Directory>

    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
    <Directory "/usr/lib/cgi-bin">
    AllowOverride None
    Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
    Require all granted
    </Directory>

    ErrorLog /var/log/apache2/error.log

    # Possible values include: debug, info, notice, warn, error, crit,
    # alert, emerg.
    LogLevel error

    LogFormat "%V %h %l %u %t \"%r\" %s %b" vcommon

    CustomLog /var/log/apache2/access.log vcommon
    # combined

</VirtualHost>