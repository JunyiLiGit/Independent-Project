#g++ -std=c++11 main.cpp -o main -I ../install/include/ -L ../install/lib/ -lparticlesys_static
CC=g++
CXX= -std=c++11

SRC= *.cpp

EXE = run

INCLUDES= -I ../install/include

LIBS= -L ../install/lib -lparticlesys_static

${EXE}: ${SRC}
	${CC} ${CXX} ${SRC} -o ${EXE} ${INCLUDES} ${LIBS}
clean:
	rm ${EXE}
