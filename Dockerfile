# Toolfactory image
#
# VERSION       0.2
# This Dockerfile is the base system for executing scripts by the DockerToolFactory.

FROM toolshed/requirements

MAINTAINER Marius van den Beek, m.vandenbeek@gmail.com

# make sure the package repository is up to date
ENV DEBIAN_FRONTEND noninteractive

#add galaxy user (could be any username).
#1001 will be replaced by the actual user id of the system user
#executing the galaxy tool, so that file write operations are possible.
RUN adduser galaxy -u 1000


ADD adduser.sh /usr/local/bin/adduser.sh
RUN adduser.sh

RUN ulimit -n 1024 && apt-get update -qq && apt-get install -y --no-install-recommends software-properties-common && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9 && add-apt-repository \
"deb http://cran.irsn.fr/bin/linux/ubuntu trusty/" && apt-get update -qq && apt-get upgrade && apt-get install -y r-base-core r-base-dev \
adduser zlib1g-dev python-virtualenv python-pip libfreetype6-dev bedtools wget curl \
libcurl4-openssl-dev libssl-dev libreadline-dev libxml2-dev samtools liblzma-dev \
libpcre3-dev libbz2-dev ghostscript graphicsmagick-imagemagick-compat

RUN pip install numpy pysam tornado matplotlib pycurl pip pandas ipython rpy2

#RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("DESeq", "DESeq2", "edgeR", "EDASeq")'
#RUN Rscript -e 'install.packages(c("latticeExtra", "ggplot2", "reshape", "gridExtra"), dependencies=TRUE, repos="http://cran.us.r-project.org")'

RUN mkdir /home/galaxy/job_working_directory
WORKDIR /home/galaxy/job_working_directory
USER galaxy

#ENTRYPOINT chown -R galaxy /home/galaxy/ && su - galaxy
CMD /bin/bash
