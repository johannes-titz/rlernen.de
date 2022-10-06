FROM rocker/r-ver:4

MAINTAINER Johannes Titz

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.1

# from pak
RUN apt-get install -y make
RUN apt-get install -y cmake
RUN apt-get install -y libicu-dev
RUN apt-get install -y pandoc
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y imagemagick
RUN apt-get install -y libmagick++-dev
RUN apt-get install -y gsfonts
RUN apt-get install -y libpng-dev
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y libglpk-dev
RUN apt-get install -y libgmp3-dev
RUN apt-get install -y libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('pak')"

RUN mkdir /root/rlernen.de
COPY . /root/rlernen.de
WORKDIR /root/rlernen.de

# does not work
# RUN R -e "pak::local_system_requirements('ubuntu', '20.04', execute = TRUE, sudo = F, echo =T)"

RUN R -e "pak::local_install_deps(ask = F)"
# unclear why this does not work
RUN R -e "pak::pkg_install('sctyner/memer')"
RUN R -e "pak::local_install(ask = F)"

# remove binaries
RUN strip /usr/local/lib/R/site-library/*/libs/*.so

RUN R -e "rlernen.de::cache_tutorials()"

EXPOSE 3838

CMD ["R", "-e", "learnr::run_tutorial('tag1', 'rlernen.de', \
  shiny_args = list(host = '0.0.0.0', port = 3838))"]
