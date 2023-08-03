FROM ubuntu:22.04
LABEL MAINTAINER="wujidadi@gmail.com"

ARG user=user
ARG vim_tag=v9.0.1677
ARG nano_great_version=7
ARG nano_version=7.2

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
    echo '=============================================';\
    echo 'Installing apt software-properties-common ...';\
    echo '=============================================';\
    echo '';\
    apt-get install -y --no-install-recommends software-properties-common;\
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
    rm -rf /var/lib/apt/lists/*

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
    git config --global core.pager 'less --raw-control-chars'
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
    echo '================================';\
    echo 'Image building finishes';\
    echo '================================'

CMD [ "/bin/zsh", "-l" ]
