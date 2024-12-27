# What is Backdrop?

_**TL;DR:  Backdrop is an exciting and promising way forward for organizations seeking a means of leaving legacy Drupal behind in a way that preserves Drupal-related investments of time, energy, people and money as much as possible.**_

Backdrop is a web application development framework most commonly configured as a Content Management System (CMS) for use by:

- Small & Medium Sized Enterprises (SME)
- Governments & Government Departments
- Non-Governmental Organizations (NGO)
- Non-Profit Organizations (NPO)
- Educational Institutions (EI).  

Backdrop started off as a "fork" of an immensely popular Drupal 7.  The genesis of the Backdrop CMS Project was the release of Drupal 8.  That release (and every subsequent Drupal release thereafter) introduced an explosion in uncertainty, complexity and cost.  Some of the key goals of Backdrop are predictability, reliability, controlled complexity and maximum compatibility with the code base of Drupal 7 - especially in terms of compatibility with Drupal 7 contributed modules and themes.  There are over 16,000+ contributed Drupal 7 modules and themes, representing a near-infinite range of solutions. 

Since 2013, Backdrop has remained true to its goals.  Now, a Backdrop conversion can take a small fraction of the time and expense involved with migrating to a different CMS (usually Wordpress), using a cloud-based provider (WIX or Shopify) or even upgrading to the latest version of Drupal.  Many organizations have already leveraged the power of Backdrop to move away from legacy Drupal, especially Drupal 7, in a way that they feel is the fastest, easiest and least expensive way possible.  

The Backdrop Project was started over a decade ago.  To date, its story is marked by a string of successes:  It is being continually improved.  It offers the latest technologies.  New versions of Backdrop are released in a regular and methodical way.  Backdrop releases are supported for a very long time.  New (and converted) Backdrop modules and themes are arriving ever more frequently.  It has a dedicated, mature, experienced and highly professional project team.

The latest edition of Backdrop is **1.29.2**.

_(a full list of every docker image available for Backdrop, including legacy and alternative versions, appears at the end of this document)_

# What is Docker?
According to Amazon, Docker is:

_"A software platform that allows you to build, test, and deploy applications quickly. Docker packages software into standardized units called containers that have everything the software needs to run including libraries, system tools, code, and runtime."_

# What are Backdrop Docker Official Image(s)?
Backdrop Docker Official Images is a collection of Docker images intended to enable almost anyone to be able to install and evaluate Backdrop in a fast and cost-effective manner.  Working in concert with this documentation, this collection is designed to empower even "slightly" technical people with the ability to "spin up" a Backdrop instance with a minimal investment in time, money and effort.

# Tags
## Apache 2 (apache)

[`latest`](https://github.com/kalabox/backdrop-docker/blob/master/1/apache/Dockerfile)
[`backdrop`](https://github.com/kalabox/backdrop-docker/blob/master/1/apache/Dockerfile)
[`1.29.2-apache`](https://github.com/kalabox/backdrop-docker/blob/master/1/apache/Dockerfile)
[`1.29.2`](https://github.com/kalabox/backdrop-docker/blob/master/1/apache/Dockerfile)
[`1-apache`](https://github.com/kalabox/backdrop-docker/blob/master/1/apache/Dockerfile)
[`1`](https://github.com/kalabox/backdrop-docker/blob/master/1/apache/Dockerfile)

Source [*Dockerfile*](https://github.com/kalabox/backdrop-docker/blob/master/1/apache/Dockerfile)
  
## FastCGI Process Manager (fpm)
[`1.29.2-fpm`](https://github.com/kalabox/backdrop-docker/blob/master/1/fpm/Dockerfile)
[`1-fpm`](https://github.com/kalabox/backdrop-docker/blob/master/1/fpm/Dockerfile)

Source [*Dockerfile*](https://github.com/kalabox/backdrop-docker/blob/master/1/fpm/Dockerfile)

# Use
The fastest and easiest way to "spin up" any of the above-mentioned Backdrop containers with docker is to:

 1)  Install docker on a host system
 2)  Create a named directory to marshal docker-related Backdrop assets
 3)  Create a docker startup file that references a specific Backdrop docker image
 4)  Launch docker in such a way that it processes the startup file

## Step 1:  Install docker on a host system
[Docker's installation instructions for Windows, Mac and Linux](https://www.docker.com/get-started)

## Step 2:  Create a named directory to marshal docker-related Backdrop assets
In this case we will create a directory named `backdrop-eval` to help assemble together some Backdrop-related docker assets

`md backdrop-eval`

`cd backdrop-eval`

## Step 3:  Create a docker startup file that references a specific Backdrop docker image
In the `backdrop-eval` directory, create `compose.yml` file with the following contents:

```yaml
services:
  backdrop:
    build:
      context: ./1/apache
    ports:
      - 8088:80
    environment:
      BACKDROP_DB_HOST: db
      BACKDROP_DB_USER: backdrop
      BACKDROP_DB_PASSWORD: backdrop

  db:
    image: mysql
    environment:
      MYSQL_USER: backdrop
      MYSQL_PASSWORD: backdrop
      MYSQL_ALLOW_EMPTY_PASSWORD: 'yes'
      MYSQL_DATABASE: backdrop
```

## Step 4:  Launch docker in such a way that it processes the startup file
While in the `docker-eval` directory, enter the following command:

`docker compose up`

This command instructs docker to process the `compose.yml` file.  The screen should immediately begin to fill with startup messages as docker composes the Backdrop runtime environment.  After a minute or so, the pace of new messages should settle down, with just status messages being displayed.  At this point the Backdrop installation screen should be accessible via a web browser.

### Accessing a remote docker container
If the web browser is running on a different machine than the one running docker, the Backdrop installation should be accessible at:

`http://{host-ip}:8080`.

Where `{host-ip}` is the IP address of the machine running docker.

### Accessing a local docker container
If the web browser is running on the same machine as docker, the Backdrop installation should be accessible at:

`http://localhost:8080` 

### 'compose.yml` Embedded Credentials
The credentials embedded in the `compose.yml` will be required in the Backdrop installation routine:

```
User:      backdrop
Password:  backdrop
Database:  backdrop
```

## How to validate the docker-based backdrop runtime environment
Validating that backdrop indeed constructed a valid runtime environment may be accomplished with the following command:

```
docker ps
```

The resulting listing should include TWO (2) docker containers, one for the database server (db), one for the CMS (backdrop).

## How to access the docker-based backdrop runtime environment
Accessing the docker container may be accomplished with the following command:

```
docker exec -it backdrop bash
```

## Trying out other docker images
The above `compose.yml` specifically references the `backdrop/backdrop` docker image.  

This is just an example to help get you started.  Once you are familiar with how to "spin up" a docker image, there is nothing to stop you from trying out different docker images to find the one you like the best.  A complete listing of all available backdrop docker images is available at the end of this document.

# Backdrop
![logo](https://backdropcms.org/files/inline-images/Backdrop-Logo-Vertical_0.png)

# License

View [license information](https://www.drupal.org/licensing/faq) for the software contained in this image.

# Feedback

## Issue Queue(s)
- [Backdrop CMS Core Issue Queue](https://github.com/backdrop/backdrop-issues/issues)
- [Backdrop CMS Contrib at Github.com](https://github.com/backdrop-contrib) - Each contrib project has it's own issue queue.

## Documentation
- [Backdrop CMS Documentation](https://docs.backdropcms.org/)

## Contributing
- [Contribute to the Backdrop CMS Open Source Project](https://docs.backdropcms.org/documentation/contributors-guide)

## Official Docker Image

https://github.com/docker-library/official-images/blob/master/library/backdrop

# Expert Mode

## Installing additional libraries & extensions
These images do not provide any additional PHP extensions or other libraries, even if they are required by popular plugins. There are an infinite number of possible plugins, and they potentially require any extension PHP supports. Including every PHP extension that exists would dramatically increase the image size.  

## Generating your own docker image(s)
If you need additional PHP extensions, you'll need to create your own image `FROM` this one. The [documentation of the `php` image](https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions) explains how to compile additional extensions. Additionally, the [`drupal:7` Dockerfile](https://github.com/docker-library/drupal/blob/bee08efba505b740a14d68254d6e51af7ab2f3ea/7/Dockerfile#L6-9) has an example of doing this.

The following Docker Hub features can help with the task of keeping your dependent images up-to-date:

- [Automated Builds](https://docs.docker.com/docker-hub/builds/) let Docker Hub automatically build your Dockerfile each time you push changes to it.
- [Repository Links](https://docs.docker.com/docker-hub/builds/#repository-links) can ensure that your image is also rebuilt any time `drupal` is updated.

## Launching backdrop manually using `docker run` commands

### MySQL
NOTE:  A pre-configured database server must already exist before a backdrop container can be launched.

Check out the [official mysql image](https://hub.docker.com/_/mysql/) for more info on spinning up a DB.

## Backdrop
The basic pattern for starting a `backdrop` instance (given that the `BACKDROP_DB_NAME` **already exists** on a running MySQL server container) is:

```console
docker run --name some-backdrop --link some-mysql:mysql -d backdrop/backdrop
```

The following environment variables are also honored for configuring your Backdrop CMS instance:

- `-e BACKDROP_DB_HOST=...` (defaults to the IP and port of the linked `mysql` container)
- `-e BACKDROP_DB_USER=...` (defaults to "root")
- `-e BACKDROP_DB_PASSWORD=...` (defaults to the value of the `MYSQL_ROOT_PASSWORD` environment variable from the linked `mysql` container)
- `-e BACKDROP_DB_NAME=...` (defaults to "backdrop")
- `-e BACKDROP_DB_PORT=...` (defaults to 3306)
- `-e BACKDROP_DB_DRIVER=...` (defaults to "mysql")


If you'd like to be able to access the instance from the host without the container's IP, standard port mappings can be used:

```console
docker run --name some-backdrop --link some-mysql:mysql -p 8080:80 -d backdrop/backdrop
```

Then, access it via `http://localhost:8080` or `http://host-ip:8080` in a browser.

If you'd like to use an external database instead of a linked `mysql` container, specify the hostname and port with `BACKDROP_DB_HOST`/`BACKDROP_DB_PORT` along with the password in `BACKDROP_DB_PASSWORD` and the username in `BACKDROP_DB_USER` (if it is something other than `root`):

```console
docker run --name some-backdrop \
  -e BACKDROP_DB_HOST=10.1.2.3 \
  -e BACKDROP_DB_PORT=10432 \
  -e BACKDROP_DB_USER=... \
  -e BACKDROP_DB_PASSWORD=... \
  -d backdrop/backdrop
```

# Backdrop Dockerfile archive
## 1.30.0 (coming Januaray 2025)
`1.30.2-apache`
`1.30.2-fpm`

## 1.29.2
[`1.29.2-apache`](https://github.com/kalabox/backdrop-docker/blob/master/1/apache/Dockerfile)
[`1.29.2-fpm`](https://github.com/kalabox/backdrop-docker/blob/master/1/fpm/Dockerfile)

## 1.29.6
[`1.29.6-apache`]()
[`1.29.6-fpm`]()
