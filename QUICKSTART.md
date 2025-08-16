# 🚀 Quick Start Guide

## One-Command Setup

```bash
cd /project/workspace/watermark-remover
docker-compose up -d
```

After starting, visit:
- **Web Interface**: http://localhost:3000
- **API Documentation**: http://localhost:8000/docs

## Create Your First API Key

```bash
curl -X POST http://localhost:8000/api/v1/api-keys \
  -H "Content-Type: application/json" \
  -d '{"name": "My Key", "rate_limit_per_minute": 100}'
```

## Remove a Watermark (Python)

```python
from docs.api_example import WatermarkRemoverAPI

# Initialize with your API key
api = WatermarkRemoverAPI("wmr_your_key_here")

# Remove watermark
api.remove_watermark("image_with_watermark.jpg", "clean_image.jpg")
```

## Test the Setup

```bash
# Test API health
python docs/test_api.py

# Interactive example
python docs/api_example.py your_image.jpg
```

## Development Mode

```bash
# Install dependencies
make install

# Start dev servers
make dev
```

## Services

| Service | URL | Purpose |
|---------|-----|---------|
| Frontend | http://localhost:3000 | Web interface |
| Backend API | http://localhost:8000 | REST API |
| API Docs | http://localhost:8000/docs | Interactive documentation |

## File Limits

- **Max size**: 25MB
- **Formats**: JPEG, PNG, WebP
- **Resolution**: Up to 5,000 × 5,000px

## Rate Limits

- **Web**: 30 requests/minute per IP
- **API**: Configurable per key (default 10/min)

Your watermark removal app is ready! 🎉