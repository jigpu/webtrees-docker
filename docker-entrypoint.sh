#!/bin/sh

# Fix up permissions before we get started
chown -R www-data:www-data data
chmod -R 777 data

# Swap out the shell process for PHP
exec php-fpm
