# 🚀 CRANE RENTAL QUIZ - PRODUCTION DEPLOYMENT GUIDE

## 📋 Pre-Deployment Checklist

Before deploying to https://intertransservice.kz/, verify:

- [ ] Node.js v18+ installed on your local machine
- [ ] Git configured with your GitHub credentials
- [ ] SvelteKit project cloned/pulled locally
- [ ] All changes committed to local repository
- [ ] Hosting environment supports PHP 7.4+
- [ ] FTP/SFTP access credentials ready (if manual deploy)
- [ ] Database backup taken (if applicable)

---

## 📦 STEP 1: Build the Project Locally

### 1a. Navigate to Project Directory

```bash
cd /path/to/intertransservice
```

### 1b. Install Dependencies (if not already done)

```bash
npm install
```

### 1c. Run Production Build

```bash
npm run build
```

**Expected Output:**
```
✓ built in 45.23s

built/
├── .svelte-kit/
├── index.html
├── _app/
├── send_quiz.php        ← Should be here!
└── [other assets...]
```

### ⚠️ Troubleshooting Build Errors

If you get TypeScript errors:
```bash
npm run check
```

If you get eslint errors:
```bash
npm run lint
```

If dependencies are corrupted:
```bash
rm -rf node_modules package-lock.json
npm install
npm run build
```

---

## ✅ STEP 2: Verify Static Files are Included

After build completes, verify:

```bash
# Check if send_quiz.php is in build output
ls -la build/send_quiz.php

# Should output:
# -rw-r--r--  send_quiz.php    (about 6 KB)
```

**If NOT present, do this:**

1. Check `static/send_quiz.php` exists in your repo:
   ```bash
   ls -la static/send_quiz.php
   ```

2. Rebuild:
   ```bash
   npm run build
   ```

3. Verify again - it should now be in `build/send_quiz.php`

### Run Verification Script

```bash
bash verify-deployment.sh
```

This automatically checks:
✓ Build directory exists  
✓ All required files present  
✓ PHP handler with Telegram credentials  
✓ App bundles compiled  
✓ Source files in place  
✓ Layout integration  
✓ Git status clean  

---

## 📝 STEP 3: Commit and Push Changes

### 3a. Check Git Status

```bash
git status
```

**You should see:**
```
On branch master
nothing to commit, working tree clean
```

(If you haven't committed yet, all files should already be in GitHub from earlier commits)

### 3b. Verify Commits Pushed

```bash
git log --oneline -5
```

Should show recent commits like:
```
d5e71b2 Add configured send_quiz.php to static folder for SvelteKit
ac3c2d4 Update send_quiz.php with Telegram Bot credentials
5cd2ac3 Add CraneQuiz component to root layout
...
```

### 3c. Push Latest Changes (if any)

```bash
git add .
git commit -m "chore: Final deployment verification and scripts"
npm run deploy   # production: origin → hayshin/intertransservice → intertransservice.kz
```

---

## 🖥️ STEP 4: Deploy to Production

### Option A: Automated Deployment (Recommended if available)

Production uses **GitHub Actions** on `hayshin/intertransservice`:

1. Run `npm run deploy` (pushes to `origin master` = production)
2. Workflow `.github/workflows/deploy.yml` builds and publishes to GitHub Pages
3. Custom domain: https://intertransservice.kz/
4. Track deploy: https://github.com/hayshin/intertransservice/actions

Pushing only to `fork` (backup) does **not** update the live site.

### Option B: Manual SCP Deployment (Linux/Mac/Windows Git Bash)

```bash
# Deploy entire build folder
scp -r build/* user@intertransservice.kz:/var/www/html/

# Or using IP address
scp -r build/* user@123.45.67.89:/var/www/html/
```

### Option C: SFTP Deployment

```bash
sftp user@intertransservice.kz

# In SFTP prompt:
cd /public_html              # or /var/www/html
put -r ./build/* .
bye
```

### Option D: Rsync Deployment (Best for large files)

```bash
rsync -avz --delete build/ user@intertransservice.kz:/var/www/html/

# With progress indication
rsync -avz --progress --delete build/ user@intertransservice.kz:/var/www/html/
```

### Option E: FTP via GUI

Use your favorite FTP client (FileZilla, WinSCP, Cyberduck):

1. Connect to: `ftp.intertransservice.kz` or `sftp.intertransservice.kz`
2. Navigate to: `/public_html` or `/var/www/html`
3. Upload: All files from `build/` folder
4. Ensure `send_quiz.php` is uploaded to root!

---

## 🔍 STEP 5: Post-Deployment Verification

### 5a. Test Frontend Component

```bash
# Open browser and visit
https://intertransservice.kz/

# Look for 📊 "Расчет" button in bottom-right corner
# Click button → Modal should open
# Fill out all 3 steps and submit
```

### 5b. Test Backend Handler via curl

```bash
curl -X POST https://intertransservice.kz/send_quiz.php \
  -H "Content-Type: application/json" \
  -d '{
    "tonnage": "50 тонн",
    "craneBrand": "XCMG",
    "region": "Атырау",
    "rentalPeriod": "5",
    "phone": "+7-701-234-5678",
    "notes": "Test deployment message"
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "message": "Заявка успешно отправлена"
}
```

### 5c. Verify Telegram Message

1. Check your Telegram chat
2. You should receive a formatted message with:
   - 🚜 Crane rental request title
   - All form data (tonnage, brand, region, rental period)
   - Phone number
   - Optional notes
   - Timestamp

### 5d. Check Browser Console

Open DevTools (`F12`) and verify:

- [ ] No JavaScript errors in Console tab
- [ ] No CSS errors
- [ ] Network tab shows `/send_quiz.php` POST request with 200 response
- [ ] Quiz button is visible and clickable
- [ ] Modal opens/closes without errors

---

## 📊 Complete Production Build Checklist

- [ ] `npm run build` completes without TypeScript/compilation errors
- [ ] `build/send_quiz.php` exists (approximately 6 KB)
- [ ] `build/index.html` exists
- [ ] `build/_app/immutable/chunks/` contains JavaScript files
- [ ] `verify-deployment.sh` runs successfully (all checks pass)
- [ ] Git status clean (all changes committed)
- [ ] GitHub shows all files pushed
- [ ] Files uploaded to production server at root level
- [ ] `send_quiz.php` is in web root (not in subdirectory)
- [ ] Quiz button visible on live site
- [ ] Form submits without errors
- [ ] Telegram receives formatted message
- [ ] No console errors on live production site
- [ ] Mobile responsive design works correctly

---

## 🚀 Quick Deploy Command Sequence

**Copy and paste this entire sequence:**

```bash
# 1. Navigate to project
cd /path/to/intertransservice

# 2. Build
npm run build

# 3. Verify build
bash verify-deployment.sh

# 4. Push any final changes
git add .
git commit -m "chore: Final deployment check" || true
npm run deploy || true

# 5. Deploy via SCP (replace with your server details)
scp -r build/* user@intertransservice.kz:/var/www/html/

# 6. Verify on server
ssh user@intertransservice.kz "ls -la /var/www/html/send_quiz.php && echo '✅ Deployment successful'"

# 7. Test with curl
curl -X POST https://intertransservice.kz/send_quiz.php \
  -H "Content-Type: application/json" \
  -d '{"tonnage":"25 тонн","craneBrand":"Liebherr","region":"Алматы","rentalPeriod":"3","phone":"+7-771-234-5678","notes":"Deployment test"}'
```

---

## 📂 FTP Manual Deployment - Complete File List

**Upload the ENTIRE `build/` folder to your hosting root.**

Folder structure on server after deployment:

```
YOUR HOSTING ROOT
│
├── 📄 index.html                    ← Main HTML entry point
├── 📄 send_quiz.php                 ← ⭐ CRITICAL - Telegram handler
├── 📁 _app/
│   ├── 📁 immutable/
│   │   ├── 📁 chunks/
│   │   │   ├── 📄 index-XXXXX.js
│   │   │   ├── 📄 CraneQuiz-XXXXX.js
│   │   │   ├── 📄 quiz.css-XXXXX.js
│   │   │   └── 📄 [other chunks...]
│   │   ├── 📄 version.json
│   │   └── 📄 [preload files...]
│   └── 📄 env.js
├── 📁 [static assets if any]
└── 📄 [other files...]
```

**Critical files to verify after FTP upload:**

| File | Required | Size | Purpose |
|------|----------|------|---------|
| `index.html` | ✅ Yes | ~2 KB | Main HTML |
| `send_quiz.php` | ✅ YES | ~6 KB | Telegram handler |
| `_app/immutable/version.json` | ✅ Yes | ~50 B | Version tracking |
| `_app/immutable/chunks/*.js` | ✅ Yes | ~500 KB total | App bundles |

---

## 🆘 Troubleshooting Deployment Issues

### Issue: Build fails with "command not found: npm"

**Solution:**
- Install Node.js: https://nodejs.org/ (v18+)
- Verify: `node -v` and `npm -v`
- Retry: `npm install && npm run build`

### Issue: "send_quiz.php not found (404 error)"

**Solution:**
1. Verify file exists locally:
   ```bash
   ls -la build/send_quiz.php
   ```
2. If missing, check source:
   ```bash
   ls -la static/send_quiz.php
   ```
3. Rebuild if needed:
   ```bash
   npm run build
   ```
4. Re-upload `send_quiz.php` to web root (not in subdirectory)

### Issue: Quiz button doesn't appear on live site

**Solution:**
- Clear browser cache: `Ctrl+Shift+Delete`
- Hard refresh: `Ctrl+F5`
- Check DevTools console (`F12`) for JavaScript errors
- Verify `_app/immutable/chunks/` files are uploaded
- Check Network tab - all JavaScript should load successfully

### Issue: Form submits but Telegram doesn't receive message

**Solution:**
- Test PHP handler:
  ```bash
  curl https://intertransservice.kz/send_quiz.php
  ```
  Should return JSON response (not 404 or 500)

- Check Telegram credentials in file:
  ```bash
  ssh user@intertransservice.kz
  grep "TELEGRAM" /var/www/html/send_quiz.php
  ```

- Test Telegram API directly:
  ```bash
  curl "https://api.telegram.org/bot<TELEGRAM_BOT_TOKEN>/sendMessage?chat_id=<TELEGRAM_CHAT_ID>&text=Test"
  ```

- Check server PHP error logs:
  ```bash
  ssh user@intertransservice.kz
  tail -f /var/log/php-fpm.log
  ```

### Issue: 503 Service Unavailable after deployment

**Solution:**
- SSH to server and check PHP:
  ```bash
  ssh user@intertransservice.kz
  php -v
  ```
- Check if PHP service is running:
  ```bash
  sudo systemctl status php-fpm
  ```
- Restart PHP:
  ```bash
  sudo systemctl restart php-fpm
  ```

### Issue: Mobile site shows broken layout

**Solution:**
- Clear cache and hard refresh
- Check if CSS files are loading (Network tab)
- Verify `_app/immutable/chunks/*.css` files exist on server
- Test on different mobile device/browser

---

## 🔐 Post-Deployment Security Check

After deployment, verify security:

```bash
# Check PHP permissions (should be 644, not 777)
ssh user@intertransservice.kz "ls -la /var/www/html/send_quiz.php"

# Should output something like:
# -rw-r--r-- 1 user group 6208 Jun 3 10:30 send_quiz.php

# NOT:
# -rwxrwxrwx (777) - SECURITY RISK!
```

If permissions are wrong, fix them:

```bash
ssh user@intertransservice.kz "chmod 644 /var/www/html/send_quiz.php"
```

---

## 📞 Support & Rollback

### If deployment fails, rollback to previous version:

```bash
# SSH to server
ssh user@intertransservice.kz

# Backup current version
cp -r /var/www/html /var/www/html.backup.$(date +%s)

# Restore from backup if available
# cp -r /var/www/html.backup.XXXX/* /var/www/html/
```

### For ongoing support:

- **SvelteKit Docs:** https://kit.svelte.dev/docs/building-and-deploying
- **Telegram Bot API:** https://core.telegram.org/bots/api
- **PHP Error Logs:** Check hosting control panel (cPanel, Plesk, DirectAdmin)

---

## ✅ Final Pre-Deployment Checklist

Before clicking deploy:

- [ ] Ran `npm run build` successfully
- [ ] Ran `bash verify-deployment.sh` - all checks pass
- [ ] All files committed to Git
- [ ] All commits pushed to GitHub
- [ ] Have FTP/SSH credentials ready
- [ ] Have backup of current production
- [ ] Tested quiz form locally
- [ ] Tested with curl locally
- [ ] Checked Telegram message format
- [ ] Telegram bot is active and responding
- [ ] DNS resolves to correct server
- [ ] SSL certificate valid for domain

---

## 🎉 You're Ready to Deploy!

Your crane rental quiz is production-ready!

**Estimated deployment time: 5-10 minutes**

After deployment:
1. Visit https://intertransservice.kz/
2. Test the 📊 "Расчет" button
3. Fill the form and submit
4. Check Telegram for message
5. Celebrate! 🚜✨

---

**Last Updated:** June 3, 2026  
**Version:** 1.0  
**Status:** Production Ready  

---

## 📚 Additional Resources in Your Repository

- `QUIZ_INSTALLATION.md` - Setup & configuration guide
- `QUIZ_DEPLOYMENT.md` - This file
- `verify-deployment.sh` - Automated verification script
- `src/lib/components/CraneQuiz.svelte` - Quiz component
- `src/styles/quiz.css` - Styling
- `static/send_quiz.php` - Telegram handler
