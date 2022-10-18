FROM ubuntu:bionic
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y vim git wget subversion mysql-server

RUN mkdir -p /usr/lib/jvm
WORKDIR /
RUN wget https://files-cdn.liferay.com/mirrors/download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz && tar -xvf /jdk-7u80-linux-x64.tar.gz -C /usr/lib/jvm
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0_80/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0_80/bin/javac 100
WORKDIR /
RUN wget http://archive.apache.org/dist/ant/binaries/apache-ant-1.9.14-bin.tar.gz && tar -xvf apache-ant-1.9.14-bin.tar.gz && mv apache-ant-1.9.14 /usr/local
RUN ln -s /usr/local/apache-ant-1.9.14/bin/ant /usr/bin/ant

RUN mkdir -p /opt/OpenIMSCore
WORKDIR /opt/OpenIMSCore
RUN git clone https://github.com/herlesupreeth/FHoSS
WORKDIR FHoSS
ENV JAVA_HOME=/usr/lib/jvm/jdk1.7.0_80
ENV CLASSPATH=/usr/lib/jvm/jdk1.7.0_80/jre/lib
ENV ANT_HOME=/usr/local/apache-ant-1.9.14
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN ant compile deploy | tee ant_compile_deploy.txt
CMD /mnt/fhoss_start.sh
