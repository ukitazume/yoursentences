default: builddocker

builddocker:
	docker build -t ukitazume/yoursentences -f ./Dockerfile.build .
	docker run -t ukitazume/yoursentences /bin/true
	docker cp `docker ps -q -n=1`:/go/src/github.com/ukitazume/yoursentences/api/main .
	chmod 755 ./main
	docker build --rm=true --tag=ukitazume/yoursentences -f Dockerfile.static .

run: builddocker
	docker run \
		-p 8080:8080 ukitazume/yoursentences

