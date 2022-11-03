FROM wujidadi/ap:1.5-arm
LABEL MAINTAINER="wujidadi@gmail.com"

ARG phpversion=7.4
ARG nodeversion=18
ARG nanogreatversion=6
ARG nanoversion=6.4

# Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_${nodeversion}.x | sudo -E bash -;\
    apt-get install -y nodejs;\
# Composer
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";\
    php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;";\
    php composer-setup.php;\
    php -r "unlink('composer-setup.php');";\
    mv composer.phar /usr/local/bin/composer;\
# Microsoft SQL Server Driver for PHP with Microsoft ODBC 18
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -;\
    curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list;\
    apt-get update;\
    ACCEPT_EULA=Y apt-get install -y msodbcsql18;\
    ACCEPT_EULA=Y apt-get install -y mssql-tools18;\
    apt-get -y install unixodbc-dev;\
    pecl install sqlsrv pdo_sqlsrv;\
    echo "; priority=20\nextension=sqlsrv.so\n" > /etc/php/${phpversion}/mods-available/sqlsrv.ini;\
    echo "; priority=20\nextension=pdo_sqlsrv.so\n" > /etc/php/${phpversion}/mods-available/pdo_sqlsrv.ini;\
    phpenmod sqlsrv pdo_sqlsrv;\
# Vim
    add-apt-repository ppa:jonathonf/vim;\
    apt-get update && apt-get upgrade -y;\
    apt-get install -y --no-install-recommends vim;\
# GNU nano
    apt install -y --no-install-recommends libncursesw5-dev libslang2-dev;\
    cd /;\
    curl -OL https://www.nano-editor.org/dist/v${nanogreatversion}/nano-${nanoversion}.tar.xz /;\
    tar xvf nano-${nanoversion}.tar.xz -C / ; cd /nano-${nanoversion};\
    ./configure --enable-utf8;\
    make && make install;\
    cd .. ; rm -rf nano-${nanoversion} nano-${nanoversion}.tar.xz;\
    echo "include /usr/local/share/nano/*.nanorc" >> /root/.nanorc;\
    echo "include /usr/local/share/nano/*.nanorc" >> /home/${user}/.nanorc;\
    chown ${user}:${user} /home/${user}/.nanorc;\
# Clean apt
    apt-get autoremove -y;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*

CMD [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND" ]
