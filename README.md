# README

First post to http://localhost:3000/auth/login to get an auth token. Use email and password in the body with headers Content-Type application/json and Accept application/json.
{
  "email":"example@place.com",
  "password":"SuperHardToGuessPassword"
}

Use the token in the response in the header of all the following requests as Authorization. 
