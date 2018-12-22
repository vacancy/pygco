CXX=g++
CFLAGS=-fPIC

libcgco.so: gco-v3.0/LinkedBlockList.o gco-v3.0/GCoptimization.o cgco.o
	$(CXX) -shared $(CFLAGS) \
        gco-v3.0/LinkedBlockList.o \
        gco-v3.0/GCoptimization.o \
        cgco.o \
        -o libcgco.so

gco.so: gco-v3.0/LinkedBlockList.o gco-v3.0/GCoptimization.o
	$(CXX) -shared $(CFLAGS) gco-v3.0/LinkedBlockList.o \
        gco-v3.0/GCoptimization.o -o gco.so

gco-v3.0/LinkedBlockList.o: gco-v3.0/LinkedBlockList.cpp gco-v3.0/LinkedBlockList.h
	$(CXX) $(CFLAGS) \
        -c gco-v3.0/LinkedBlockList.cpp \
        -o gco-v3.0/LinkedBlockList.o

gco-v3.0/GCoptimization.o: \
	gco-v3.0/GCoptimization.cpp gco-v3.0/GCoptimization.h \
	gco-v3.0/LinkedBlockList.h gco-v3.0/energy.h \
	gco-v3.0/graph.h gco-v3.0/graph.inl \
	gco-v3.0/maxflow.inl
	$(CXX) $(CFLAGS) \
        -c gco-v3.0/GCoptimization.cpp \
        -o gco-v3.0/GCoptimization.o

cgco.o: cgco.cpp gco-v3.0/GCoptimization.h
	$(CXX) $(CFLAGS) \
        -c cgco.cpp \
        -o cgco.o

test_wrapper: test_wrapper.cpp
	$(CXX) -L. test_wrapper.cpp \
        -o test_wrapper -lcgco

.PHONY: all clean

all: libcgco.so

clean:
	rm -f *.o gco-v3.0/*.o

