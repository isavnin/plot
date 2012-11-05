
# include paths
ifeq ($(USERNAME),isavnin)
	CPLUS_INCLUDE_PATH=/home/isavnin/usr/local/include:/home/isavnin/usr/local/lib
	LIBRARY_PATH=/home/isavnin/usr/local/lib
	LD_LIBRARY_PATH=/home/isavnin/usr/local/lib
endif

# export the paths
export CPLUS_INCLUDE_PATH LIBRARY_PATH

# names of executables
PROGRAM = plot

# sources
CXXSOURCES = my_time.cpp data.cpp
CXXOBJECTS = $(CXXSOURCES:.cpp=.o)

#flags
CXX = g++
#GSL = -lgsl -lgslcblas -lm
BOOST = -lboost_program_options -lboost_regex
PYTHON = -lpython2.7
#LOG4CPLUS = -llog4cplus
#CXFORM = -lcxform
CXXFLAGS = -O3 -Wl,-rpath,$(LD_LIBRARY_PATH),-rpath-link,$(LD_LIBRARY_PATH) -Wno-write-strings

all: $(PROGRAM)

$(PROGRAM): $(CXXOBJECTS) $(PROGRAM).o
	$(CXX) -o $@ $@.o $(CXXOBJECTS) $(BOOST) $(PYTHON) $(CXXFLAGS)

$(PROGRAM).o: plot.cpp
	$(CXX) -c -o plot.o plot.cpp $(BOOST) $(CXXFLAGS)

my_time.o: my_time.h my_time.cpp
	$(CXX) -c -o my_time.o my_time.cpp $(CXXFLAGS)

data.o: data.h data.cpp
	$(CXX) -c -o data.o data.cpp $(CXXFLAGS)

clean:
	$(RM) -f $(CXXOBJECTS) $(PROGRAM).o $(PROGRAM)

run:
	./$(PROGRAM)
