# Laravel için PHP 8.2 ve Composer içeren resmi bir image kullanıyoruz
FROM composer:2.6 AS vendor

WORKDIR /app

# Proje dosyalarını ekliyoruz
COPY . .

# Tüm bağımlılıkları yüklüyoruz
RUN composer install --no-dev --optimize-autoloader

# Production için PHP image
FROM php:8.2-cli

# Gerekli PHP eklentilerini yüklüyoruz
RUN apt-get update && apt-get install -y libpng-dev libonig-dev libxml2-dev zip unzip git curl \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

WORKDIR /app

# Vendor klasörünü ekliyoruz
COPY --from=vendor /app /app

# Laravel için storage ve bootstrap/cache izinlerini ayarlıyoruz
RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache

# Port
EXPOSE 10000

# Uygulama başlatma komutu
CMD php artisan serve --host 0.0.0.0 --port 10000
