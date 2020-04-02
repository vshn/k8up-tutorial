# Dockerfile used to create the
# vshn/wordpress-openshift:5.4-apache

FROM wordpress:5.4-apache

RUN sed -i "s/80/8080/g" /etc/apache2/ports.conf
RUN sed -i "s/80/8080/g" /etc/apache2/sites-available/000-default.conf
RUN sed -i "s/^ServerTokens OS$/ServerTokens Prod/" /etc/apache2/conf-enabled/security.conf
RUN sed -i "s/^ServerSignature On$/ServerSignature Off/" /etc/apache2/conf-enabled/security.conf
RUN echo "UseCanonicalName On" >> /etc/apache2/conf-enabled/security.conf

RUN { \
echo 'error_log=/var/log/apache2/php-error.log'; \
echo 'log_errors=On'; \
echo 'display_startup_errors=Off'; \
echo 'date.timezone=UTC'; \
echo 'session.cache_limiter = nocache'; \
echo 'session.auto_start = 0'; \
echo 'expose_php = off'; \
echo 'allow_url_fopen = off'; \
echo 'magic_quotes_gpc = off'; \
echo 'register_globals = off'; \
echo 'display_errors=Off'; \
} > /usr/local/etc/php/conf.d/php.ini

EXPOSE 8080
