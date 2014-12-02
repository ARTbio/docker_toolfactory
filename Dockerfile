# Toolfactory image
#
# VERSION       0.1

FROM debian:jessie

MAINTAINER Marius van den Beek, m.vandenbeek@gmail.com

# make sure the package repository is up to date
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update

# Install all requirements that are recommend by the Galaxy project
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y autoconf
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y automake
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y gfortran
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y cmake
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y git-core
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y libatlas-base-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y libblas-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y liblapack-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y mercurial
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y subversion
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y python-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y pkg-config
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y openjdk-7-jre
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y python-setuptools
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y adduser
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-virtualenv
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y zlib1g-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libfreetype6-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y ghostscript
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y r-base-core
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y imagemagick
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y graphicsmagick-imagemagick-compat
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y exonerate
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y bedtools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libcurl4-openssl-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libreadline-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y libxml2-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y samtools

RUN DEBIAN_FRONTEND=noninteractive easy_install numpy
RUN DEBIAN_FRONTEND=noninteractive easy_install pysam
RUN DEBIAN_FRONTEND=noninteractive easy_install tornado
RUN DEBIAN_FRONTEND=noninteractive easy_install matplotlib
RUN DEBIAN_FRONTEND=noninteractive easy_install pycurl
RUN DEBIAN_FRONTEND=noninteractive easy_install pip
RUN DEBIAN_FRONTEND=noninteractive pip install metaseq
RUN DEBIAN_FRONTEND=noninteractive easy_install pandas
RUN DEBIAN_FRONTEND=noninteractive pip install ipython
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y zlib1g-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y liblzma-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libpcre3-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libbz2-dev
RUN DEBIAN_FRONTEND=noninteractive pip install rpy2

RUN Rscript -e 'install.packages("latticeExtra", dependencies=TRUE, repos="http://cran.us.r-project.org")'
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("DESeq2")'
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("DESeq")'
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("edgeR")'
RUN Rscript -e 'install.packages("ggplot2", dependencies=TRUE, repos="http://cran.us.r-project.org")'
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("EDASeq")'
RUN Rscript -e 'install.packages("reshape", dependencies=TRUE, repos="http://cran.us.r-project.org")'
RUN Rscript -e 'install.packages("gridExtra", dependencies=TRUE, repos="http://cran.us.r-project.org")'


RUN adduser galaxy -u 1002

#VOLUME ["/home/galaxy/"]
#RUN chown -R galaxy /home/galaxy/ ##Doesn't work on volumes
RUN mkdir /home/galaxy/job_working_directory
WORKDIR /home/galaxy/job_working_directory
USER galaxy


#ENTRYPOINT chown -R galaxy /home/galaxy/ && su - galaxy
CMD /bin/bash
