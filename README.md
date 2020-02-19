#Helper

## Scope
This is just a baseline container for working with things.
The idea is to make things a little more cross-platform friendly.

## Usage
Initial build of the container (for reuse):

`docker build -t helper .`

There are some volumes that need to be mapped, which we use the docker-compose file:

`docker-compose run helper /bin/bash`

There is also a wrapper

## Validation
You should be able to run the following command to be able to verify user mapping.

`docker-compose run helper git config --global --list`