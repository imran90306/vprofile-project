FROM ubuntu:20.04 AS build
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt install maven git -y
RUN apt install openjdk-17-jdk -y
RUN git clone https://github.com/imran90306/vprofile-project.git
WORKDIR /vprofile-project
RUN mvn package

FROM tomcat:9.0-jdk17
COPY --from=build /vprofile-project/target/*.war  /usr/local/tomcat/webapps
RUN chmod -R 755 /usr/local/tomcat
EXPOSE 8080
CMD ["catalina.sh" ,"run"]
