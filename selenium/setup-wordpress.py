#python setup-wordpress.py http://192.168.1.13:49158

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import sys


browser = webdriver.Firefox()

browser.get(sys.argv[1] + '/wp-admin/install.php')
#browser.get('http://192.168.1.13:49158/wp-admin/install.php')

elem = browser.find_element_by_id('weblog_title')
elem.send_keys('Website Title')
elem = browser.find_element_by_id('user_login')
elem.send_keys('user')
elem = browser.find_element_by_id('pass1')
elem.send_keys('password')
elem = browser.find_element_by_id('pass2')
elem.send_keys('password')
elem = browser.find_element_by_id('admin_email')
elem.send_keys('some_email@mymail.com' + Keys.RETURN)

elem = browser.find_element_by_class_name('wp-core-ui') 
assert 'Success!' in elem.text


browser.quit()
