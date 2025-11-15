FROM python:3.10-slim

# Install system deps
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone the RVC-TTS WebUI
RUN git clone https://github.com/NekoSuneAI/rvc-tts-webui /app
WORKDIR /app

# Install Python deps (CPU mode)
RUN pip install --no-cache-dir -r requirements.txt

# Expose WebUI port
EXPOSE 7860

# Start the WebUI
CMD ["python3", "app.py", "--port", "7860", "--share", "False"]
