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
RUN pip install numpy==1.14.5
RUN pip install pandas==0.23.3
RUN pip install python-dateutil==2.7.3
RUN pip install pytz==2018.3
RUN pip install six==1.11.0

RUN apt-get -y install postgresql postgresql-client
RUN apt-get install -qy python3-psycopg2
RUN apt-get install -qy python3-pystache
RUN apt-get install -qy python3-yaml
RUN apt-get -qy autoremove

RUN mkdir -p /var/www/app/fruit_sales/
WORKDIR /var/www/app/fruit_sales/
RUN git clone https://github.com/raguna2/fruit_sales.git
RUN pip install --upgrade pip
RUN pip install psycopg2
RUN pip install psycopg2-binary
WORKDIR /root/
RUN mkdir /root/.vim
RUN git clone https://github.com/Shougo/neobundle.vim /root/.vim/
COPY mybashrc /root/
RUN echo "" > /root/.bashrc
RUN cat mybashrc > /root/.bashrc
COPY mybash_profile /root/.bash_profile
COPY myvim /root/.vimrc
WORKDIR /var/www/app/fruit_sales/fruit_sales/
CMD ['/bin/bash']
