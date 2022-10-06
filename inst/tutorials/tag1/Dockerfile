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
    libssl1.1 \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('remotes')"
# makes problems otherwise?
RUN R -e "remotes::install_github('sctyner/memer')"
# first install all deps?, then the actual package, if package changes
# we can save time
RUN R -e "remotes::install_github('johannes-titz/rlernen.de')"
# remove binaries
RUN strip /usr/local/lib/R/site-library/*/libs/*.so

EXPOSE 3838

CMD ["R", "-e", "learnr::run_tutorial('tag1', 'rlernen.de', \
  shiny_args = list(host = '0.0.0.0', port = 3838))"]
