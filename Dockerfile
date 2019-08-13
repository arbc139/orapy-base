# LICENSE UPL 1.0
#
# Copyright (c) 2014-2015 Oracle and/or its affiliates. All rights reserved.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
#
# Dockerfile template for Oracle Instant Client
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ==================================
# 
# From http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
#  Download the following three RPMs:
#    - oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
#    - oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
#    - oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm 
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put all downloaded files in the same directory as this Dockerfile
# Run: 
#      $ docker build -t oracle/instantclient:12.2.0.1 . 
#
#
FROM ubuntu:18.04

################### Install OracleInstantClient & Python #####################
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get -y autoremove && \
    apt-get clean

RUN apt-get install -y alien libaio1 libaio-dev vim

ADD oracle-instant-client/oracle-instantclient*.rpm /tmp/

RUN alien -i /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
    alien -i /tmp/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm && \
    alien -i /tmp/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm && \
    rm -f /tmp/oracle-instantclient*.rpm

RUN echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle.conf && \
    ldconfig

####################### Install Python Related Libraries ######################
RUN apt-get install -y python3 python3-pip

########################### Test cx_oracle library ############################
RUN pip3 install --upgrade pip
RUN pip3 install cx_Oracle jupyter \
        matplotlib scikit-learn pandas

########################## Setup jupyter notebook  ############################
RUN jupyter notebook --generate-config --allow-root && \
    echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py
EXPOSE 8888

#################### Setup OracleInstantClient Parameters  ####################
ENV TNS_ADMIN=/usr/lib/oracle/12.2/client64/lib/network/admin
ENV PATH=$PATH:/usr/lib/oracle/12.2/client64/bin

