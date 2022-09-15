import os
import json
from fastavro import writer
from fastavro import parse_schema


class StorageException(Exception):
    pass


def save_to_disk(json_content, path):
    schema = {
        "doc": "Data pumping job",
        "name": "json2avro",
        "namespace": "com.dwh.landing_zone",
        "type": "record",
        "fields": [
            {"name": "client", "type": "string", "default": "null"},
            {"name": "purchase_date", "type": "string", "default": "null"},
            {"name": "product", "type": "string", "default": "null"},
            {"name": "price", "type": "float", "default": -1},
        ],
    }
    parsed_schema = parse_schema(schema)
    workdir = os.path.expanduser(
        '~/PycharmProjects/parser/web_api'
        )
#    reading_path = os.path.join(workdir, json_content.lstrip("/"))
    reading_path = '/Users/gaol1002/PycharmProjects/parser/web_api'
#    storing_path = os.path.join(workdir, path.lstrip("/"))
    storing_path = '/Users/gaol1002/PycharmProjects/parser/web_api'

    incoming_files = os.listdir(reading_path)
    print(incoming_files)
    if os.path.exists(reading_path):
        incoming_files = os.listdir(reading_path)
        print(incoming_files)

    for in_file in incoming_files:
        out_file = os.path.splitext(in_file)[0] + ".avro"
        try:
            with open(os.path.join(reading_path, in_file), "r") as fh:
                json_data = json.load(fh)

            with open(os.path.join(storing_path, out_file), "wb") as fh:
                writer(fh, parsed_schema, json_data)
        except Exception as e:
            raise StorageException(f"Failed to process file {in_file}. {e}")

