FROM node:20-alpine

# Install system dependencies (curl, bash, git)
RUN apk add --no-cache gcc musl-dev just curl bash git

# Create a non-root user and group
RUN addgroup -S zkuser && adduser -S -G zkuser -h /home/zkuser zkuser

# Switch to zkuser for rustup installation
USER zkuser

COPY --chown=zkuser:zkuser . /home/zkuser/zkintro-tutorial

# Set working directory
WORKDIR /home/zkuser/zkintro-tutorial

RUN ./scripts/prepare.sh

USER root
RUN npm install -g snarkjs@latest

# Switch to non-root user
USER zkuser
WORKDIR /home/zkuser

# Open a shell by default
CMD ["/bin/bash"]
