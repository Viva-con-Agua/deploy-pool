# deploy-pool
Pool² deployment via docker-compose for Stage.

## Navigation

The navigation is defined as JSON in the navigation directory. Only the GlobalNav.json and noSignIn.json files are loaded by dispenser. More info <dispenser link >
### Example:
```json
{
  "name":"global",
  "entrys": [
    {
      "label": { "de_DE": "office", "en_EN": "office" },
      "render":true,
      "url":"/arise/#/users",
      "permission": [{ "role": "VolunteerManager" },{ "role": "employee" },{ "role": "admin" }],
      "entrys": [ < more entrys > ]
      }
   ]
 }
```

## pool-scripts

Script to help with deployment. Can be used via `./pool-scripts <command> <serviceName / version>`

```
pullAll                         # pull all supported "develop" branches from github
update <serviceName>            # pull the "develop" branch, build and setup docker and push docker into "develop"
restart <serviceName>           # delete and set up service
publish <serviceName> <version> # publish docker with given version
initNav                         # set navigation 
updatePackage <serviceName>     # update npm packages, create docker and push to github and dockerhub
push <serviceName>              # after changing something on stage, rebuild docker and push the service on github
```

You can use all of the docker-compose magic you need!!!

## volumes
Store data such as application.conf or databases. All files in this directory are mounted in the dockers via `volumes` command. Changes take effect after restarting the service: `docker-compose restart <serviceName>`

## Services and IP

|Service|IP| Port|discription|
|---|---|---|---|
|nginx-main|172.2.10.1|80|ssl handling and subnet routing|
|nginx-pool|172.2.10.2|80|routes for Pool²|
|nginx-mattermost|172.2.10.3|80|routes for Mattermost|
|arise|172.2.50.1| 80| link arise|
|drops|172.2.100.1| 9000| link drops|
|drops-database|172.2.200.1|3306| mariadb |
|waves-frontend|172.2.50.2|80| link waves-frontend|
|waves-backend|172.2.100.2|5000| link waves-backend|
|waves-database|172.2.200.2|3306| mariadb |
|stream-frontend|172.2.50.3|80| link stream-frontend|
|stream-backend|172.2.100.3|9000| link stream-backend|
|stream-database|172.2.200.3|3306| mariadb |
|dispenser|172.2.100.4|9000| link dispenser|
|dispenser-database|172.2.200.4|27017| mongodb|
|canal-frontend|172.2.50.5|80| link canal-frontend |
|assets|172.2.100.6|1323|link assetes|
|nats|172.2.150.1|4222| nats docker|



## Version (1.0.0)
