FROM ubuntu:20.04

ENV OS_LOCALE="en_US.utf8" \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y locales wget apt-utils software-properties-common dirmngr apt-transport-https lsb-release ca-certificates &&\   
    locale-gen ${OS_LOCALE} &&\
    apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc' &&\
    add-apt-repository 'deb [arch=amd64] http://mariadb.mirror.globo.tech/repo/10.5/ubuntu focal main' &&\
    apt-get update &&\
    apt-get install -y mariadb-server mariadb-client &&\
    apt-get upgrade -y 
    
ENV LANG=${OS_LOCALE} \
    LANGUAGE=${OS_LOCALE} \
    LC_ALL=${OS_LOCALE} 	    
    
COPY ["start_node_exporter.sh", \
      "start_mysqld_exporter.sh", \
      ".my.cnf","/tmp/"]

USER root

# RUN cat /etc/passwd | grep mysql

# RUN groupadd -g 1001 mysql

# RUN useradd -m -u 1001 -r -g 1001 mysql

WORKDIR /tmp/

RUN wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz 

RUN wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.13.0/mysqld_exporter-0.13.0.linux-amd64.tar.gz

RUN mkdir -p /opt/exporters/ && \
    tar -xzvf ./node_exporter-1.3.1.linux-amd64.tar.gz -C /opt/exporters && \
    tar -xzvf ./mysqld_exporter-0.13.0.linux-amd64.tar.gz -C /opt/exporters
    
WORKDIR /opt/exporters/

RUN mv node_exporter-1.3.1.linux-amd64 node_exporter && \
    mv mysqld_exporter-0.13.0.linux-amd64 mysqld_exporter && \
    mv /tmp/start_node_exporter.sh /opt/exporters/node_exporter/ && \
    mv /tmp/start_mysqld_exporter.sh /opt/exporters/mysqld_exporter/ && \
    mv /tmp/.my.cnf /opt/exporters/mysqld_exporter/ && \
    chmod o+x /opt/exporters/node_exporter/start_node_exporter.sh && \
    chmod o+x /opt/exporters/mysqld_exporter/start_mysqld_exporter.sh && \
    rm -rf /tmp/*.rpm && \
    /usr/bin/install -m 0775 -o mysql -g mysql -d /var/lib/mysql \
    /var/run/mysqld /docker-entrypoint-initdb.d

RUN apt-get purge -y --auto-remove software-properties-common wget gnupg &&\
    apt-get autoremove -y && apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/lib/mysql", "/var/log/mysql","/etc/percona-server.conf.d"]

COPY ps-entry.sh /tmp/docker-entrypoint.sh

RUN chmod +x /tmp/docker-entrypoint.sh

ENTRYPOINT ["/tmp/docker-entrypoint.sh"]

USER mysql

EXPOSE 3306

CMD ["mysqld"]

# ADD catalina.sh /tmp/catalina.sh

# RUN chmod +x /tmp/catalina.sh

# CMD ["/tmp/catalina.sh"]
