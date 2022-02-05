FROM almalinux:8
MAINTAINER Zhenyu Li <puregion@qq.com>

ENV MARIADB_MAJOR 10.6
ENV MARIADB_VERSION 10.6.5
ENV MYSQL_ROOT_PASSWORD mysecretpassword
ENV MYSQL_DATADIR /var/lib/mysql

COPY MariaDB.repo /etc/yum.repos.d/
RUN mkdir /var/lib/mysql \
    && mkdir -p /var/log/mysql \
    && chown mysql:mysql /var/log/mysql \
    && yum -y update \
    &&yum clean all
# Install requirements.
RUN yum -y install initscripts \
 && yum -y update \
 && yum -y dnf \
      sudo \
      systemctl \
 && yum clean all

    && sudo dnf install -y https://packages.groonga.org/almalinux/8/groonga-release-latest.noarch.rpm \
    && sudo dnf install -y boost-program-options \
    && sudo dnf install --disablerepo=AppStream -y MariaDB-server \
    && sudo systemctl start mariadb \
    && sudo dnf install -y --enablerepo=epel mariadb-10.6-mroonga \
    && dnf clean all

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
