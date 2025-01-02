FROM amd64/debian:latest

# Install NASM and Binutils (for ld)
RUN apt-get update && apt-get install -y nasm binutils make vim build-essential

# Create a directory to store your assembly file
RUN mkdir ASM
# Copy your assembly file into the container
COPY ASM ASM
# Change the working directory
WORKDIR /ASM

# Default command: run the resulting program
CMD ["bash"]
