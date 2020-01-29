####
# deployment scripts for stage
##



# Pull all repos
pull_repos(){
	cd repos &&
	git clone -b develop https://github.com/Viva-con-Agua/stream-frontend.git 
	git clone -b develop https://github.com/Viva-con-Agua/waves-backend.git
	git clone -b develop https://github.com/Viva-con-Agua/waves-frontend.git 
	git clone -b develop https://github.com/Viva-con-Agua/arise.git 
	git clone -b develop https://github.com/Viva-con-Agua/canal-frontend.git 
	git clone -b develop https://github.com/Viva-con-Agua/canal-backend.git
	git clone -b develop https://github.com/Viva-con-Agua/assets.git
}

# pull repo update docker and publis as develop
build_and_setup(){
	cd repos/${1} && git pull && cd ../../ && docker-compose up -d --build $1 && publish_docker $1 develop; 
}

# build and push docker with changes
build_and_push(){
	docker-compose up -d --build $1 && 
	cd repos/$i{1} &&
	git add package.json &&	
	git commit -m "update repo by stage" &&
	git push origin develop &&
	publish_docker $1 develop; 
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


update_npm(){
	
		# go into service folder
		cd repos/${1} &&
		
		# pull repo 
		git pull &&
		# backup package.json
		cp package.json package.json.bak
		# update npm packages
		ncu -u &&
		# build docker
		cd ../../ && docker-compose up -d --build $1 &&
		#  go into service folder
		cd repos/${1} &&
		rm package.json.bak &&
		git add package.json &&	
		git commit -m "update npm package versions" &&
		git push origin develop
}

update-frontend(){
	cd arise && update_npm && cd ../ && docker-compose up -d --build arise
	cd stream-frontend && update_npm && cd ../ && 
	cd waves-frontend && update_npm && cd ../ 
	cd canal-frontend && update_npm && cd ../ 
}

case $1 in
	pullAll) pull_repos;;
	update) build_and_setup $2;;
	restart) restart $2;;
	publish) publish_docker $2 $3;;
	initNav) set_navigation;;
	updatePackage) update_npm $2 || echo "ERROR DOCKER ${1} CANT UPDATE" ;;
	push) build_and_push $2 || echo "ERROR"
esac


#!/bin/sh
#for repo in repo1 repo2 repo3 repo4; do
#    (cd "${repo}" && git checkout master && git up)
#done
	#ssl_password_file /etc/nginx/global.pass;
