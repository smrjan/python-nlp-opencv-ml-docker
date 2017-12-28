#FROM turbulent/polyglot-base
#FROM python:3-onbuild
FROM frolvlad/alpine-python-machinelearning

#RUN apt-get install -y icu-libs icu-dev gcc g++ \
#    && pip3 install --no-cache-dir polyglot futures Morfessor numpy pycld2 PyICU six \
#    && apt-get uninstall icu-dev gcc g++
#RUN echo "http://nl.alpinelinux.org/alpine/v3.2/main" > /etc/apk/repositories

RUN apk --no-cache add icu-libs icu-dev gcc g++ python3-dev \
    && pip3 install --no-cache-dir polyglot futures Morfessor numpy pycld2 PyICU six \
    && apk del icu-dev

RUN apk --no-cache add git libxml2-dev libxslt-dev libzmq linux-headers
#RUN apk add --no-cache libstdc++ lapack-dev && \
#    apk add --no-cache \
#        --virtual=.build-dependencies \
#        g++ gfortran musl-dev && \
#    ln -s locale.h /usr/include/xlocale.h

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN python -c "import nltk; nltk.download('punkt')"
RUN python -c "import nltk; nltk.download('wordnet')"
RUN python -c "import nltk; nltk.download('sentiwordnet')"
RUN python -c "import nltk; nltk.download('vader_lexicon')"
RUN python -c "import nltk; nltk.download('averaged_perceptron_tagger')"
RUN python -c "import nltk; nltk.download('maxent_ne_chunker')"
RUN python -c "import nltk; nltk.download('words')"
RUN python -m spacy download en
RUN ipython profile create

RUN jupyter serverextension enable --py jupyterlab --sys-prefix

#RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
#RUN apk --no-cache add nodejs
#RUN npm -g install phantomjs

#RUN apk --no-cache add build-base cmake pkgconfig
#RUN apk --no-cache add libjpeg-turbo-dev libtiff5-dev libjasper libpng12-dev
#RUN apk --no-cache add libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
#RUN apk --no-cache add libxvidcore-dev libx264-dev
#RUN apk --no-cache add libgtk-3-dev
#RUN apk --no-cache add libatlas-base-dev gfortran
#RUN apk --no-cache add libopencv-dev python-opencv
