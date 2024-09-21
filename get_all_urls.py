import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin

def get_all_urls(base_url):
    urls = set()
    response = requests.get(base_url)
    soup = BeautifulSoup(response.text, 'html.parser')
    
    for link in soup.find_all('a', href=True):
        url = urljoin(base_url, link['href'])
        if base_url in url:
            urls.add(url)
    
    return urls