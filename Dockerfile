FROM centos:7

ARG PYTHON_VERSION=3.6.8
RUN mkdir -p /tmp/python-src/Python-$PYTHON_VERSION
WORKDIR /tmp/python-src/Python-$PYTHON_VERSION
RUN yum check-update \
    && yum -y groupinstall "Development tools" \
    && yum -y install wget zlib-devel bzip2-devel openssl-devel ncurses-devel libxml2-devel libxslt-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libjpeg-devel \
    && wget --no-check-certificate https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz -O /tmp/python.tgz \
    && tar -zxvf /tmp/python.tgz -C /tmp/python-src \
    && ./configure --prefix=/usr/local LDFLAGS="-Wl,-rpath /usr/local/lib" --with-ensurepip=install --enable-optimizations --with-lto \
    && make \
    && make altinstall \
    && rm -rf /tmp/python-src /tmp/python.tgz \
    && yum -y groupremove "Development tools" \
    && yum -y remove wget zlib-devel bzip2-devel openssl-devel ncurses-devel libxml2-devel libxslt-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libjpeg-devel \
    && yum clean all

