
build_and_setup(){
	cd $1 && git pull && cd ../ && docker-compose up -d --build $1; 
}

restart(){
	docker-compose rm -s $1 && docker-compose up -d $1;
}
case $1 in
	update) build_and_setup $2;;
	restart) restart $2;;
esac


#!/bin/sh
#for repo in repo1 repo2 repo3 repo4; do
#    (cd "${repo}" && git checkout master && git up)
#done
	#ssl_password_file /etc/nginx/global.pass;
