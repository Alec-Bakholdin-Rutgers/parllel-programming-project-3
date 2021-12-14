all: clean build run

build:
	nvcc -o kernel.o kernel.cu -c
	nvcc -o cuda_test cuda_test.cu kernel.o

clean:
	rm -rf *.o cuda_test

run: 
	./cuda_test