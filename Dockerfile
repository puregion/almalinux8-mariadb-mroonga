FROM almalinux:latest
MAINTAINER Zhenyu Li <puregion@qq.com>

ENV MARIADB_MAJOR 10.6
ENV MARIADB_VERSION 10.6.5
ENV MYSQL_ROOT_PASSWORD mysecretpassword
ENV MYSQL_DATADIR /var/lib/mysql

COPY MariaDB.repo /etc/yum.repos.d/
RUN mkdir -p /var/lib/mysql \
  && mkdir -p /var/log/mysql

# Install requirements.
RUN yum -y install dnf \
 && yum -y install sudo \
 && sudo  yum -y install libpmem \
 && sudo  yum -y install galera-4 \
 && sudo  dnf --enablerepo=powertools install  -y gflags \
 && sudo  dnf --enablerepo=powertools install  -y glog  \
 && sudo  dnf -y update \
 && sudo dnf install -y https://packages.groonga.org/almalinux/8/groonga-release-latest.noarch.rpm \
 && sudo dnf install -y boost-program-options \
 && sudo dnf install -y MariaDB-server --disablerepo=appstream \
 && sudo dnf install -y --enablerepo=epel mariadb-10.6-mroonga \
 && dnf clean all \
 && chown mysql:mysql /var/log/mysql

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld_safe"]
