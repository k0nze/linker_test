CXX=g++

all: linker_test_a linker_test_b linker_test_ab linker_test_ba


linker_test_a: main.o libfunc_a.so
	$(CXX) main.o -L. -lfunc_a -o linker_test_a

linker_test_b: main.o libfunc_b.so
	$(CXX) main.o -L. -lfunc_b -o linker_test_b


linker_test_ab: main.o libfunc_a.so libfunc_b.so
	$(CXX) main.o -L. -lfunc_a -lfunc_b -o linker_test_ab

linker_test_ba: main.o libfunc_b.so libfunc_a.so
	$(CXX) main.o -L. -lfunc_b -lfunc_a -o linker_test_ba


main.o: main.cpp
	$(CXX) -c main.cpp -o main.o


libfunc_a.so: func_a.o
	$(CXX) -shared func_a.o -o libfunc_a.so 

func_a.o: func_a.cpp func.h
	$(CXX) -c func_a.cpp -fPIC -o func_a.o


libfunc_b.so: func_b.o
	$(CXX) -shared func_b.o -o libfunc_b.so 

func_b.o: func_b.cpp func.h
	$(CXX) -c func_b.cpp -fPIC -o func_b.o


.PHONY clean:
	-rm *.o
	-rm *.so
	-rm *.a 
	-rm linker_test_*
