FROM devfactory/workspace-full:latest

# Heavily inspired from https://github.com/domm/perl-docker/blob/main/Dockerfile.perl5.36-app-base

RUN wget https://www.cpan.org/src/5.0/perl-5.36.0.tar.gz

RUN tar -xvzf perl-5.36.0.tar.gz 
RUN cd perl-5.36.0  \
    && ./Configure -des \
        -Duse64bitall \
        -Dcccdlflags='-fPIC' \
        -Dcccdlflags='-fPIC' \
        -Dccdlflags='-rdynamic' \
        -Dlocincpth=' ' \
        -Duselargefiles \
        -Dusethreads \
        -Duseshrplib \
        -Dd_semctl_semun \
        -Dusenm \
        -Dprefix='/opt/perl' \
    && make -j 4 \
    && sudo make install 

RUN 'export PATH=/opt/perl/bin:$PATH' >> /home/gitpod/.bashrc



#RUN curl -o /tmp/cpm -sL --compressed https://git.io/cpm \
#    && chmod 755 /tmp/cpm \
#    && /tmp/cpm install -g App::cpm IO::Socket::SSL Cpanel::JSON::XS \
#    && rm -fr /root/.perl-cpm /tmp/cpm
