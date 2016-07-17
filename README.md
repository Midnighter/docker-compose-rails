# Step-by-step Guide for Server Setup

This project helps you set up a rails development environment using
Docker Compose and a PostgreSQL database. It will be developed further to
include nginx and other services such as elastic search. The local build of the
Docker image will also be moved to and versioned on Docker Hub.

## General Steps

This section assumes that you are using Debian or one of its derivates.

1. Check whether your Kernel is suitable for Docker (should be >= 3.10):

   ```
   uname -r
   ```

2. All following commands assume root, otherwise preprend with `sudo`.  Update
   the system (use `apt` starting Ubuntu 16.04):

   ```
   apt-get update
   apt-get upgrade
   apt-get dist-upgrade
   ```

3. Check and set locale:

   ```
   locale
   ```

    1. In case some language packs are missing install, for example, `en` and
       regenerate.

       ```
       apt-get install language-pack-en-base
       locale-gen
       ```

    2. Then set up new locale:

       ```
       update-locale LANG=en_US.UTF-8 LC_ALL=en_IE.UTF-8
       ```

    3. Log out and back in:

       ```
       locale > /etc/default/locale
       ```

    4. Edit `/etc/default/locale` to say:

       ```
       LANG=en_US.UTF-8
       ...
       LC_MESSAGES="en_US.UTF-8"
       ...
       LC_ALL=
       ```

## Docker Compose Steps

1. Install Docker and Docker Compose:

    1. Follow the instructions to [install docker-compose](https://docs.docker.com/v1.11/compose/install/).

    2. Get the Docker images needed later in the process:

       ```
       docker pull ruby:2.3
       docker pull postgres:9.5
       docker pull elasticsearch:2.3
       docker pull nginx:1.10
       ```

2. Setup and run the project:

    1. Get the repository for the setup code:

       ```
       git clone https://github.com/Midnighter/docker-compose-rails
       ```

       (Create `install.sh` script?)

    2. Make the files in the repo private, `chmod -R go= *`
    2. Edit the `db.env` which is used to set up the PostgreSQL superuser.
    3. Edit the `app.env` file to match your needs.
    3. Generate the required files using the declared variables `./generate.sh`
    3. Build the container for the rails app `docker-compose build`
    3. Start the services together `docker-compose up` and exit again (this will
       run `initdb`)
    3. Make yourself owner of the storage directory `sudo chown -R <username>:docker <dir>` (this is pointless if you do the next edit as root)
    3. Edit the `pg_hba.conf` and set methods from `trust` to `md5`?
    3. Start the services together `docker-compose up`
    3. In a different terminal: Setup the tables and seed
       the database `docker-compose run --rm web rake db:setup`

## Licensing

Please see the [BSD 3-Clause License](LICENSE) that should be part of this
repository.
