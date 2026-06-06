#!/bin/bash

# ===== CRANE RENTAL QUIZ - DEPLOYMENT VERIFICATION SCRIPT =====
# 
# Purpose: Verify all quiz components are correctly deployed
# Usage: bash verify-deployment.sh
# 
# This script checks:
# - Build output completeness
# - File structure integrity
# - Static assets presence
# - PHP handler accessibility
# - Telegram configuration

set -e

echo "🚀 ======================================"
echo "   DEPLOYMENT VERIFICATION SCRIPT"
echo "======================================"
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASS=0
FAIL=0

# Helper functions
pass() {
    echo -e "${GREEN}✓ PASS${NC} - $1"
    ((PASS++))
}

fail() {
    echo -e "${RED}✗ FAIL${NC} - $1"
    ((FAIL++))
}

warn() {
    echo -e "${YELLOW}⚠ WARN${NC} - $1"
}

info() {
    echo -e "${BLUE}ℹ INFO${NC} - $1"
}

# ===== CHECK 1: Build Exists =====
echo ""
echo "1️⃣  Checking build output..."

if [ -d "build" ]; then
    pass "build/ directory exists"
else
    fail "build/ directory not found - Run 'npm run build' first"
    exit 1
fi

# ===== CHECK 2: Index.html =====
echo ""
echo "2️⃣  Checking main entry point..."

if [ -f "build/index.html" ]; then
    SIZE=$(du -h build/index.html | cut -f1)
    pass "build/index.html exists (${SIZE})"
else
    fail "build/index.html not found"
fi

# ===== CHECK 3: PHP Handler =====
echo ""
echo "3️⃣  Checking PHP handler..."

if [ -f "build/send_quiz.php" ]; then
    SIZE=$(du -h build/send_quiz.php | cut -f1)
    pass "build/send_quiz.php exists (${SIZE}) ⭐ CRITICAL"
    
    # Check if PHP file contains Telegram credentials
    if grep -q "TELEGRAM_BOT_TOKEN" build/send_quiz.php; then
        pass "Telegram Bot Token found in PHP file"
    else
        fail "Telegram Bot Token NOT found in PHP file"
    fi
    
    if grep -q "TELEGRAM_CHAT_ID" build/send_quiz.php; then
        pass "Telegram Chat ID found in PHP file"
    else
        fail "Telegram Chat ID NOT found in PHP file"
    fi
else
    fail "build/send_quiz.php not found - CRITICAL FOR DEPLOYMENT"
fi

# ===== CHECK 4: App Bundle =====
echo ""
echo "4️⃣  Checking application bundle..."

if [ -d "build/_app" ]; then
    pass "build/_app/ directory exists"
    
    if [ -d "build/_app/immutable" ]; then
        pass "build/_app/immutable/ directory exists"
        
        CHUNK_COUNT=$(find build/_app/immutable/chunks -name "*.js" 2>/dev/null | wc -l)
        if [ "$CHUNK_COUNT" -gt 0 ]; then
            pass "Found $CHUNK_COUNT JavaScript chunks"
        else
            fail "No JavaScript chunks found"
        fi
    else
        fail "build/_app/immutable/ directory not found"
    fi
else
    fail "build/_app/ directory not found"
fi

# ===== CHECK 5: Source Files =====
echo ""
echo "5️⃣  Checking source component files..."

if [ -f "src/lib/components/CraneQuiz.svelte" ]; then
    SIZE=$(du -h src/lib/components/CraneQuiz.svelte | cut -f1)
    pass "CraneQuiz.svelte exists (${SIZE})"
else
    fail "CraneQuiz.svelte not found"
fi

if grep -q "<style>" src/lib/components/CraneQuiz.svelte; then
    pass "CraneQuiz.svelte contains scoped styles"
else
    fail "CraneQuiz.svelte is missing <style> block"
fi

if [ -f "static/send_quiz.php" ]; then
    SIZE=$(du -h static/send_quiz.php | cut -f1)
    pass "static/send_quiz.php exists (${SIZE})"
else
    fail "static/send_quiz.php not found"
fi

# ===== CHECK 6: Layout Update =====
echo ""
echo "6️⃣  Checking layout integration..."

if grep -q "CraneQuiz" src/routes/+layout.svelte; then
    pass "CraneQuiz component imported in +layout.svelte"
else
    fail "CraneQuiz component NOT found in +layout.svelte"
fi

# ===== CHECK 7: Git Status =====
echo ""
echo "7️⃣  Checking Git status..."

if git rev-parse --git-dir > /dev/null 2>&1; then
    UNCOMMITTED=$(git status --short | wc -l)
    if [ "$UNCOMMITTED" -eq 0 ]; then
        pass "Git repository clean (all changes committed)"
    else
        warn "Git repository has $UNCOMMITTED uncommitted changes"
    fi
    
    UNPUSHED=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
    if [ "$UNPUSHED" -eq 0 ]; then
        pass "All commits pushed to remote"
    else
        warn "Git has $UNPUSHED unpushed commits"
    fi
else
    warn "Not a Git repository - skipping Git checks"
fi

# ===== CHECK 8: File Permissions (Linux/Mac only) =====
echo ""
echo "8️⃣  Checking file permissions..."

if [ -f "build/send_quiz.php" ]; then
    PERMS=$(stat -f "%OLp" build/send_quiz.php 2>/dev/null || stat -c '%a' build/send_quiz.php 2>/dev/null || echo "unknown")
    if [ "$PERMS" != "unknown" ]; then
        pass "PHP file permissions: $PERMS"
    fi
fi

# ===== CHECK 9: File Sizes =====
echo ""
echo "9️⃣  Checking file sizes..."

BUILD_SIZE=$(du -sh build | cut -f1)
info "Total build size: ${BUILD_SIZE}"

# ===== SUMMARY =====
echo ""
echo "======================================"
echo "   VERIFICATION SUMMARY"
echo "======================================"
echo ""
echo -e "${GREEN}✓ Passed: $PASS${NC}"
echo -e "${RED}✗ Failed: $FAIL${NC}"
echo ""

if [ "$FAIL" -eq 0 ]; then
    echo -e "${GREEN}🎉 ALL CHECKS PASSED! Ready for deployment.${NC}"
    exit 0
else
    echo -e "${RED}❌ Some checks failed. Please review above.${NC}"
    exit 1
fi
