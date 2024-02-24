# Helper

## Scope
This is just a baseline container for working with things.
The idea is to make things a little more cross-platform friendly.

## To Dos
- [ ] Add in Windows bootstrapping support
- [ ] Update to 24.04 (when available)
- [ ] Update docker-compose files for host checking in `startup`
- [ ] Add in more things to do

## Functional Additions
There are some additions to the PS1 prompt that need to be addressed in your .bashrc file

```
if [[ -f /usr/local/add-ons/bash_profile ]]
then
	source /usr/local/add-ons/bash_profile
fi
```

## Usage
Initial build of the container (for reuse):

`docker build -t helper .`

There are some volumes that need to be mapped, which we use the docker-compose file:

`docker-compose run helper /bin/bash`

There is also a wrapper (this currently works in MacOS/Linux.... mostly):
`./startup`

## Validation
You should be able to run the following command to be able to verify user mapping.

`docker-compose run helper git config --global --list`
