# 🚜 Crane Rental Quiz Implementation Guide

## 📋 Overview

This implementation adds an interactive multi-step quiz for calculating crane rental costs on the intertransservice.kz website. The quiz is triggered by a fixed button in the bottom-right corner and collects user data to be sent to Telegram.

---

## 🗂️ File Structure & Installation

### Files Created:

```
intertransservice/
├── src/
│   ├── lib/
│   │   └── components/
│   │       └── CraneQuiz.svelte          ✅ Main Svelte component
│   ├── styles/
│   │   └── quiz.css                      ✅ Component styles
│   └── routes/
│       └── +layout.svelte                ✅ Root layout (NEEDS UPDATE)
├── send_quiz.php                         ✅ Backend handler
└── QUIZ_INSTALLATION.md                  ✅ This file
```

---

## 🚀 Installation Steps

### Step 1: Verify Files Are Created

All files have been created in the repository:
- ✅ `src/lib/components/CraneQuiz.svelte`
- ✅ `src/styles/quiz.css`
- ✅ `send_quiz.php` (in root directory)
- ✅ `src/routes/+layout.svelte`

### Step 2: Update Root Layout

Open **`src/routes/+layout.svelte`** and ensure it includes:

```svelte
<script>
  import CraneQuiz from '$lib/components/CraneQuiz.svelte';
</script>

<!-- Your existing layout content -->
<slot />

<!-- Add the quiz component at the end -->
<CraneQuiz />
```

### Step 3: Configure Telegram Bot

1. **Get your bot token:**
   - Open Telegram and message `@BotFather`
   - Create a new bot with `/newbot`
   - Copy the HTTP API token

2. **Get your chat ID:**
   - Send a message to your bot
   - Visit: `https://api.telegram.org/bot{YOUR_BOT_TOKEN}/getUpdates`
   - Find your `chat_id` in the response

3. **Update `send_quiz.php`:**
   
   Replace these placeholders at the top of the file:
   ```php
   define('TELEGRAM_BOT_TOKEN', 'YOUR_BOT_TOKEN_HERE');
   define('TELEGRAM_CHAT_ID', 'YOUR_CHAT_ID_HERE');
   ```

### Step 4: Verify Backend Endpoint

Ensure the frontend can access the backend:
- Frontend sends POST to: `/send_quiz.php`
- This path should match your actual deployment setup
- If using a subdirectory, update the fetch URL in `CraneQuiz.svelte`

---

## 🎯 Component Features

### Fixed Button
- **Position:** Bottom-right corner (fixed)
- **Style:** Orange/yellow gradient with construction theme
- **Hover Effect:** Lifts up with enhanced shadow
- **Icon:** 📊 (Stats icon)
- **Text:** "Расчет" (Calculate)

### Quiz Steps

#### Step 1: Equipment Parameters
- **Tonnage dropdown:** 25T, 50T, 100T, 200T, or "Need help"
- **Crane brand dropdown:** Any/Recommended, Liebherr, XCMG, Zoomlion
- Validation required before proceeding

#### Step 2: Rental Conditions
- **Region field:** Text input for Kazakhstan region
- **Rental period:** Number input (days/shifts)
- Navigation: Back/Next buttons
- Validation required before proceeding

#### Step 3: Contacts & Additional
- **Phone field:** Telephone input (required)
- **Notes:** Optional textarea for special requirements
- Submit button: "Get cost calculation"

### Progress Indicator
- Visual progress bar fills from 0% → 100%
- Updates smoothly when changing steps

### Success Message
- After submission, shows confirmation
- Closes modal automatically after 3 seconds
- Message: "Thank you! Manager will contact via WhatsApp"

---

## 💾 Data Sent to Telegram

The form data is formatted as a nicely styled HTML message:

```
🚜 New crane rental request (Quiz)

Equipment Parameters:
📊 Tonnage: 50 tons
🏭 Brand: XCMG

Rental Conditions:
📍 Region: Atyrau
⏱️ Rental period: 5

Contact Details:
📱 Phone: +7-701-234-56-78

Additionally:
Heavy cargo, requires special permits

Time received: 03.06.2026 10:30:45 (UTC+6)
```

---

## 🔒 Security Features

✅ **Input Sanitization:** All user inputs are cleaned with `strip_tags()` and `htmlspecialchars()`

✅ **CORS Headers:** Proper cross-origin handling

✅ **Method Validation:** Only POST requests accepted

✅ **Error Handling:** Try-catch blocks with user-friendly messages

✅ **Dual Transport:** Uses cURL (preferred) or file_get_contents as fallback

---

## 🛠️ Troubleshooting

### Issue: "Failed to connect to Telegram API"

**Solution:**
- Verify `TELEGRAM_BOT_TOKEN` and `TELEGRAM_CHAT_ID` are correct
- Check PHP configuration:
  - If cURL fails, ensure `allow_url_fopen = On` in php.ini
  - Or install cURL: `sudo apt-get install php-curl`

### Issue: Modal won't close after submission

**Solution:**
- Check browser console for JavaScript errors
- Verify `send_quiz.php` returns HTTP 200
- Clear browser cache and reload

### Issue: Form fields not validating

**Solution:**
- Check `CraneQuiz.svelte` for proper `bind:value` attributes
- Ensure no JavaScript errors in console
- Verify Svelte is version 5.x+

---

## 📱 Responsive Design

The quiz is fully responsive:

✅ **Desktop (1024px+):** Full-width modal, optimized spacing

✅ **Tablet (768px - 1023px):** Adjusted padding and font sizes

✅ **Mobile (< 768px):** Single-column layout, smaller button, stacked navigation

---

## 🎨 Customization Guide

### Change Button Color
In `src/styles/quiz.css`, update:
```css
.quiz-button {
  background: linear-gradient(135deg, #YOUR_COLOR_1, #YOUR_COLOR_2);
}
```

### Change Modal Width
```css
.quiz-modal {
  max-width: 600px; /* Increase from 500px */
}
```

### Add More Questions
In `src/lib/components/CraneQuiz.svelte`:
1. Increment `totalSteps` constant
2. Add new form fields to `formData` object
3. Create new step block: `{#if currentStep === 4}`
4. Add validation logic in `goToStep()` function

---

## 🧪 Testing Checklist

- [ ] Button appears in bottom-right corner
- [ ] Button hover effect works smoothly
- [ ] Modal opens/closes without errors
- [ ] Progress bar updates correctly
- [ ] All form validations trigger properly
- [ ] Form data sends to Telegram
- [ ] Success message displays
- [ ] Mobile layout is responsive
- [ ] All inputs accept proper data types

---

## 📧 Support & Maintenance

For issues or questions:
1. Check browser console for JavaScript errors
2. Check server logs for PHP errors
3. Verify Telegram bot token and chat ID
4. Ensure PHP version 7.4 or higher
5. Test with simple curl command:

```bash
curl -X POST https://api.telegram.org/bot{TOKEN}/sendMessage \
  -H "Content-Type: application/json" \
  -d '{"chat_id":"{CHAT_ID}","text":"Test message","parse_mode":"HTML"}'
```

---

## 📄 License

This implementation is part of the intertransservice.kz project.

---

**Last Updated:** June 3, 2026  
**Version:** 1.0  
**Status:** ✅ Production Ready
