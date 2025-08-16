# 📤 GitHub Setup Guide

Quick guide to get your watermark remover code on GitHub for Vercel deployment.

## 🚀 Method 1: Direct Upload (Easiest)

### Create Repository
1. Go to [github.com](https://github.com) and click "New repository"
2. Repository name: `watermark-remover`
3. Description: `AI-powered watermark removal web app`
4. Set to **Public** (required for free Vercel)
5. **Don't** check "Initialize with README"
6. Click "Create repository"

### Upload Files
1. On your empty repository page, click "uploading an existing file"
2. **Download all files** from `/project/workspace/watermark-remover/`
3. **Drag and drop** the entire folder structure
4. **Important**: Make sure you upload these key files:
   - `vercel.json` (deployment config)
   - `api/index.py` (backend API)
   - `api/requirements.txt` (Python dependencies)
   - `frontend/` folder (entire React app)
   - `DEPLOY_VERCEL.md` (this guide)

### Commit
1. Scroll down to "Commit changes"
2. Title: `Initial watermark remover app`
3. Click "Commit changes"

---

## 🔗 Method 2: GitHub CLI (if you prefer)

If you have GitHub CLI installed locally:

```bash
# In the watermark-remover directory
gh repo create watermark-remover --public
git init
git add .
git commit -m "Initial watermark remover app"
git push --set-upstream origin main
```

---

## ✅ Verify Upload

Your repository should have this structure:
```
watermark-remover/
├── api/
│   ├── index.py
│   └── requirements.txt
├── frontend/
│   ├── src/
│   ├── package.json
│   ├── index.html
│   └── ...
├── vercel.json
├── README.md
├── DEPLOY_VERCEL.md
└── GITHUB_SETUP.md
```

## 🎯 Next Step

Once your code is on GitHub:
👉 **Follow the [DEPLOY_VERCEL.md](./DEPLOY_VERCEL.md) guide**

The deployment process will:
1. Connect your GitHub repo to Vercel
2. Auto-deploy your app
3. Give you a live URL
4. Automatically redeploy when you update GitHub

Your app will be live at: `https://your-repo-name.vercel.app`