# AI Watermark Remover

A production-ready web application for removing watermarks from images using advanced AI technology. Built with FastAPI backend and React frontend.

## 🚀 **Deploy to Web (No Commands Required)**

**Want to use this app without installing anything?**

### Quick Deploy to Vercel:
1. 📤 **[Follow GitHub Setup Guide](./GITHUB_SETUP.md)** - Upload code to GitHub
2. 🚀 **[Follow Vercel Deploy Guide](./DEPLOY_VERCEL.md)** - Deploy with one click
3. 🎉 **Your app is live!** - Access at `https://your-app.vercel.app`

**Demo API Key**: `wmr_demo_key_12345` (works immediately after deployment)

---

## API Usage

### Authentication

All API requests require an API key in the header:

```bash
curl -H "X-API-Key: wmr_your_api_key_here" \
     http://localhost:8000/api/v1/health
```

### Create API Key

```bash
curl -X POST http://localhost:8000/api/v1/api-keys \
  -H "Content-Type: application/json" \
  -d '{
    "name": "My API Key",
    "rate_limit_per_minute": 10
  }'
```

**Response:**
```json
{
  "id": 1,
  "name": "My API Key",
  "api_key": "wmr_abc123def456...",
  "key_prefix": "wmr_abc123...",
  "is_active": true,
  "created_at": "2024-01-01T00:00:00Z",
  "rate_limit_per_minute": 10
}
```

> ⚠️ **Important**: The full `api_key` is only shown once. Save it securely!

### Remove Watermark Workflow

#### 1. Upload Image

```bash
curl -X POST http://localhost:8000/api/v1/upload \
  -H "X-API-Key: wmr_your_api_key_here" \
  -F "file=@your-image.jpg"
```

**Response:**
```json
{
  "job_id": "uuid-1234-5678-9012",
  "message": "Image uploaded successfully",
  "original_filename": "your-image.jpg",
  "file_size_bytes": 1048576
}
```

#### 2. Start Processing

```bash
curl -X POST http://localhost:8000/api/v1/process \
  -H "X-API-Key: wmr_your_api_key_here" \
  -H "Content-Type: application/json" \
  -d '{
    "job_id": "uuid-1234-5678-9012",
    "options": {}
  }'
```

#### 3. Check Status

```bash
curl http://localhost:8000/api/v1/status/uuid-1234-5678-9012 \
  -H "X-API-Key: wmr_your_api_key_here"
```

**Response:**
```json
{
  "job_id": "uuid-1234-5678-9012",
  "status": "completed",
  "download_url": "/api/v1/download/uuid-1234-5678-9012",
  "message": "Processing completed successfully"
}
```

#### 4. Download Result

```bash
curl http://localhost:8000/api/v1/download/uuid-1234-5678-9012 \
  -H "X-API-Key: wmr_your_api_key_here" \
  -o watermark_removed.jpg
```

### Complete Example Script

```python
import requests
import time

API_KEY = "wmr_your_api_key_here"
BASE_URL = "http://localhost:8000/api/v1"
HEADERS = {"X-API-Key": API_KEY}

def remove_watermark(image_path):
    # 1. Upload image
    with open(image_path, "rb") as f:
        upload_response = requests.post(
            f"{BASE_URL}/upload",
            headers=HEADERS,
            files={"file": f}
        )
    
    job_id = upload_response.json()["job_id"]
    print(f"Uploaded image, job ID: {job_id}")
    
    # 2. Start processing
    requests.post(
        f"{BASE_URL}/process",
        headers={**HEADERS, "Content-Type": "application/json"},
        json={"job_id": job_id}
    )
    
    # 3. Wait for completion
    while True:
        status_response = requests.get(
            f"{BASE_URL}/status/{job_id}",
            headers=HEADERS
        )
        status = status_response.json()
        
        if status["status"] == "completed":
            break
        elif status["status"] == "failed":
            raise Exception(f"Processing failed: {status['message']}")
        
        time.sleep(2)
    
    # 4. Download result
    download_response = requests.get(
        f"{BASE_URL}/download/{job_id}",
        headers=HEADERS
    )
    
    with open("result.jpg", "wb") as f:
        f.write(download_response.content)
    
    print("Watermark removed and saved as result.jpg")

# Usage
remove_watermark("image_with_watermark.jpg")
```

## Configuration

### Environment Variables (Backend)

Copy `.env.example` to `.env` and configure:

```env
# Security
SECRET_KEY=your-super-secret-key-change-this-in-production

# Database
DATABASE_URL=sqlite:///./watermark_remover.db

# File Storage
UPLOAD_DIR=./uploads
PROCESSED_DIR=./processed
MAX_FILE_SIZE=26214400  # 25MB

# AI Processing
MODEL_CACHE_DIR=./models
ENABLE_GPU=true

# Rate Limiting
RATE_LIMIT_PER_MINUTE=10
```

## API Reference

### Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/v1/upload` | Upload image for processing |
| `POST` | `/api/v1/process` | Start watermark removal |
| `GET` | `/api/v1/status/{job_id}` | Check processing status |
| `GET` | `/api/v1/download/{job_id}` | Download processed image |
| `POST` | `/api/v1/api-keys` | Create new API key |
| `GET` | `/api/v1/api-keys` | List all API keys |
| `GET` | `/api/v1/health` | Health check |

### Rate Limiting

- **Web Interface**: 30 requests/minute per IP
- **API**: Configurable per API key (default: 10 requests/minute)

### File Limits

- **Max file size**: 25MB
- **Supported formats**: JPEG, PNG, WebP
- **Max resolution**: 5,000 × 5,000 pixels

## Deployment

### Production Deployment with Docker

1. **Clone the repository**:
```bash
git clone <your-repo-url>
cd watermark-remover
```

2. **Configure environment**:
```bash
cp backend/.env.example backend/.env
# Edit backend/.env with production values
```

3. **Start services**:
```bash
docker-compose up -d
```

4. **Set up reverse proxy** (optional):
```nginx
server {
    listen 80;
    server_name your-domain.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    
    location /api/ {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        client_max_body_size 50M;
    }
}
```

### Health Checks

```bash
# Backend health
curl http://localhost:8000/api/v1/health

# Frontend health
curl http://localhost:3000
```

## Development

### Backend Development

```bash
cd backend

# Install in development mode
pip install -r requirements.txt

# Run with auto-reload
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Run tests
pytest tests/

# Code formatting
black .
ruff check .
```

### Frontend Development

```bash
cd frontend

# Install dependencies
npm install

# Start dev server with hot reload
npm run dev

# Build for production
npm run build

# Type checking
npm run type-check

# Linting
npm run lint
```

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   React SPA     │    │   FastAPI        │    │  AI Processing  │
│                 │────│   Backend        │────│     Service     │
│  - Upload UI    │    │  - REST API      │    │ - Watermark     │
│  - Progress     │    │  - File Handling │    │   Detection     │
│  - Download     │    │  - Auth & Rate   │    │ - Image         │
└─────────────────┘    │    Limiting      │    │   Enhancement   │
                       └──────────────────┘    └─────────────────┘
                              │
                       ┌──────▼──────┐
                       │   SQLite    │
                       │  Database   │
                       │             │
                       │ - Jobs      │
                       │ - API Keys  │
                       │ - Metadata  │
                       └─────────────┘
```

## License

This project is for personal use only. Not for commercial distribution.

## Support

For issues and questions, please check the API documentation at `/docs` when running the backend.