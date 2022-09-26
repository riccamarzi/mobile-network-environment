FROM ubuntu:focal
CMD ["bash"]
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install mysql-server iproute2 -y
ADD mysql_conf.sh /
RUN chmod +x /mysql_conf.sh
