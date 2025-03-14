#!/usr/bin/env python3
"""
Selenium test script for the Axiomatic_AI Education Initiative website login functionality.
This script tests both valid and invalid login attempts.
"""

import os
import time
import unittest
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By

class LoginTest(unittest.TestCase):
    """Test class for website login functionality."""

    def setUp(self):
        """Set up the test environment before each test case."""
        chrome_options = Options()
        chrome_options.add_argument('--headless')
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-dev-shm-usage')
        self.driver = webdriver.Chrome(options=chrome_options)
        self.base_url = os.environ.get('BASE_URL', 'http://localhost:8080')

    def tearDown(self):
        """Clean up after each test case."""
        self.driver.quit()

    def test_login_valid_credentials(self):
        """Test login with valid credentials."""
        test_login(self.driver, self.base_url, 'axiomatic', 'quantum2025', True)
    
    def test_login_invalid_username(self):
        """Test login with invalid username."""
        test_login(self.driver, self.base_url, 'invalid', 'quantum2025', False)
    
    def test_login_invalid_password(self):
        """Test login with invalid password."""
        test_login(self.driver, self.base_url, 'axiomatic', 'invalid', False)
    
    def test_login_empty_credentials(self):
        """Test login with empty credentials."""
        test_login(self.driver, self.base_url, '', '', False)
    
    def test_redirect_to_login(self):
        """Test redirect to login page when unauthorized."""
        self.driver.get(f"{self.base_url}/main.html")
        time.sleep(1)
        
        # After redirect, the URL should end with index.html
        current_url = self.driver.current_url
        self.assertTrue(current_url.endswith('index.html'),
                       f"Expected URL to end with index.html, got {current_url}")
    
    def test_logout_functionality(self):
        """Test logout functionality."""
        # First login with valid credentials
        test_login(self.driver, self.base_url, 'axiomatic', 'quantum2025', True)
        
        # Find and click the logout button
        logout_button = self.driver.find_element(By.ID, 'logout-btn')
        logout_button.click()
        time.sleep(1)
        
        # After logout, we should be redirected to the login page
        current_url = self.driver.current_url
        self.assertTrue(current_url.endswith('index.html'),
                       f"Expected URL to end with index.html after logout, got {current_url}")

def test_login(driver, base_url, username, password, should_succeed=True):
    """
    Test the login functionality with given credentials.
    
    Args:
        driver: WebDriver instance
        base_url: Base URL of the website
        username: Username to test
        password: Password to test
        should_succeed: Expected outcome (True for success, False for failure)
    """
    # Navigate to the login page
    driver.get(base_url)
    time.sleep(1)

    # Find username and password fields and input the credentials
    username_field = driver.find_element(By.ID, 'username')
    password_field = driver.find_element(By.ID, 'password')
    
    username_field.clear()
    username_field.send_keys(username)
    password_field.clear()
    password_field.send_keys(password)
    
    # Submit the form
    submit_button = driver.find_element(By.ID, 'login-button')
    submit_button.click()
    time.sleep(1)
    
    # Check if login was successful or not
    current_url = driver.current_url
    if should_succeed:
        assert current_url.endswith('main.html'), f"Login should succeed, but URL is {current_url}"
    else:
        assert not current_url.endswith('main.html'), f"Login should fail, but URL is {current_url}"

if __name__ == '__main__':
    unittest.main()
