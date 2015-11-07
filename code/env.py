# pip install python-dotenv // https://github.com/theskumar/python-dotenv
#
# example `.env` file:
#
#     USER=lynn
#     PASS=XXXXXXXXXXXXXX
#     SECRET_KEY=XXXXXXXXXXXXXXXXXXXXXXXX

from dotenv import parse_dotenv, load_dotenv

# write to os.environ
#
# import os
# os.environ['USER']
load_dotenv('.env')

# write to ENV object
#
# from env import ENV
# ENV['USER']
ENV = {item[0]: item[1] for item in parse_dotenv('.env')}
