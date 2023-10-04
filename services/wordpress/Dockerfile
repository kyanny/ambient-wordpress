FROM centos:7

# 必要なパッケージのインストール
RUN yum -y update && \
    yum -y install httpd wget unzip vim less && \
    yum -y install epel-release && \
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y install yum-utils && \
    yum-config-manager --enable remi-php81 && \
    yum -y install php php-mysql php-gd php-xml php-mbstring php-json php-opcache php-cli php-curl php-mysqlnd

RUN wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
RUN rpm -ivh mysql80-community-release-el7-3.noarch.rpm
RUN sed -i '/^\[mysql80-community\]/,/^\[/ s/^gpgcheck=.*/gpgcheck=0/' /etc/yum.repos.d/mysql-community.repo
RUN yum clean all
RUN yum install mysql-community-client -y

# タイムゾーンの設定
ENV TZ "Asia/Tokyo"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# # Apacheの設定
# RUN sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf

RUN yum -y install mod_ssl
RUN openssl genrsa -out server.key
RUN echo "subjectAltName = DNS:localhost, DNS:*.app.github.dev" > extfile.txt
RUN openssl req -new -key server.key -out server.csr -subj "/CN=localhost"
RUN openssl x509 -req -days 365 -in server.csr -signkey server.key -extfile extfile.txt -out server.crt
RUN cp -a server.key /etc/httpd/conf
RUN cp -a server.crt /etc/httpd/conf
RUN sed -i.bak -e "s/^SSLCertificateFile .*$/SSLCertificateFile \/etc\/httpd\/conf\/server.crt/" -e "s/^SSLCertificateKeyFile .*$/SSLCertificateKeyFile \/etc\/httpd\/conf\/server.key/" /etc/httpd/conf.d/ssl.conf


#WP CLI インストール
WORKDIR /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp

# WordPressのダウンロードと設定
WORKDIR /var/www/html
RUN curl -O https://ja.wordpress.org/latest-ja.tar.gz
RUN tar -xzf latest-ja.tar.gz --strip-components=1

# データベース接続情報
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOST

# wp-config.phpの作成
RUN cp wp-config-sample.php wp-config.php
RUN sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
RUN sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
RUN sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
RUN sed -i "s/localhost/$MYSQL_HOST/g" wp-config.php

ADD wp-config-extra.txt .
RUN perl -i.bak -nle 'BEGIN{open $fh, "<", "wp-config-extra.txt"; $content = do { local $/; <$fh> }}; if(/Add any custom values between this line and the "stop editing" line\./){print; print $content} else {print}' wp-config.php


# Apacheをフォアグラウンドで動かす
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80
