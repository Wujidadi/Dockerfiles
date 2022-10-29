FROM ubuntu:18.04
LABEL MAINTAINER="wujidadi@gmail.com"

ARG user=user
ARG appdir=application
ARG nanoversion=4.9.3

# apt-get update/upgrade
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends apt-utils;\
# Date
    export DEBIAN_FRONTEND=noninteractive;\
    apt-get install -y --no-install-recommends tzdata;\
    ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime;\
    dpkg-reconfigure -f noninteractive tzdata;\
# Common applications
    apt-get install -y --no-install-recommends vim sudo expect bash-completion build-essential openssl libssl-dev net-tools iputils-ping nmap cron rsyslog zip unzip p7zip-full curl wget git zsh gosu rename screen tshark;\
# Add user
    useradd --create-home --shell /bin/bash $user;\
    adduser $user sudo;\
    echo 'root:3edc$RFV' | chpasswd;\
    echo 'user:5tgb^YHN' | chpasswd;\
# add-apt-repository, Apache and PHP
    apt-get install -y --no-install-recommends software-properties-common;\
    add-apt-repository -y ppa:ondrej/apache2;\
    add-apt-repository -y ppa:ondrej/php;\
    apt-get update && apt-get upgrade -y;\
    apt-get install -y --no-install-recommends php7.4 php7.4-cli php7.4-common php7.4-fpm php-pear php7.4-curl php7.4-dev php7.4-gd php7.4-json php7.4-mbstring php7.4-zip php7.4-mysql php7.4-opcache php7.4-readline php7.4-xml php7.4-tidy php7.4-imagick php7.4-gmp php7.4-bz2 php7.4-soap php7.4-bcmath php7.4-pgsql php7.4-sqlite3 apache2 apache2-doc apache2-utils libapache2-mod-php7.4 odbc-postgresql;\
    a2enmod headers;\
    a2enmod rewrite;\
# apache2.conf: AllowOverride All
    echo '' >> /etc/apache2/apache2.conf;\
    echo '<Directory /var/www/html>' >> /etc/apache2/apache2.conf;\
    echo '    AllowOverride All' >> /etc/apache2/apache2.conf;\
    echo '    Require all granted' >> /etc/apache2/apache2.conf;\
    echo '</Directory>' >> /etc/apache2/apache2.conf;\
# Change PHP timezone
    sed -i 's/;date\.timezone =/date.timezone = Asia\/Taipei/g' /etc/php/7.4/apache2/php.ini;\
    sed -i 's/;date\.timezone =/date.timezone = Asia\/Taipei/g' /etc/php/7.4/cli/php.ini;\
# Composer
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";\
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;";\
    php composer-setup.php;\
    php -r "unlink('composer-setup.php');";\
    mv composer.phar /usr/local/bin/composer;\
# Redis
    pecl channel-update pecl.php.net;\
    sh -c '/bin/echo "no" | pecl install redis';\
    echo '' >> /etc/php/7.4/apache2/php.ini;\
    echo 'extension=redis.so' >> /etc/php/7.4/apache2/php.ini;\
    echo '' >> /etc/php/7.4/cli/php.ini;\
    echo 'extension=redis.so' >> /etc/php/7.4/cli/php.ini;\
# MongoDB
    sh -c '/bin/echo "no" | pecl install mongodb';\
    echo 'extension=mongodb.so' >> /etc/php/7.4/apache2/php.ini;\
    echo 'extension=mongodb.so' >> /etc/php/7.4/cli/php.ini;\
# Node.js and npm
    apt install -y --no-install-recommends nodejs libssl1.0-dev nodejs-dev node-gyp npm;\
# GNU nano
    apt install -y --no-install-recommends libncursesw5-dev libslang2-dev;\
    cd /;\
    curl -OL https://www.nano-editor.org/dist/v4/nano-$nanoversion.tar.xz .;\
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
    chown -RHh $user:$user /home/$user/cron;\
# Add www-data to the same group with user
    gpasswd -a www-data user

# Install Oh My Zsh, link the directory to user's home and change shell to zsh
USER $user
RUN echo Y | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
USER root
RUN ln -s /home/$user/.oh-my-zsh /root;\
    chsh -s /bin/zsh;\
    chsh -s /bin/zsh $user

CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
