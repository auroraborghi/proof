from typing import Any, Dict

import uvicorn
import yaml
from proof.api import app


def parse_yaml(file_name: str) -> Dict[str, Any]:
    """
    Parses specified yaml config file.

    :param file_name: Name of yaml file to parse.
    :return: Content of the yaml file as a python dictionary.
    """
    with open(file_name, encoding='utf-8') as stream:
        config = yaml.load(stream, Loader=yaml.FullLoader)

    return config


if __name__ == '__main__':
    api_config = parse_yaml('config/api.yaml')
    uvicorn.run(app, host=api_config['host'], port=api_config['port'])
