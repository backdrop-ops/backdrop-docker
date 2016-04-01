# Supported tags and respective `Dockerfile` links

- [`1.3.4-apache`, `1.3.4`, `1-apache`, `1` (*1/apache/Dockerfile*)](https://github.com/kalabox/backdrop-docker/blob/master/1/apache/Dockerfile)
- [`1.3.4-fpm`, `1-fpm` (*1/fpm/Dockerfile*)](https://github.com/kalabox/backdrop-docker/blob/master/1/fpm/Dockerfile)

[![](https://badge.imagelayers.io/kalabox/backdrop:latest.svg)](https://imagelayers.io/?images=kalabox/backdrop:latest 'Get your own badge on imagelayers.io')

# What is Backdrop?

The comprehensive CMS for small to medium sized businesses and non-profits.

![logo](https://backdropcms.org/files/inline-images/Backdrop-Logo-Vertical_0.png)

# How to use this image

The basic pattern for starting a `backdrop` instance is:

```console
$ docker run --name some-backdrop -d kalabox/backdrop
```

If you'd like to be able to access the instance from the host without the container's IP, standard port mappings can be used:

```console
$ docker run --name some-backdrop -p 8080:80 kalabox/backdrop
```

Then, access it via `http://localhost:8080` or `http://host-ip:8080` in a browser.

There are multiple database types supported by this image, most easily used via standard container linking. In the default configuration, SQLite can be used to avoid a second container and write to flat-files. More detailed instructions for different (more production-ready) database types follow.

When first accessing the webserver provided by this image, it will go through a brief setup process. The details provided below are specifically for the "Set up database" step of that configuration process.

## MySQL

```console
$ docker run --name some-backdrop --link some-mysql:mysql -d kalabox/backdrop
```

- Database type: `MySQL, MariaDB, or equivalent`
- Database name/username/password: `<details for accessing your MySQL instance>` (`MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_DATABASE`; see environment variables in the description for [`mysql`](https://registry.hub.docker.com/_/mysql/))
- ADVANCED OPTIONS; Database host: `mysql` (for using the `/etc/hosts` entry added by `--link` to access the linked container's MySQL instance)

## PostgreSQL

```console
$ docker run --name some-backdrop --link some-postgres:postgres -d kalabox/backdrop
```

- Database type: `PostgreSQL`
- Database name/username/password: `<details for accessing your PostgreSQL instance>` (`POSTGRES_USER`, `POSTGRES_PASSWORD`; see environment variables in the description for [`postgres`](https://registry.hub.docker.com/_/postgres/))
- ADVANCED OPTIONS; Database host: `postgres` (for using the `/etc/hosts` entry added by `--link` to access the linked container's PostgreSQL instance)

## Adding additional libraries / extensions

This image does not provide any additional PHP extensions or other libraries, even if they are required by popular plugins. There are an infinite number of possible plugins, and they potentially require any extension PHP supports. Including every PHP extension that exists would dramatically increase the image size.

If you need additional PHP extensions, you'll need to create your own image `FROM` this one. The [documentation of the `php` image](https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions) explains how to compile additional extensions. Additionally, the [`drupal:7` Dockerfile](https://github.com/docker-library/drupal/blob/bee08efba505b740a14d68254d6e51af7ab2f3ea/7/Dockerfile#L6-9) has an example of doing this.

The following Docker Hub features can help with the task of keeping your dependent images up-to-date:

- [Automated Builds](https://docs.docker.com/docker-hub/builds/) let Docker Hub automatically build your Dockerfile each time you push changes to it.
- [Repository Links](https://docs.docker.com/docker-hub/builds/#repository-links) can ensure that your image is also rebuilt any time `drupal` is updated.

# License

View [license information](https://www.drupal.org/licensing/faq) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 1.10.3.

Support for older versions (down to 1.6) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.

# User Feedback

## Documentation

 > @todo: link to backdrop site?

## Issues

 > @todo: link to backdrop site?

## Contributing

 >  @todo: link to backdrop site?

