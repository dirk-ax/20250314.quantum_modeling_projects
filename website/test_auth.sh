#!/bin/bash
# Authentication test script for the Axiomatic_AI Education Initiative website
# This script uses curl to test basic HTTP functionality

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Set the hostname based on the Docker environment variable or default to localhost
HOST=${HOST:-localhost}
PORT=${PORT:-8080}
BASE_URL="http://${HOST}:${PORT}"

echo "===== Testing Axiomatic_AI Education Initiative Website ====="
echo "Testing web server at ${BASE_URL}"

# Test 1: Check if website is accessible
echo -e "\n${GREEN}Test 1:${NC} Checking if website is accessible..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" ${BASE_URL})

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo -e "${GREEN}✓ SUCCESS:${NC} Website is accessible (Status: $HTTP_STATUS)"
else
    echo -e "${RED}✗ FAILED:${NC} Website is not accessible (Status: $HTTP_STATUS)"
    exit 1
fi

# Test 2: Check if login page has login form
echo -e "\n${GREEN}Test 2:${NC} Checking if login page has the login form..."
LOGIN_FORM=$(curl -s ${BASE_URL} | grep -c "login-form")

if [ "$LOGIN_FORM" -gt 0 ]; then
    echo -e "${GREEN}✓ SUCCESS:${NC} Login form found on the page"
else
    echo -e "${RED}✗ FAILED:${NC} Login form not found on the page"
    exit 1
fi

# Test 3: Check if username field exists
echo -e "\n${GREEN}Test 3:${NC} Checking if username field exists..."
USERNAME_FIELD=$(curl -s ${BASE_URL} | grep -c 'id="username"')

if [ "$USERNAME_FIELD" -gt 0 ]; then
    echo -e "${GREEN}✓ SUCCESS:${NC} Username field found on the login page"
else
    echo -e "${RED}✗ FAILED:${NC} Username field not found on the login page"
    exit 1
fi

# Test 4: Check if password field exists
echo -e "\n${GREEN}Test 4:${NC} Checking if password field exists..."
PASSWORD_FIELD=$(curl -s ${BASE_URL} | grep -c 'id="password"')

if [ "$PASSWORD_FIELD" -gt 0 ]; then
    echo -e "${GREEN}✓ SUCCESS:${NC} Password field found on the login page"
else
    echo -e "${RED}✗ FAILED:${NC} Password field not found on the login page"
    exit 1
fi

# Test 5: Confirm main.html exists
echo -e "\n${GREEN}Test 5:${NC} Checking if main.html exists..."
MAIN_PAGE=$(curl -s -o /dev/null -w "%{http_code}" ${BASE_URL}/main.html)

if [ "$MAIN_PAGE" -eq 200 ]; then
    echo -e "${GREEN}✓ SUCCESS:${NC} main.html exists (Status: $MAIN_PAGE)"
else
    echo -e "${RED}✗ FAILED:${NC} main.html does not exist (Status: $MAIN_PAGE)"
    exit 1
fi

# Test 6: Verify main.html contains logout button
echo -e "\n${GREEN}Test 6:${NC} Checking if main.html contains logout button..."
LOGOUT_BUTTON=$(curl -s ${BASE_URL}/main.html | grep -c 'id="logout-btn"')

if [ "$LOGOUT_BUTTON" -gt 0 ]; then
    echo -e "${GREEN}✓ SUCCESS:${NC} Logout button found on main.html"
else
    echo -e "${RED}✗ FAILED:${NC} Logout button not found on main.html"
    exit 1
fi

# Test 7: Verify authentication check in main.html
echo -e "\n${GREEN}Test 7:${NC} Verifying authentication check in main.html..."
AUTH_CHECK=$(curl -s ${BASE_URL}/main.html | grep -c "isAuthenticated")

if [ "$AUTH_CHECK" -gt 0 ]; then
    echo -e "${GREEN}✓ SUCCESS:${NC} Authentication check verified in main.html"
else
    echo -e "${RED}✗ FAILED:${NC} Authentication check not found in main.html"
    exit 1
fi

# Test 8: Verify correct login credentials in index.html
echo -e "\n${GREEN}Test 8:${NC} Verifying correct login credentials are in the code..."
USERNAME_CHECK=$(curl -s ${BASE_URL}/index.html | grep -c "correctUsername.*axiomatic")
PASSWORD_CHECK=$(curl -s ${BASE_URL}/index.html | grep -c "correctPassword.*quantum2025")

if [ "$USERNAME_CHECK" -gt 0 ] && [ "$PASSWORD_CHECK" -gt 0 ]; then
    echo -e "${GREEN}✓ SUCCESS:${NC} Login credentials verified in the code"
else
    echo -e "${RED}✗ FAILED:${NC} Login credentials not found or incorrect"
    echo -e "  Username check: $USERNAME_CHECK, Password check: $PASSWORD_CHECK"
    exit 1
fi

echo -e "\n${GREEN}All tests passed!${NC} The website is properly set up with password protection."
echo "Login credentials: username='axiomatic', password='quantum2025'"
