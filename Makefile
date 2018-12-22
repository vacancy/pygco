CXX=g++
CFLAGS=-fPIC

all: libcgco.so

libcgco.so: \
    gco-v3.0/LinkedBlockList.o gco-v3.0/GCoptimization.o cgco.o
    $(CXX) -shared $(CFLAGS) \
        gco-v3.0/LinkedBlockList.o \
        gco-v3.0/GCoptimization.o \
        cgco.o \
        -o libcgco.so

gco.so: \
    gco-v3.0/LinkedBlockList.o gco-v3.0/GCoptimization.o
    $(CXX) -shared $(CFLAGS) gco-v3.0/LinkedBlockList.o \
        gco-v3.0/GCoptimization.o -o gco.so

gco-v3.0/LinkedBlockList.o: \
    gco-v3.0/LinkedBlockList.cpp \
        gco-v3.0/LinkedBlockList.h
    $(CXX) $(CFLAGS) \
        -c gco-v3.0/LinkedBlockList.cpp \
        -o gco-v3.0/LinkedBlockList.o

gco-v3.0/GCoptimization.o: \
    gco-v3.0/GCoptimization.cpp gco-v3.0/GCoptimization.h \
        gco-v3.0/LinkedBlockList.h gco-v3.0/energy.h gco-v3.0/graph.h
    $(CXX) $(CFLAGS) \
        -c gco-v3.0/GCoptimization.cpp \
        -o gco-v3.0/GCoptimization.o

cgco.o: \
    cgco.cpp gco-v3.0/GCoptimization.h
    $(CXX) $(CFLAGS) \
        -c cgco.cpp \
        -o cgco.o

test_wrapper: \
    test_wrapper.cpp
    $(CXX) -L. test_wrapper.cpp \
        -o test_wrapper -lcgco

clean:
    rm -f *.o gco-v3.0/*.o

rm:
    rm -f *.o *.so gco-v3.0/*.o *.zip

download:
    wget -N -O gco-v3.0.zip http://vision.csd.uwo.ca/code/gco-v3.0.zip
    unzip -o gco-v3.0.zip -d  ./gco-v3.0
