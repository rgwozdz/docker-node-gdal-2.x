FROM node:10

RUN apt-get update && apt-get install -y --no-install-recommends build-essential libproj-dev python3-pip python3-setuptools
RUN pip3 install --upgrade pip
RUN pip3 install awscli --upgrade --user
ENV PATH "$PATH:/root/.local/bin"

ENV SRC_DIR /opt/src/
RUN mkdir -p $SRC_DIR
RUN curl -L http://download.osgeo.org/gdal/2.4.2/gdal-2.4.2.tar.gz -o $SRC_DIR/gdal-2.4.2.tar.gz
RUN cd $SRC_DIR && tar -xvzf gdal-2.4.2.tar.gz
WORKDIR $SRC_DIR/gdal-2.4.2
RUN ./configure --prefix=/opt/gdal
RUN make
RUN make install
ENV GDAL=/opt/gdal/bin
ENV GDAL_DATA=/opt/gdal/share/gdal
ENV PATH "$PATH:/opt/gdal/bin"
ENV LD_LIBRARY "$LD_LIBRARY:/opt/gdal/lib"
