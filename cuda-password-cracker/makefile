CC=nvcc
CCFLAGS=-O2
MAIN_FILE=password_cracker
LINKED_FILES=sha256.cu

all: clean build

run: clean build
	./$(MAIN_FILE)

build:
	$(CC) $(CCFLAGS) -o $(MAIN_FILE) $(MAIN_FILE).cu $(LINKED_FILES)

clean:
	rm -f $(MAIN_FILE) *.o

test: test.c
	gcc -o test test.c
	./test