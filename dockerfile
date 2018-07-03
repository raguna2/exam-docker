FROM python:3.6.2
MAINTAINER kutsumi.for.public@gmail.com

EXPOSE 8000
EXPOSE 5432

RUN apt-get clean
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get -y install build-essential
RUN apt-get -y install mercurial
RUN apt-get -y install libncurses5-dev libncursesw5-dev
RUN apt-get -y install automake
WORKDIR /usr/local/src
RUN hg clone https://bitbucket.org/vim-mirror/vim vim
WORKDIR /usr/local/src/vim
RUN ./configure --with-features=huge --enable-multibyte --disable-selinux
RUN make
RUN make install
RUN apt-get -y install sed
RUN apt-get -y install expect
RUN apt-get -y install sudo

# Djangoインストール
RUN pip install django==1.11.4
# RUN apt-get install -y postgresql84 postgresql84-server postgresql84-contrib
RUN apt-get -y install postgresql postgresql-client
RUN apt-get install -qy python3-psycopg2
RUN apt-get install -qy python3-pystache
RUN apt-get install -qy python3-yaml
RUN apt-get -qy autoremove

RUN mkdir -p /var/www/app/
WORKDIR /var/www/app/
RUN pip install psycopg2
RUN pip install psycopg2-binary
RUN pip install social-auth-app-django
RUN pip install Pillow
RUN pip install requests requests-oauthlib
WORKDIR /root/
RUN mkdir /root/.vim
RUN git clone https://github.com/Shougo/neobundle.vim /root/.vim/
COPY mybashrc /root/
RUN echo "" > /root/.bashrc
RUN cat mybashrc > /root/.bashrc
COPY mybash_profile /root/.bash_profile
COPY myvim /root/.vimrc
WORKDIR /var/www/app/
CMD ['/bin/bash']
