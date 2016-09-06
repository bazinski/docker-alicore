FROM centos:7 

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
        yum update -y && \
        yum install -y git gettext-devel cmake3 \
        make wget which gcc gcc-c++ libtool automake autoconf zip \
        exinfo bison flex openssl-devel \
        libxml2-devel swig perl-ExtUtils-Embed \
        environment-modules \
        libX11-devel mesa-libGLU-devel libXpm-devel libXft-devel \
        gcc-gfortran bzip2 bzip2-devel python-pip tmux screen \
        ncurses-devel texinfo python-devel \
        xorg-x11-fonts-Type1

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake && \
        cd /tmp && \
        curl -O http://mirror.ibcp.fr/pub/gnu/gsl/gsl-1.16.tar.gz && \
        tar -zvxf gsl-1.16.tar.gz && \
        cd gsl-1.16 && \
        ./configure && \
        make && make install && \
        rm -rf /tmp/gsl* 
        
# install a recent git
RUN yum install -y curl-devel && \
  wget https://github.com/git/git/archive/v2.8.3.tar.gz && \
  tar -zvxf v2.8.3.tar.gz && \
  cd git-2.8.3 && \
  make configure && \
  ./configure --prefix=/usr --with-curl && \
  make install && \
  cd .. && \
  rm -rf *2.8.3*


RUN pip install alibuild==1.4.0.rc1

RUN yum install -y libpng-devel yaml-cpp-devel

ADD bashrc /root/.bashrc

