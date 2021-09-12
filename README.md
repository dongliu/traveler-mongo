# traveler-mongo
This is a basic setting of mongo db and express services for local traveler
development. In production environment, you might want to have a dedicated mongo
db server, or modify the docker configuration for security and reliability
reasons. 

## base docker images

The mongodb is based on the official docker image, see
https://hub.docker.com/_/mongo/ . The mongo express is for the development
convenience, and is based on https://hub.docker.com/_/mongo-express/ . 

## directories

The `data` directory is mounted to the mongo container, and will contain all the
db data including the default db's with the image and also the traveler db
created for traveler development. 

The `seed` directory contains scripts that will be executed from
`/docker-entrypoint-initdb.d` when the mongo container starts. The scripts are
executed in alphabet sequence of their names. The first script creates the db
user for traveler application. The second script creates traveler users in the
traveler db.

The `backup` directory will have the backup files dumped for the traveler db

The `script` directory contains `backup.sh` used for backup

## usage

Clone this repo to your local environment. Make sure you have the `traveler-dev` network in the docker. 
```
docker network list
```

If not, run the following in your console to create the network.

```
docker network create -d bridge --subnet 172.18.1.0/24 traveler-dev
```

Run `docker-compose up` to build and start the services. You can access mongo
express at <http://localhost:8081>. The username is `traveler`, and password is
`travelerpass`.


### backup
Run `docker ps` to see the list of containers up and running. Then ssh into the
mongo container with 
`docker exec -it traveler-mongodb /bin/bash`

Inside the container, run
`bash /script/backup.sh`

The db dump will be saved into the `backup` directory named with the date and
time of backup. 

Note when execute the script, a backup file older than 7 days will be removed.
You can modify the `backup.sh` to change this behavior. 


