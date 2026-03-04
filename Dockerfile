FROM composer:2 AS vendor
WORKDIR /app
COPY composer.* ./
RUN composer install --no-dev --optimize

FROM php:8.3-fpm-alpine AS runtime
COPY --from=vendor /app/vendor ./vendor
COPY . .
RUN addgroup -g 1000 laravel && adduser -D -u 1000 -G laravel laravel
USER laravel
EXPOSE 9000
CMD ["php-fpm"]
