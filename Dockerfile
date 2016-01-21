FROM ubuntu:15.10
RUN apt-get update
RUN apt-get install -y nginx openssh-server git-core openssh-client curl
RUN apt-get install -y nano
RUN apt-get install -y build-essential
RUN apt-get install -y openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison pkg-config sudo
RUN apt-get install -y libpq-dev freetds-dev
RUN mkdir /thingy
VOLUME '/thingy'
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.2.1"
RUN /bin/bash -l -c "rvm use 2.2.1 do gem install bundler --no-ri --no-rdoc"
RUN useradd app -G rvm -u 1000 -s /bin/bash -m
RUN chown app /thingy
USER app
WORKDIR /thingy
ADD Gemfile . 
ADD Gemfile.lock .
#ADD vendor ./vendor
RUN /bin/bash -l -c "rvm use 2.2.1 do bundle install"
