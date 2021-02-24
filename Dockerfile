FROM tomcat:8.5

MAINTAINER arvind, Devops0123@gmail.com

RUN rm -rf webapps && mv webapps.dist webapps

COPY target/*.war webapps/shop.war

EXPOSE 8080