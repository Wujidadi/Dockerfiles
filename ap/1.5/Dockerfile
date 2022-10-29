FROM ubuntu:20.04
LABEL MAINTAINER="wujidadi@gmail.com"

ARG user=user
ARG appdir=application
ARG phpversion=7.4
ARG nanogreatversion=6
ARG nanoversion=6.2

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# apt-get update/upgrade
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && apt-get upgrade -y;\
# Date
    apt-get install -y --no-install-recommends tzdata;\
    ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime;\
    dpkg-reconfigure -f noninteractive tzdata;\
# Common applications
    apt-get install -y --no-install-recommends vim sudo expect bash-completion build-essential openssl libssl-dev net-tools iputils-ping nmap lsof cron rsyslog zip unzip p7zip-full curl wget locales git zsh gosu ca-certificates less rename screen sntp tshark;\
# Add user
    useradd --create-home --shell /bin/bash $user;\
    adduser $user sudo;\
    echo 'root:RootUser' | chpasswd;\
    echo "$user:APUser" | chpasswd;\
# Set the locale
    sed -i 's/# \(en_US\.UTF-8 .*\)/\1/g' /etc/locale.gen && locale-gen;\
# Node.js and npm
    apt-get install -y nodejs npm;\
# add-apt-repository, Apache and PHP
    apt-get install -y --no-install-recommends software-properties-common;\
    add-apt-repository -y ppa:ondrej/apache2;\
    add-apt-repository -y ppa:ondrej/php;\
    apt-get update && apt-get upgrade -y;\
    apt-get install -y --no-install-recommends php$phpversion php$phpversion-cli php$phpversion-common php$phpversion-fpm php-pear php$phpversion-curl php$phpversion-dev php$phpversion-gd php$phpversion-json php$phpversion-mbstring php$phpversion-zip php$phpversion-mysql php$phpversion-opcache php$phpversion-readline php$phpversion-xml php$phpversion-tidy php$phpversion-imagick php$phpversion-gmp php$phpversion-bz2 php$phpversion-soap php$phpversion-bcmath php$phpversion-pgsql php$phpversion-sqlite3 apache2 apache2-doc apache2-utils libapache2-mod-php$phpversion odbc-postgresql;\
    a2enmod headers;\
    a2enmod rewrite;\
# apache2.conf: AllowOverride All
    echo '' >> /etc/apache2/apache2.conf;\
    echo '# Custom patch settings' >> /etc/apache2/apache2.conf;\
    echo '<Directory /var/www/html>' >> /etc/apache2/apache2.conf;\
    echo '    AllowOverride All' >> /etc/apache2/apache2.conf;\
    echo '    Require all granted' >> /etc/apache2/apache2.conf;\
    echo '</Directory>' >> /etc/apache2/apache2.conf;\
# Change PHP precision
    sed -i 's/precision = 14/precision = 16/g' /etc/php/$phpversion/apache2/php.ini;\
    sed -i 's/precision = 14/precision = 16/g' /etc/php/$phpversion/cli/php.ini;\
# Change PHP timezone
    sed -i 's/;date\.timezone =/date.timezone = Asia\/Taipei/g' /etc/php/$phpversion/apache2/php.ini;\
    sed -i 's/;date\.timezone =/date.timezone = Asia\/Taipei/g' /etc/php/$phpversion/cli/php.ini;\
# Add PHP custom patch settings mark
    echo '' >> /etc/php/$phpversion/apache2/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/$phpversion/apache2/php.ini;\
    echo '; Custom Patch Settings ;' >> /etc/php/$phpversion/apache2/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/$phpversion/apache2/php.ini;\
    echo '' >> /etc/php/$phpversion/apache2/php.ini;\
    echo '' >> /etc/php/$phpversion/cli/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/$phpversion/cli/php.ini;\
    echo '; Custom Patch Settings ;' >> /etc/php/$phpversion/cli/php.ini;\
    echo ';;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php/$phpversion/cli/php.ini;\
    echo '' >> /etc/php/$phpversion/cli/php.ini;\
# Add www-data to the same group with user
    gpasswd -a www-data $user;\
# Composer (2.2.6)
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";\
    php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;";\
    php composer-setup.php;\
    php -r "unlink('composer-setup.php');";\
    mv composer.phar /usr/local/bin/composer;\
# Redis Driver for PHP
    pecl channel-update pecl.php.net;\
    sh -c '/bin/echo "no" | pecl install redis';\
    echo 'extension=redis.so' >> /etc/php/$phpversion/apache2/php.ini;\
    echo 'extension=redis.so' >> /etc/php/$phpversion/cli/php.ini;\
# MongoDB Driver for PHP
    sh -c '/bin/echo "no" | pecl install mongodb';\
    echo 'extension=mongodb.so' >> /etc/php/$phpversion/apache2/php.ini;\
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

CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
