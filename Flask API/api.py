import requests
import json

url = "https://m.bibleresources.info/webservices/cr/sermons_new.php?os=apple?language=ENG"
headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"}

def get_sermons_from_endpoint():
    response = requests.get(url, headers=headers)
    data = json.loads(response.text)
    return data