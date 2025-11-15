FROM python:3.10-slim

# Install system deps
RUN apt-get update && apt-get install -y \
    git ffmpeg libsm6 libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Clone the RVC-TTS WebUI
RUN git clone https://github.com/NekoSuneAI/rvc-tts-webui /app
WORKDIR /app

# Install CPU PyTorch
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Install fairseq CPU wheel (no compile!)
RUN pip install --no-cache-dir fairseq

# Optional: transformers, accelerate for CPU inference
RUN pip install --no-cache-dir transformers accelerate

# Expose WebUI port
EXPOSE 7860

# Start the WebUI
CMD ["python3", "app.py", "--port", "7860", "--share", "False"]
