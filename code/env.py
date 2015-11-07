# pip install python-dotenv // https://github.com/theskumar/python-dotenv

from dotenv import parse_dotenv

ENV = {item[0]: item[1] for item in parse_dotenv('.env')}
