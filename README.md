## Before build

### Needed files/versions:
You should find & download following files:
- cmdbuild-2.3.4.zip
- shark-cmdbuild-2.3.4.zip
- alfresco-community-3.4.c.zip
- apache-tomcat-7.0.67.tar.gz

### Preparation
Before starting the build, following steps are needed:
- Download and extract CMDBuild in a temporary folder
- Download and extract Alfresco in a temporary folder
- Download Tomcat 7.0.67 (apache-tomcat-7.0.67.tar.gz) into files/apps
- Extract cmdbuild-2.3.4.war from downloaded CMDBuild archive to files/apps
- Extract alfresco.war and share.war from downloaded archive to files/apps



## Build
Then you can proceed to build the docker image, by using following command (where the Dockerfile lives):

docker build -t < some-image-name > .

## Run
To run image (with automated container deletion):
``` bash
docker run --rm -p 18080:8080 -p 15432:5432 < name >
```

To run image (keeping the state of the container, so you can stop/start):
``` bash
docker run -p 18080:8080 -p 15432:5432 < name >
```

## Access to the Applications
Now you can access (change host to your setup!)
- the CMDBuild website: http://< host >:18081/cmdbuild/
- Alfresco: http://< host >:18081/alfresco/
- Postgresql Database: < host >:15432 (username and password are "cmdbuildsu" if not changed in Dockerfile)
- Tomcat: http://< host >:18080/ (for the application manager use username: tomcat, password: s3cret, if not changed in "configuration/tomcat-users.xml")
