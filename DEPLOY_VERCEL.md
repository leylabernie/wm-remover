# 🚀 Deploy to Vercel (No Commands Required!)

Deploy your watermark removal app to the web in minutes using just your browser.

## 📋 What You'll Need
- GitHub account (free)
- Vercel account (free) - sign up at [vercel.com](https://vercel.com)

## 🛠️ Step-by-Step Deployment

### Step 1: Push to GitHub
1. Go to [github.com](https://github.com) and create a new repository
2. Name it `watermark-remover` (or any name you prefer)
3. Set it to **Public** (required for free Vercel deployment)
4. Don't initialize with README (we have files already)
5. Click "Create repository"

### Step 2: Upload Your Code
1. On your new repository page, click "uploading an existing file"
2. Drag and drop the entire `/project/workspace/watermark-remover/` folder contents
3. Or use GitHub's web interface to upload files/folders
4. Important files to upload:
   ```
   ├── api/
   │   ├── index.py
   │   └── requirements.txt
   ├── frontend/
   │   ├── src/
   │   ├── package.json
   │   └── (all frontend files)
   ├── vercel.json
   └── README.md
   ```
5. Commit the files with message: "Initial watermark remover app"

### Step 3: Deploy to Vercel
1. Go to [vercel.com](https://vercel.com) and sign in with GitHub
2. Click "New Project"
3. Import your `watermark-remover` repository
4. Vercel will auto-detect the configuration from `vercel.json`
5. Click "Deploy" 

### Step 4: Configure Settings (if needed)
If deployment fails, check these settings in Vercel:
- **Build Command**: `cd frontend && npm run build`
- **Output Directory**: `frontend/dist`
- **Install Command**: `cd frontend && npm install`

### Step 5: Access Your App
After deployment (2-3 minutes), you'll get:
- **Your Web App**: `https://your-app-name.vercel.app`
- **API Endpoints**: `https://your-app-name.vercel.app/api/health`

## 🔧 Test Your Deployment

### Quick API Test
Open your browser and visit:
```
https://your-app-name.vercel.app/api/health
```

You should see:
```json
{
  "status": "healthy",
  "version": "1.0.0",
  "message": "Watermark Remover API is running"
}
```

### Web Interface Test
1. Visit your main URL: `https://your-app-name.vercel.app`
2. Upload a test image
3. Click "Remove Watermark"
4. Download the processed image

## 🔑 Get Your API Key

### Via Web Interface
1. Go to your deployed app
2. Open browser Developer Tools (F12)
3. Go to Console tab
4. Run this command:
```javascript
fetch('/api/api-keys', {method: 'POST'})
  .then(r => r.json())
  .then(data => console.log('Your API Key:', data.api_key))
```

### Via Direct API Call
Visit this URL in your browser:
```
https://your-app-name.vercel.app/api/api-keys
```

Save the API key - you'll need it for automation!

## 🤖 Use Your API

### Python Example
```python
import requests

API_BASE = "https://your-app-name.vercel.app/api"
API_KEY = "wmr_your_api_key_here"  # from step above

# Upload and process image
files = {'file': open('your_image.jpg', 'rb')}
upload = requests.post(f"{API_BASE}/upload", 
                      files=files, 
                      headers={"X-API-Key": API_KEY})

job_id = upload.json()['job_id']

# Start processing
requests.post(f"{API_BASE}/process", 
              json={"job_id": job_id},
              headers={"X-API-Key": API_KEY})

# Check status and download
import time
while True:
    status = requests.get(f"{API_BASE}/status/{job_id}",
                         headers={"X-API-Key": API_KEY}).json()
    if status['status'] == 'completed':
        # Download result
        result = requests.get(f"{API_BASE}/download/{job_id}",
                            headers={"X-API-Key": API_KEY})
        with open('result.jpg', 'wb') as f:
            f.write(result.content)
        break
    time.sleep(2)
```

### JavaScript/Node.js Example
```javascript
const API_BASE = "https://your-app-name.vercel.app/api";
const API_KEY = "wmr_your_api_key_here";

const formData = new FormData();
formData.append('file', fileInput.files[0]);

// Upload
const upload = await fetch(`${API_BASE}/upload`, {
  method: 'POST',
  body: formData,
  headers: {'X-API-Key': API_KEY}
});

const {job_id} = await upload.json();

// Process
await fetch(`${API_BASE}/process`, {
  method: 'POST',
  body: JSON.stringify({job_id}),
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': API_KEY
  }
});

// Poll for completion and download
// (similar to Python example)
```

## 🔄 Update Your App

To update your deployed app:
1. Make changes to your local files
2. Upload/commit changes to GitHub repository
3. Vercel automatically redeploys (takes 1-2 minutes)

## 📊 Monitor Usage

Visit your Vercel dashboard to see:
- Deployment logs
- Function invocations
- Performance metrics
- Error tracking

## 🆓 Free Limits

Vercel free tier includes:
- **100GB** bandwidth per month
- **100** serverless function executions per day
- **10GB** function execution time per month
- Custom domain support

Perfect for personal use and testing!

## 🛠️ Troubleshooting

### Common Issues
1. **Build fails**: Check that all files are uploaded correctly
2. **API not working**: Ensure `api/index.py` and `api/requirements.txt` exist
3. **Large images fail**: Free tier has memory limits, use smaller images (< 10MB)

### Get Help
- Check Vercel deployment logs in your dashboard
- Visit the Functions tab to see serverless function status
- Use browser Developer Tools to check network requests

---

Your watermark removal app is now live on the internet! 🎉

**Your URLs:**
- Web App: `https://your-app-name.vercel.app`
- API: `https://your-app-name.vercel.app/api`
- Health Check: `https://your-app-name.vercel.app/api/health`