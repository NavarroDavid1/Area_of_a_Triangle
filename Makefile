# Compiler and assembler settings
CC = gcc
CXX = g++
ASM = nasm
CFLAGS = -Wall -g
ASMFLAGS = -f elf64
LDFLAGS = -no-pie

# Output executable name
TARGET = main

# Object files
OBJS = heron.o triangle.o compute_area.o get_sides.o show_results.o

# Default target to build the final executable
all: $(TARGET)

# Rule to build the final executable
$(TARGET): $(OBJS)
	$(CXX) $(LDFLAGS) -o $(TARGET) $(OBJS)

# Rule to compile C++ source file (heron.cpp)
heron.o: heron.cpp
	$(CXX) $(CFLAGS) -c heron.cpp

# Rule to assemble triangle.asm
triangle.o: triangle.asm
	$(ASM) $(ASMFLAGS) triangle.asm -o triangle.o

# Rule to assemble compute_area.asm
compute_area.o: compute_area.asm
	$(ASM) $(ASMFLAGS) compute_area.asm -o compute_area.o

# Rule to compile C source file (get_sides.c)
get_sides.o: get_sides.c
	$(CC) $(CFLAGS) -c get_sides.c -o get_sides.o

# Rule to compile C++ source file (show_results.cpp)
show_results.o: show_results.cpp
	$(CXX) $(CFLAGS) -c show_results.cpp -o show_results.o

# Clean rule to remove compiled files
clean:
	rm -f $(OBJS) $(TARGET)

# Run rule to compile and then execute the program
run: all
	./$(TARGET)
