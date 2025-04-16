# Use official PyTorch image (with CUDA) or use cpu-only if needed
FROM pytorch/pytorch:latest

# Set working directory
WORKDIR /app

# Copy everything into the container
COPY . .

# Set timezone to UTC and prevent interactive prompt
ENV TZ=Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive

# Install system packages
RUN apt-get update && apt-get install -y \
    git \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Clone YOLOv5 if not already present
RUN if [ ! -d "yolov5" ]; then git clone https://github.com/ultralytics/yolov5.git; fi \
    && pip install -r yolov5/requirements.txt

# Default command: open a shell
CMD ["/bin/bash"]