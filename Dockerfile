FROM ubuntu:latest

# Install essential packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    gnupg \
    lsb-release

# Install Google Cloud SDK
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && apt-get install -y google-cloud-sdk

# Install VS Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set working directory
WORKDIR /workspace

# Expose port for VS Code Server
EXPOSE 8080

# Start VS Code Server
CMD ["code-server", "--auth", "none", "--host", "0.0.0.0", "--port", "8080"]

