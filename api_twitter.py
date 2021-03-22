from rauth import OAuth1Service
import json
from pathlib import Path  
from dotenv import load_dotenv
import os
env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)

# Autenticação com a API
try:
    read_input = raw_input
except NameError:
    read_input = input    


twitter = OAuth1Service (
    name = 'twitter',
    consumer_key =  os.getenv("consumer_key"),
    consumer_secret = os.getenv('consumer_secret'),
    request_token_url='https://api.twitter.com/oauth/request_token', 
    access_token_url='https://api.twitter.com/oauth/access_token',
    authorize_url='https://api.twitter.com/oauth/authorize', 
    base_url='https://api.twitter.com/1.1/' 
)

request_token, request_token_secret = twitter.get_request_token()

authorize_url = twitter.get_authorize_url(request_token)

print("Cole link: {url}".format(url=authorize_url))

pin = read_input('Digite o PIN')

session = twitter.get_auth_session(request_token,request_token_secret,method='POST',data={'oauth_verifier':pin})

# Exemplo de busca de tweets

params = {'q':'lockdown',
            }

r = session.get('search/tweets.json',params=params, verify=True)

for i, tweets in enumerate(r.json()['statuses'],1):
    data_hora = tweets['created_at'],
    user_name = tweets['user']['screen_name']
    rt = tweets['retweet_count']
    text = tweets['text']
    print('@{0} - RT: {1} - {2}'.format(user_name,rt,text))
    

