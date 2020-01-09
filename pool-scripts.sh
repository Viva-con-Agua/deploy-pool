
build_and_setup(){
	cd $1 && git pull && cd ../ && docker-compose up -d --build $1; 
}

restart(){
	docker-compose rm -s $1 && docker-compose up -d $1;
}

publish_docker(){
	docker tag vivaconagua/${1}:latest vivaconagua/${1}:${2}
  	docker push vivaconagua/${1}:${2};
}

set_navigation(){
	echo "set Navigation";
	curl -X GET http://172.2.100.4:9000/dispenser/navigation/init;
}

case $1 in
	update) build_and_setup $2;;
	restart) restart $2;;
	publish) publish_docker $2 $3;;
	initNav) set_navigation;
esac


#!/bin/sh
#for repo in repo1 repo2 repo3 repo4; do
#    (cd "${repo}" && git checkout master && git up)
#done
	#ssl_password_file /etc/nginx/global.pass;
