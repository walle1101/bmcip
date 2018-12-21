#!/usr/bin/env python
#encoding: utf-8
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--headless')
driver = webdriver.Chrome(chrome_options=chrome_options)
driver.get('http://192.168.1.111')
driver.maximize_window()
driver.implicitly_wait(10)
driver.find_element_by_id('userid').send_keys('admin')
driver.find_element_by_id('password').send_keys('admin')
driver.find_element_by_id('btn-login').click()
driver.implicitly_wait(5)
alert =driver.switch_to_alert()
alert.accept()
time.sleep(10)
ver = driver.find_element_by_id('bios_ver').text
print "The  BIOS version is %s" %ver
