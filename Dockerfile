FROM christiankaltenecker/distance-based

RUN apt-get -y install apt-transport-https ca-certificates
RUN apt-get update && apt-get -y install --no-install-recommends --no-install-suggests \
        ca-certificates software-properties-common gnupg2 gnupg1 \
      && apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' \
      && add-apt-repository 'deb https://cloud.r-project.org/bin/linux/debian stretch-cran35/' \
      && apt-get update \
      && apt-get -y install r-base 

RUN R -e "install.packages('backports',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('Rcpp',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('tibble',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('readr',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('plyr',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('effsize',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('FSA',dependencies=TRUE, repos='http://cran.rstudio.com/')"



RUN mkdir /docker

RUN git clone https://github.com/jualvespereira/ICPE2020.git /docker/ICPE2020
RUN mv SPLConqueror ../docker/ICPE2020/
RUN mv z3 ../docker/ICPE2020/

RUN cd /docker
RUN chmod -R u+x *

WORKDIR /docker
