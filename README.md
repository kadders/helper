#Helper

## Scope
This is just a baseline container for working with things.
The idea is to make things a little more cross-platform friendly.

## Usage
Initial build of the container (for reuse):
`docker build -t helper .`

There are some volumes that need to be mapped, which we use the docker-compose file:
`docker-compose run helper /bin/bash`