FROM amd64/debian:latest

# Install NASM and Binutils (for ld)
RUN apt-get update && apt-get install -y nasm binutils make vim

# Create a directory to store your assembly file
RUN mkdir ASM
# Copy your assembly file into the container
COPY ASM ASM
# Change the working directory
WORKDIR /ASM

# Build your executable
RUN nasm -f elf64 -g -F DWARF hello.asm -o hello.o\
    && ld -o hello hello.o

# Default command: run the resulting program
CMD ["./hello"]
