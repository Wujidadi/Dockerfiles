FROM ubuntu:22.04
LABEL MAINTAINER="wujidadi@gmail.com"

ARG user=user
ARG appdir=application
ARG php_version=8.2
ARG node_version=20
ARG vim_tag=v9.0.1677
ARG nano_great_version=7
ARG nano_version=7.2
ARG msodbc_version=18
ARG swoole_version=5.0.3

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN echo '';\
    echo '================================';\
    echo 'Image building begins ...';\
    echo '================================';\
    echo '';\
    apt-get update && apt-get install -y --no-install-recommends apt-utils && apt-get upgrade -y;\
    echo '';\
    echo '================================';\
    echo 'Setting date and timezone ...';\
    echo '================================';\
    echo '';\
    apt-get install -y --no-install-recommends tzdata;\
    ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime;\
    dpkg-reconfigure -f noninteractive tzdata;\
    echo '';\
    echo '================================';\
    echo 'Installing common packages ...';\
    echo '================================';\
    echo '';\
    apt-get install -y --no-install-recommends sudo expect bash-completion build-essential openssl libssl-dev net-tools iputils-ping nmap lsof telnet cron rsyslog zip unzip p7zip-full curl wget locales git zsh gosu ca-certificates less rename screen sntp tshark gpg-agent;\
    echo '';\
    echo '================================';\
    echo 'Setting the locale ...';\
    echo '================================';\
    echo '';\
    sed -i 's/# \(en_US\.UTF-8 .*\)/\1/g' /etc/locale.gen && locale-gen;\
    echo '';\
    echo '==================================';\
    echo 'Setting root and default users ...';\
    echo '==================================';\
    echo '';\
    useradd --create-home --shell /bin/bash ${user};\
    adduser ${user} sudo;\
    echo 'root:RootUser' | chpasswd;\
    echo "${user}:APUser" | chpasswd;\
    echo '';\
    echo '================================';\
    echo 'Installing Supervisor ...';\
    echo '================================';\
    echo '';\
    apt-get install -y --no-install-recommends supervisor;\
    echo '';\
    echo '================================';\
    echo 'Installing Node.js and npm ...';\
    echo '================================';\
    echo '';\
    curl -sL https://deb.nodesource.com/setup_${node_version}.x | sudo -E bash -;\
    apt-get install -y nodejs;\
    npm i -g npm;\
    echo '';\
    echo '================================';\
    echo 'Installing Apache and PHP ...';\
    echo '================================';\
    echo '';\
    apt-get install -y --no-install-recommends software-properties-common;\
    add-apt-repository -y ppa:ondrej/apache2;\
    add-apt-repository -y ppa:ondrej/php;\
    apt-get update && apt-get upgrade -y;\
    apt-get install -y --no-install-recommends php${php_version} php${php_version}-cli php${php_version}-common php${php_version}-fpm php${php_version}-raphf php${php_version}-http php${php_version}-xdebug php${php_version}-pdo php-pear php${php_version}-curl php${php_version}-dev php${php_version}-gd php${php_version}-mbstring php${php_version}-zip php${php_version}-mysql php${php_version}-mysqlnd php${php_version}-opcache php${php_version}-readline php${php_version}-xml php${php_version}-tidy php${php_version}-imagick php${php_version}-gmp php${php_version}-bz2 php${php_version}-soap php${php_version}-bcmath php${php_version}-intl php${php_version}-pgsql php${php_version}-sqlite3 apache2 apache2-doc apache2-utils libapache2-mod-php${php_version} odbc-postgresql;\
    a2enmod headers;\
    a2enmod rewrite;\
    ln -s /usr/sbin/php-fpm${php_version} /usr/sbin/php-fpm;\
    echo '';\
    echo '================================';\
    echo "Setting Apache AllowOverride ...";\
    echo '================================';\
    echo '';\
    echo '' >> /etc/apache2/apache2.conf;\
    echo '# Custom patch settings' >> /etc/apache2/apache2.conf;\
    echo '<Directory /var/www/html>' >> /etc/apache2/apache2.conf;\
    echo '    AllowOverride All' >> /etc/apache2/apache2.conf;\
    echo '    Require all granted' >> /etc/apache2/apache2.conf;\
    echo '</Directory>' >> /etc/apache2/apache2.conf;\
    echo '';\
    echo '================================';\
    echo 'Setting PHP precision ...';\
    echo '================================';\
    echo '';\
    sed -i 's/precision = 14/precision = 16/g' /etc/php/${php_version}/apache2/php.ini;\
    sed -i 's/precision = 14/precision = 16/g' /etc/php/${php_version}/cli/php.ini;\
    echo '';\
    echo '================================';\
    echo 'Setting PHP timezone ...';\
    echo '================================';\
    echo '';\
    sed -i 's/;date\.timezone =/date.timezone = Asia\/Taipei/g' /etc/php/${php_version}/apache2/php.ini;\
    sed -i 's/;date\.timezone =/date.timezone = Asia\/Taipei/g' /etc/php/${php_version}/cli/php.ini;\
    echo '';\
    echo '=========================================';\
    echo 'Adding PHP custom patch setting marks ...';\
    echo '=========================================';\
    echo '';\
    echo '' >> /etc/php/${php_version}/apache2/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/${php_version}/apache2/php.ini;\
    echo '; Custom Patch Settings ;' >> /etc/php/${php_version}/apache2/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/${php_version}/apache2/php.ini;\
    echo '' >> /etc/php/${php_version}/apache2/php.ini;\
    echo '' >> /etc/php/${php_version}/cli/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/${php_version}/cli/php.ini;\
    echo '; Custom Patch Settings ;' >> /etc/php/${php_version}/cli/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/${php_version}/cli/php.ini;\
    echo '' >> /etc/php/${php_version}/cli/php.ini;\
    echo '';\
    echo '===========================================================';\
    echo 'Adding www-data to the same group with the default user ...';\
    echo '===========================================================';\
    echo '';\
    gpasswd -a www-data ${user};\
    echo '';\
    echo '==================================================================';\
    echo 'Creating php-fpm sock folder and admit permissions to www-data ...';\
    echo '==================================================================';\
    echo '';\
    mkdir /run/php;\
    chown -RHh www-data:www-data /run/php;\
    echo '';\
    echo '================================';\
    echo 'Installing Composer ...';\
    echo '================================';\
    echo '';\
    php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer;\
    echo '';\
    echo '===================================';\
    echo 'Installing Redis driver for PHP ...';\
    echo '===================================';\
    echo '';\
    pecl channel-update pecl.php.net;\
    sh -c '/bin/echo "no" | pecl install redis';\
    echo 'extension=redis.so' >> /etc/php/${php_version}/apache2/php.ini;\
    echo 'extension=redis.so' >> /etc/php/${php_version}/cli/php.ini;\
    echo '';\
    echo '=====================================';\
    echo 'Installing MongoDB driver for PHP ...';\
    echo '=====================================';\
    echo '';\
    sh -c '/bin/echo "no" | pecl install mongodb';\
    echo 'extension=mongodb.so' >> /etc/php/${php_version}/apache2/php.ini;\
    echo 'extension=mongodb.so' >> /etc/php/${php_version}/cli/php.ini;\
    echo '';\
    echo '================================';\
    echo 'Installing Swoole ...';\
    echo '================================';\
    echo '';\
    printf "no\nyes\nyes\nno\n" | pecl install swoole-${swoole_version};\
    echo "extension=swoole.so\n" > /etc/php/${php_version}/mods-available/swoole.ini;\
    phpenmod swoole;\
    echo '';\
    echo '======================================================================';\
    echo 'Installing Microsoft SQL Server Driver for PHP with Microsoft ODBC ...';\
    echo '======================================================================';\
    echo '';\
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -;\
    curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list;\
    apt-get update;\
    ACCEPT_EULA=Y apt-get install -y msodbcsql${msodbc_version};\
    ACCEPT_EULA=Y apt-get install -y mssql-tools${msodbc_version};\
    apt-get -y install unixodbc-dev;\
    pecl install sqlsrv pdo_sqlsrv;\
    echo "; priority=20\nextension=sqlsrv.so\n" > /etc/php/${php_version}/mods-available/sqlsrv.ini;\
    echo "; priority=20\nextension=pdo_sqlsrv.so\n" > /etc/php/${php_version}/mods-available/pdo_sqlsrv.ini;\
    phpenmod sqlsrv pdo_sqlsrv;\
    echo '';\
    echo '================================';\
    echo 'Installing MySQL Client ...';\
    echo '================================';\
    echo '';\
    apt-get -y install mysql-client libmysqlclient-dev;\
    echo '';\
    echo '================================';\
    echo 'Installing PostgreSQL Client ...';\
    echo '================================';\
    echo '';\
    apt-get -y install postgresql-client;\
    echo '';\
    echo '==========================================';\
    echo 'Installing ncurses and S-Lang packages ...';\
    echo '==========================================';\
    echo '';\
    apt install -y --no-install-recommends libncursesw5-dev libslang2-dev;\
    echo '';\
    echo '================================';\
    echo 'Installing newest Vim ...';\
    echo '================================';\
    echo '';\
    cd /;\
    git clone -b ${vim_tag} https://github.com/vim/vim.git vim;\
    cd vim/src;\
    make && make install;\
    cd / && rm -rf vim;\
    echo '';\
    echo '================================';\
    echo 'Installing newest GNU Nano ...';\
    echo '================================';\
    echo '';\
    cd /;\
    curl -OL https://www.nano-editor.org/dist/v${nano_great_version}/nano-${nano_version}.tar.xz /;\
    tar xvf nano-${nano_version}.tar.xz -C / && cd /nano-${nano_version};\
    ./configure --enable-utf8;\
    make && make install;\
    cd .. && rm -rf nano-${nano_version} nano-${nano_version}.tar.xz;\
    echo "include /usr/local/share/nano/*.nanorc" >> /root/.nanorc;\
    echo "include /usr/local/share/nano/*.nanorc" >> /home/${user}/.nanorc;\
    chown ${user}:${user} /home/${user}/.nanorc;\
    echo '';\
    echo '================================';\
    echo 'Cleaning apt ...';\
    echo '================================';\
    echo '';\
    apt-get autoremove -y;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;\
    echo '';\
    echo '=====================================================';\
    echo 'Linking home application directory to server root ...';\
    echo '=====================================================';\
    echo '';\
    mkdir /home/${user}/${appdir};\
    chown -RHh ${user}:${user} /home/${user}/${appdir};\
    ln -s /home/${user}/${appdir} /var/www/html;\
    chown -RHh ${user}:${user} /var/www/html/${appdir}

USER ${user}
RUN echo '';\
    echo '================================';\
    echo 'Installing Oh My Zsh ...';\
    echo '================================';\
    echo '';\
    echo Y | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/home.bashrc -o /home/${user}/.bashrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/home.vimrc -o /home/${user}/.vimrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/home.zshrc -o /home/${user}/.zshrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/myzshtheme.zsh-theme -o /home/${user}/.oh-my-zsh/themes/myzshtheme.zsh-theme;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/myrootzshtheme.zsh-theme -o /home/${user}/.oh-my-zsh/themes/myrootzshtheme.zsh-theme;\
    sed -i "s/ZSH=\"\/home\/user\/.oh-my-zsh\"/ZSH=\"\/home\/${user}\/.oh-my-zsh\"/g" /home/${user}/.zshrc;\
    echo '';\
    echo '==================================================================================';\
    echo "${user}: Setting Git's default pager to less for displaying unicode characters ...";\
    echo '==================================================================================';\
    echo '';\
    git config --global core.pager 'less --raw-control-chars';\
    echo '';\
    echo '==========================================================================';\
    echo '${user}: Adding MSSQL bcp and sqlcmd to the environment path variables ...';\
    echo '==========================================================================';\
    echo '';\
    echo 'export PATH="$PATH:/opt/mssql-tools${msodbc_version}/bin"' >> /home/${user}/.bashrc;\
    echo 'export PATH="$PATH:/opt/mssql-tools${msodbc_version}/bin"' >> /home/${user}/.zshrc
USER root
RUN ln -s /home/${user}/.oh-my-zsh /root;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/root.bashrc -o /root/.bashrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/root.vimrc -o /root/.vimrc;\
    curl -L https://raw.github.com/Wujidadi/Ubuntu-RC/main/root.zshrc -o /root/.zshrc;\
    touch /root/.zsh_history;\
    touch /home/${user}/.zsh_history && chown ${user}:${user} /home/${user}/.zsh_history;\
    echo '';\
    echo '=====================================';\
    echo 'Changing the default shell to Zsh ...';\
    echo '=====================================';\
    echo '';\
    chsh -s /bin/zsh;\
    chsh -s /bin/zsh ${user};\
    /bin/bash -c "touch /home/${user}/.oh-my-zsh/cache/{.zsh-update,grep-alias}";\
    /bin/bash -c "chown ${user}:${user} /home/${user}/.oh-my-zsh/cache/{.zsh-update,grep-alias}";\
    echo '';\
    echo '===============================================================================';\
    echo "root: Setting Git's default pager to less for displaying unicode characters ...";\
    echo '===============================================================================';\
    echo '';\
    git config --global core.pager 'less --raw-control-chars';\
    echo '';\
    echo '=======================================================================';\
    echo 'root: Adding MSSQL bcp and sqlcmd to the environment path variables ...';\
    echo '=======================================================================';\
    echo '';\
    echo 'export PATH="$PATH:/opt/mssql-tools${msodbc_version}/bin"' >> /root/.bashrc;\
    echo 'export PATH="$PATH:/opt/mssql-tools${msodbc_version}/bin"' >> /root/.zshrc;\
    echo '';\
    echo '================================';\
    echo 'Image building finishes';\
    echo '================================'

CMD [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND" ]
