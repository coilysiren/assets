# $ pip install python-dotenv
# repo: https://github.com/theskumar/python-dotenv
#
# Use with a `.env` file (added to .gitignore!!!) in the
# same directory. Example .env file:
#
#     USER=lynn
#     PASS=XXXXXXXXXXXXXX
#     SECRET_KEY=XXXXXXXXXXXXXXXXXXXXXXXX

from dotenv import load_dotenv
from os import environ as ENV

load_dotenv('.env')
ENV['USER'] == 'lynn'
