FROM ubuntu:20.04
LABEL MAINTAINER="wujidadi@gmail.com"

ARG user=user
ARG nanogreatversion=5
ARG nanoversion=5.6.1

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
    apt-get install -y --no-install-recommends vim sudo expect bash-completion build-essential openssl libssl-dev net-tools iputils-ping nmap lsof cron rsyslog zip unzip p7zip-full curl wget ca-certificates locales git zsh gosu less rename screen tshark;\
# Add user
    useradd --create-home --shell /bin/bash $user;\
    adduser $user sudo;\
    echo 'root:9ol.)P:?<' | chpasswd;\
    echo "$user:7ujm*IK<" | chpasswd;\
# Set the locale
    sed -i 's/# \(en_US\.UTF-8 .*\)/\1/g' /etc/locale.gen && locale-gen;\
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
    git config --global core.pager 'less --raw-control-chars'
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

CMD [ "/bin/zsh", "-l" ]
