# Compiler and flags
CXX = g++
CC = gcc
ASM = nasm
CXXFLAGS = -Wall -no-pie
CFLAGS = -Wall -no-pie 
ASMFLAGS = -f elf64

# Object files
OBJECTS = heron.o triangle.o get_sides.o compute_area.o show_results.o

# Default target
main: $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o main $(OBJECTS)

# Individual targets
heron.o: heron.cpp
	$(CXX) $(CXXFLAGS) -c heron.cpp

triangle.o: triangle.asm
	$(ASM) $(ASMFLAGS) triangle.asm

get_sides.o: get_sides.c
	$(CC) $(CFLAGS) -c get_sides.c

compute_area.o: compute_area.asm
	$(ASM) $(ASMFLAGS) compute_area.asm

show_results.o: show_results.cpp
	$(CXX) $(CXXFLAGS) -c show_results.cpp

clean:
	rm -f main $(OBJECTS)
