# Use a lightweight Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies required by PyArrow and other packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    wget \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies in editable mode
RUN pip install --upgrade pip

# Copy the application code
COPY . .

# Install PyArrow with pre-built binary (no build required)
RUN pip install --no-cache-dir pyarrow \
    && pip install --no-cache-dir -e .

# Train the model before running the application
RUN python pipeline/training_pipeline.py

# Expose the port for Flask
EXPOSE 5000

# Run the application
CMD ["python", "application.py"]