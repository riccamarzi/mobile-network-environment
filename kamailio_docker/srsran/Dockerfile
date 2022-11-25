FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
#RUN apt update && apt install -y autoconf automake build-essential ccache cmake cpufrequtils doxygen ethtool fort77 g++ gir1.2-gtk-3.0 git gobject-introspection gpsd gpsd-clients inetutils-tools libasound2-dev libboost-all-dev libcomedi-dev libcppunit-dev libfftw3-bin libfftw3-dev libfftw3-doc libfontconfig1-dev libgmp-dev libgps-dev libgsl-dev liblog4cpp5-dev libncurses5 libncurses5-dev libpulse-dev libqt5opengl5-dev libqwt-qt5-dev libsdl1.2-dev libtool libudev-dev libusb-1.0-0 libusb-1.0-0-dev libusb-dev libxi-dev libxrender-dev libzmq3-dev libzmq5 ncurses-bin python3-cheetah python3-click python3-click-plugins python3-click-threading python3-dev python3-docutils python3-gi python3-gi-cairo python3-gps python3-lxml python3-mako python3-numpy python3-numpy-dbg python3-opengl python3-pyqt5 python3-requests python3-scipy python3-setuptools python3-six python3-sphinx python3-yaml python3-zmq python3-ruamel.yaml swig wget
RUN apt update && apt install -y vim iproute2 build-essential cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev autoconf automake ccache cpufrequtils doxygen ethtool \
g++ git inetutils-tools libboost-all-dev libncurses5 libncurses5-dev libusb-1.0-0 libusb-1.0-0-dev \
libusb-dev python3-dev python3-mako python3-numpy python3-requests python3-scipy python3-setuptools \
python3-ruamel.yaml
RUN git clone https://github.com/EttusResearch/uhd.git
WORKDIR uhd/host
RUN mkdir build 
WORKDIR build
RUN cmake -DLIB_SUFFIX=64 ../
RUN make -j `nproc`
RUN make install
ENV LD_LIBRARY_PATH=/usr/local/lib64
RUN ldconfig
RUN uhd_images_downloader
WORKDIR /
RUN git clone https://github.com/srsRAN/srsRAN.git
WORKDIR srsRAN
RUN mkdir build
WORKDIR build 
RUN cmake ../
RUN make -j `nproc`
RUN make install 
RUN srsran_install_configs.sh user
ADD ./srsran_conf.sh /
CMD /srsran_conf.sh
