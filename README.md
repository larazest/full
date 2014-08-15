Ubuntu Docker container for Laravel web applications
====================================================

Larazest/production is an image for running [Laravel]
(https://github.com/laravel/laravel) applications, with some extra tools.

If you don't need the extra tools, just use [larazest/base]
(https://github.com/larazest/production).

- NGINX
- PHP5 with mcyrpt and mysqlnd
- MySQL client and server
- Git
- Composer

Extra tools:

- Ruby and some gems
- wkhtmltopdf

It extends:

- [larazest/base](https://github.com/larazest/production)
- [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker)