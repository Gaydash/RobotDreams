import os
import requests
import json


AUTH_TOKEN = '2b8d97ce57d401abd89f45b0079d8790edd940e6'


def main():

    for i in range(1, 5):
        response = requests.get(
            url=f'https://fake-api-vycpfa6oca-uc.a.run.app/sales?date=2022-08-09&page={i}',
            headers={'Authorization': AUTH_TOKEN}
        )

        data = response.json()

        with open(f'data_file{i}.json', 'w', encoding='utf-8') as file:
            json.dump(data, file, indent=2, ensure_ascii=False)



if __name__ == '__main__':
    main()