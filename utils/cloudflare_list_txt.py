import json
from pprint import pprint
import zoneinfo
import requests
import json

with open("creds.json") as f:
    creds = json.loads(f.read())

url = "https://api.cloudflare.com/client/v4/zones/{}/dns_records?type=TXT&name=".format(creds.get("zone_id"))
headers = {
    "X-Auth-Email": creds.get("email"),
    "X-Auth-Key": creds.get("api_key"),
    "Content-Type": "application/json",
}

resp = requests.get(url, headers=headers)

print(resp.status_code)
pprint(json.loads(resp.text))