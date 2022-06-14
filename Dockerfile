FROM bitnami/minideb:bullseye

ENV APACHE_RUN_DIR /var/www/html

RUN apt update -y && apt upgrade -y
RUN apt install ca-certificates apt-transport-https lsb-release wget curl gnupg -y
RUN wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt update -y

RUN apt install apache2 -y
RUN apt install php8.1 php8.1-cli php8.1-common php8.1-curl php8.1-mbstring php8.1-mysql php8.1-xml php8.1-zip systemctl -y

RUN a2enmod php8.1
RUN systemctl stop apache2

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]

