FROM ubuntu:20.04
LABEL MAINTAINER="wujidadi@gmail.com"

ARG user=dockeruser
ARG appdir=application
ARG phpversion=8.1
ARG nanogreatversion=6
ARG nanoversion=6.2

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Add user and change the password of root/user
RUN useradd --create-home --shell /bin/bash $user;\
    adduser $user sudo;\
    echo 'root:RootUser' | chpasswd;\
    echo "$user:NPUser" | chpasswd;\
# apt-get update/upgrade
    apt-get update && apt-get install -y --no-install-recommends apt-utils && apt-get upgrade -y;\
# Date
    apt-get install -y --no-install-recommends tzdata;\
    ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime;\
    dpkg-reconfigure -f noninteractive tzdata;\
# Common applications
    apt-get install -y --no-install-recommends vim sudo expect bash-completion build-essential openssl libssl-dev net-tools iputils-ping nmap lsof cron rsyslog zip unzip p7zip-full curl wget locales git zsh gosu ca-certificates less rename screen sntp tshark;\
# Set the locale
    sed -i 's/# \(en_US\.UTF-8 .*\)/\1/g' /etc/locale.gen && locale-gen;\
# Node.js and npm
    apt-get install -y nodejs npm;\
# add-apt-repository, Nginx and PHP
    apt-get install -y --no-install-recommends software-properties-common;\
    add-apt-repository -y ppa:ondrej/nginx;\
    add-apt-repository -y ppa:ondrej/nginx-mainline;\
    add-apt-repository -y ppa:ondrej/php;\
    apt-get update && apt-get upgrade -y;\
    apt-get install -y --no-install-recommends nginx php$phpversion php$phpversion-cli php$phpversion-common php-fpm php$phpversion-fpm php-pear php$phpversion-curl php$phpversion-dev php$phpversion-gd php$phpversion-mbstring php$phpversion-zip php$phpversion-mysql php$phpversion-opcache php$phpversion-readline php$phpversion-xml php$phpversion-tidy php$phpversion-imagick php$phpversion-gmp php$phpversion-bz2 php$phpversion-soap php$phpversion-bcmath php$phpversion-pgsql php$phpversion-sqlite3 odbc-postgresql;\
# Create PHP-FPM directory at /run
    mkdir /run/php;\
# Configure Nginx
    cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup;\
    echo '##'                                                                          > /etc/nginx/sites-available/default;\
    echo '# Default server configuration' >> /etc/nginx/sites-available/default;\
    echo '#'                                                                          >> /etc/nginx/sites-available/default;\
    echo 'server {'                                                                   >> /etc/nginx/sites-available/default;\
    echo '    listen 80 default_server;'                                              >> /etc/nginx/sites-available/default;\
    echo '    listen [::]:80 default_server;'                                         >> /etc/nginx/sites-available/default;\
    echo ''                                                                           >> /etc/nginx/sites-available/default;\
    echo '    root /var/www/html/application/public;'                                 >> /etc/nginx/sites-available/default;\
    echo ''                                                                           >> /etc/nginx/sites-available/default;\
    echo '    index index.php index.html index.htm index.nginx-debian.html;'          >> /etc/nginx/sites-available/default;\
    echo ''                                                                           >> /etc/nginx/sites-available/default;\
    echo '    server_name _;'                                                         >> /etc/nginx/sites-available/default;\
    echo ''                                                                           >> /etc/nginx/sites-available/default;\
    echo '    # fastcgi_intercept_errors  on;'                                        >> /etc/nginx/sites-available/default;\
    echo ''                                                                           >> /etc/nginx/sites-available/default;\
    echo '    location / {'                                                           >> /etc/nginx/sites-available/default;\
    echo '        if ( !-e  $request_filename ) {'                                    >> /etc/nginx/sites-available/default;\
    echo '            rewrite (.*) /index.php;'                                       >> /etc/nginx/sites-available/default;\
    echo '        }'                                                                  >> /etc/nginx/sites-available/default;\
    echo '    }'                                                                      >> /etc/nginx/sites-available/default;\
    echo ''                                                                           >> /etc/nginx/sites-available/default;\
    echo '    location ~ \.php$ {'                                                    >> /etc/nginx/sites-available/default;\
    echo "        fastcgi_pass   unix:/run/php/php$phpversion-fpm.sock;"              >> /etc/nginx/sites-available/default;\
    echo '        fastcgi_index  index.php;'                                          >> /etc/nginx/sites-available/default;\
    echo '        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> /etc/nginx/sites-available/default;\
    echo '        include        fastcgi_params;'                                     >> /etc/nginx/sites-available/default;\
    echo '    }'                                                                      >> /etc/nginx/sites-available/default;\
    echo ''                                                                           >> /etc/nginx/sites-available/default;\
    echo '    location ~ /\.ht {'                                                     >> /etc/nginx/sites-available/default;\
    echo '        deny all;'                                                          >> /etc/nginx/sites-available/default;\
    echo '    }'                                                                      >> /etc/nginx/sites-available/default;\
    echo '}'                                                                          >> /etc/nginx/sites-available/default;\
# Change PHP precision
    sed -i 's/precision = 14/precision = 16/g' /etc/php/$phpversion/fpm/php.ini;\
    sed -i 's/precision = 14/precision = 16/g' /etc/php/$phpversion/cli/php.ini;\
# Change PHP timezone
    sed -i 's/;date\.timezone =/date.timezone = Asia\/Taipei/g' /etc/php/$phpversion/fpm/php.ini;\
    sed -i 's/;date\.timezone =/date.timezone = Asia\/Taipei/g' /etc/php/$phpversion/cli/php.ini;\
# Add PHP custom patch settings mark
    echo ''                          >> /etc/php/$phpversion/fpm/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/$phpversion/fpm/php.ini;\
    echo '; Custom Patch Settings ;' >> /etc/php/$phpversion/fpm/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/$phpversion/fpm/php.ini;\
    echo ''                          >> /etc/php/$phpversion/fpm/php.ini;\
    echo ''                          >> /etc/php/$phpversion/cli/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/$phpversion/cli/php.ini;\
    echo '; Custom Patch Settings ;' >> /etc/php/$phpversion/cli/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/$phpversion/cli/php.ini;\
    echo ''                          >> /etc/php/$phpversion/cli/php.ini;\
# Add www-data to the same group with user
    gpasswd -a www-data $user;\
# Composer (2.2.6)
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";\
    php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;";\
    php composer-setup.php;\
    php -r "unlink('composer-setup.php');";\
    mv composer.phar /usr/local/bin/composer;\
# Correct syntax errors of PECL
    sed -i "s/} elseif (\$prepend{0} != '\\\\\\\') {/} elseif (\$prepend[0] != '\\\\\\\') {/g"                             /usr/share/php/PEAR/Config.php;\
    sed -i "s/\$ent{\([0-9]\)}/\$ent[\1]/g"                                                                                /usr/share/php/PEAR/Registry.php;\
    sed -i "s/\$components\['path'\]{\([0-9]\)}/\$components['path'][\1]/g"                                                /usr/share/php/PEAR/Registry.php;\
    sed -i "s/if (\$depdb\['_version'\]{0} > \$this->_version{0}) {/if (\$depdb['_version'][0] > \$this->_version[0]) {/g" /usr/share/php/PEAR/DependencyDB.php;\
    sed -i "s/\$entry{\([0-9]\)}/\$entry[\1]/g"                                                                            /usr/share/php/PEAR/Installer/Role.php;\
    sed -i "s/\$opt\[1\]{\([0-9]\)}/\$opt[1][\1]/g"                                                                        /usr/share/php/System.php;\
    sed -i "s/\$args\[0\]{\([0-9]\)}/\$args[0][\1]/g"                                                                      /usr/share/php/Console/Getopt.php;\
    sed -i "s/\$arg{\([0-9]\)}/\$arg[\1]/g"                                                                                /usr/share/php/Console/Getopt.php;\
    sed -i "s/\$arg{\$i}/\$arg[\$i]/g"                                                                                     /usr/share/php/Console/Getopt.php;\
    sed -i "s/\$spec{\([0-9]\)}/\$spec[\1]/g"                                                                              /usr/share/php/Console/Getopt.php;\
    sed -i "s/\$opt{\([0-9]\)}/\$opt[\1]/g"                                                                                /usr/share/php/Console/Getopt.php;\
    sed -i "s/\$next_option_rest{\([0-9]\)}/\$next_option_rest[\1]/g"                                                      /usr/share/php/Console/Getopt.php;\
    sed -i "s/\$file{\([0-9]\)}/\$file[\1]/g"                                                                              /usr/share/php/PEAR/Command.php;\
    sed -i "s/\$version{\([0-9]\)}/\$version[\1]/g"                                                                        /usr/share/php/PEAR/PackageFile.php;\
    sed -i "s/\$majver{\([0-9]\)}/\$majver[\1]/g"                                                                          /usr/share/php/PEAR/Validate.php;\
    sed -i "s/\$versioncomponents\[2\]{\([0-9]\)}/\$versioncomponents[2][\1]/g"                                            /usr/share/php/PEAR/Validate.php;\
    sed -i "s/\$method{\([0-9]\)}/\$method[\1]/g"                                                                          /usr/share/php/PEAR/Common.php;\
    sed -i "s/\$function{\([0-9]\)}/\$function[\1]/g"                                                                      /usr/share/php/PEAR/Common.php;\
    sed -i "s/\$params\[1\]{\([0-9]\)}/\$params[1][\1]/g"                                                                  /usr/share/php/PEAR/Command/Channels.php;\
    sed -i "s/\$info\['arg'\]{\([0-9]\)}/\$info['arg'][\1]/g"                                                              /usr/share/php/PEAR/Command/Common.php;\
    sed -i "s/\$prepend{\([0-9]\)}/\$prepend[\1]/g"                                                                        /usr/share/php/PEAR/Downloader.php;\
    sed -i "s/\$atts\['platform'\]{\([0-9]\)}/\$atts['platform'][\1]/g"                                                    /usr/share/php/PEAR/Installer.php;\
    sed -i "s/\$line{\([0-9]\)}/\$line[\1]/g"                                                                              /usr/share/php/OS/Guess.php;\
    sed -i "s/\$attrib{\([0-9]\)}/\$attrib[\1]/g"                                                                          /usr/share/php/PEAR/PackageFile/v2/Validator.php;\
    sed -i "s/\$key{\([0-9]\)}/\$key[\1]/g"                                                                                /usr/share/php/PEAR/PackageFile/v2/Validator.php;\
    sed -i "s/\$file\['attribs'\]\['name'\]{\([0-9]\)}/\$file['attribs']['name'][\1]/g"                                    /usr/share/php/PEAR/PackageFile/v2/Validator.php;\
    sed -i "s/\$method{\([0-9]\)}/\$method[\1]/g"                                                                          /usr/share/php/PEAR/PackageFile/v2/Validator.php;\
    sed -i "s/\$function{\([0-9]\)}/\$function[\1]/g"                                                                      /usr/share/php/PEAR/PackageFile/v2/Validator.php;\
    sed -i "s/\$ent{\([0-9]\)}/\$ent[\1]/g"                                                                                /usr/share/php/PEAR/Builder.php;\
# Redis Driver for PHP
    pecl channel-update pecl.php.net;\
    sh -c '/bin/echo "no" | pecl install redis';\
    echo 'extension=redis.so' >> /etc/php/$phpversion/fpm/php.ini;\
    echo 'extension=redis.so' >> /etc/php/$phpversion/cli/php.ini;\
# MongoDB Driver for PHP
    sh -c '/bin/echo "no" | pecl install mongodb';\
    echo 'extension=mongodb.so' >> /etc/php/$phpversion/fpm/php.ini;\
    echo 'extension=mongodb.so' >> /etc/php/$phpversion/cli/php.ini;\
# GNU nano
    apt install -y --no-install-recommends libncursesw5-dev libslang2-dev;\
    cd /;\
    curl -OL https://www.nano-editor.org/dist/v$nanogreatversion/nano-$nanoversion.tar.xz /;\
    tar xvf nano-$nanoversion.tar.xz -C / ; cd /nano-$nanoversion;\
    ./configure --enable-utf8;\
    make && make install;\
    cd .. ; rm -rf nano-$nanoversion nano-$nanoversion.tar.xz;\
    echo "include /usr/local/share/nano/*.nanorc" >> /root/.nanorc;\
    echo "include /usr/local/share/nano/*.nanorc" >> /home/$user/.nanorc;\
    chown $user:$user /home/$user/.nanorc;\
# Clean apt
    apt-get autoremove -y;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;\
# Link home application directory to server root
    mkdir /home/$user/$appdir;\
    chown -RHh $user:$user /home/$user/$appdir;\
    ln -s /home/$user/$appdir /var/www/html;\
    chown -RHh $user:$user /var/www/html/$appdir;\
# Make the cron job directory in user's home (call from the host)
    mkdir /home/$user/cron;\
    chown -RHh $user:$user /home/$user/cron

# Install Oh My Zsh, link the directory to user's home and change shell to zsh
# Set Git's default pager (less) for displaying unicode characters
USER $user
RUN echo Y | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/home.bashrc -o /home/$user/.bashrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/home.vimrc -o /home/$user/.vimrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/home.zshrc -o /home/$user/.zshrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/myzshtheme.zsh-theme -o /home/$user/.oh-my-zsh/themes/myzshtheme.zsh-theme;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/myrootzshtheme.zsh-theme -o /home/$user/.oh-my-zsh/themes/myrootzshtheme.zsh-theme;\
    git config --global core.pager 'less --raw-control-chars';\
    sed -i "s/ZSH=\"\/home\/user\/.oh-my-zsh\"/ZSH=\"\/home\/$user\/.oh-my-zsh\"/g" /home/$user/.zshrc
USER root
RUN ln -s /home/$user/.oh-my-zsh /root;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/root.bashrc -o /root/.bashrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/root.vimrc -o /root/.vimrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/root.zshrc -o /root/.zshrc;\
    chsh -s /bin/zsh;\
    chsh -s /bin/zsh $user;\
    /bin/bash -c "touch /home/$user/.oh-my-zsh/cache/{.zsh-update,grep-alias}";\
    /bin/bash -c "chown $user:$user /home/$user/.oh-my-zsh/cache/{.zsh-update,grep-alias}";\
    git config --global core.pager 'less --raw-control-chars'

CMD [ "nginx", "-g", "daemon off;" ]
