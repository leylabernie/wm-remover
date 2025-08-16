# 🌟 One-Click Web Deployment

Deploy your AI watermark remover to the web in 5 minutes - no code, no commands!

## 📋 Prerequisites
- GitHub account (free at [github.com](https://github.com))
- Vercel account (free at [vercel.com](https://vercel.com))

## 🚀 3-Step Deployment

### Step 1: GitHub Upload (2 minutes)
1. **Create repository**: Go to GitHub → New repository → Name: `watermark-remover` → Public → Create
2. **Upload code**: Click "uploading an existing file" → Drag entire `/project/workspace/watermark-remover/` folder
3. **Commit**: Scroll down → "Commit changes"

### Step 2: Vercel Deploy (1 minute)  
1. **Connect**: Go to Vercel → Sign in with GitHub → New Project → Import `watermark-remover`
2. **Deploy**: Click "Deploy" (Vercel auto-detects configuration)
3. **Wait**: 2-3 minutes for deployment

### Step 3: Test & Use (2 minutes)
1. **Web App**: Visit `https://your-app-name.vercel.app`
2. **API Key**: Use demo key `wmr_demo_key_12345` 
3. **Upload**: Drop an image → Remove watermark → Download result

## 🎯 Your Live URLs
After deployment:
- **Web Interface**: `https://your-app-name.vercel.app`
- **API Health**: `https://your-app-name.vercel.app/api/health`
- **Create API Key**: `https://your-app-name.vercel.app/api/api-keys`

## 📱 Use Your API
```javascript
// Get new API key
fetch('https://your-app.vercel.app/api/api-keys', {method: 'POST'})
  .then(r => r.json())
  .then(data => console.log('API Key:', data.api_key))

// Upload & process image
const formData = new FormData();
formData.append('file', yourImageFile);

fetch('https://your-app.vercel.app/api/upload', {
  method: 'POST',
  body: formData,
  headers: {'X-API-Key': 'wmr_demo_key_12345'}
})
```

## ⚡ Auto-Updates
- Push code changes to GitHub
- Vercel automatically redeploys
- Live in 1-2 minutes

## 🆓 Free Forever
- 100GB bandwidth/month
- 100 API calls/day  
- Custom domains supported

---

**That's it!** Your watermark removal app is live on the internet. 🎉

Need help? Check the detailed guides:
- 📤 [GitHub Setup](./GITHUB_SETUP.md) 
- 🚀 [Vercel Deployment](./DEPLOY_VERCEL.md)