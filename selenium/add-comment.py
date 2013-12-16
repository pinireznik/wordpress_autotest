from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import sys


browser = webdriver.Firefox()

browser.get('http://192.168.1.13:49154')
assert 'My Title' in browser.title



elem = browser.find_element_by_class_name('entry-title')  
assert 'HELLO WORLD!' in elem.text

browser.get('http://192.168.1.13:49154/?page_id=2')
elem = browser.find_element_by_class_name('entry-content') 
assert 'The XYZ Doohickey' in elem.text


elem = browser.find_element_by_id('author') 
elem.send_keys('Pini Reznik')
elem = browser.find_element_by_id('email') 
elem.send_keys('p.reznik@uglyduckling.nl')
elem = browser.find_element_by_id('comment') 
elem.send_keys(sys.argv[1:] )
elem = browser.find_element_by_id('url')   
elem.send_keys('continuousdelivery.uglyduckling.nl' + Keys.RETURN)

elem = browser.find_element_by_class_name('comment-awaiting-moderation') 
print elem.text
assert 'Your comment is awaiting moderation' in elem.text



browser.quit()
