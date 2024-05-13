import requests
import time

target_server = "http://load_balancer:80/"

while True:
    try:
        r = requests.get(target_server)
        response = {
            "status_code": r.status_code,
            "body": r.text
        }
        print(response)
    except:
        print(f"FAILED TO REACH {target_server}")
    time.sleep(.05)