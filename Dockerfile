FROM node:10

RUN apt-get update && apt-get install -y --no-install-recommends build-essential libproj-dev sqlite

ENV SRC_DIR /opt/src/
RUN mkdir -p $SRC_DIR

# GDAL
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

# Tippecanoe
RUN mkdir -p $SRC_DIR/tippecanoe
RUN curl -L https://api.github.com/repos/mapbox/tippecanoe/tarball/1.35.0 | tar -xz --strip-components=1 -C $SRC_DIR/tippecanoe
WORKDIR $SRC_DIR/tippecanoe
RUN make -j 
RUN make PREFIX=/opt/src/tippecanoe install
ENV PATH "$PATH:/opt/src/tippecanoe/bin"