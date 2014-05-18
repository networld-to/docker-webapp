# docker-webapp

- nginx
- passenger 4.0.41
- ruby 2.1.2

For more versions see Dockerfile.


## Getting Started

Get the image via index.docker.io

        $ docker pull networld/docker-webapp

        or build from source

        $ IMAGE_NAME=networld/docker-webapp
        $ docker build --rm -t ${IMAGE_NAME} .

  Start a container with:

        $ docker run --rm -p 127.0.0.1:8181:80 -d -v /path/to/ruby_on_rails_app:/webapp ${IMAGE_NAME}
        $ curl http://127.0.0.1:8181 # Test with curl or even better your favorite browser


## Boot Script

If available the script `init.sh` under the root directory of the web application is executed during boot time (`/webapp/init.sh`). This script can be used to setup additional components or tasks, e.g. adding cronjobs or starting background workers.

**Important:** Assure that the script is idempotent. That means if executed multiple times it does not change the result. Also keep in mind that the script is executed on each boot and before the web server nginx is started.

For more information see https://index.docker.io/u/networld/docker-webapp/ and
the source code under https://github.com/networld-to/docker-webapp

