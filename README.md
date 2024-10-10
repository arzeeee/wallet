# README

## Requirements
- Ruby 3.3.0
- Rails 7.2.1

## How to Run

Clone the repository

`git clone https://github.com/arzeeee/wallet.git`

Get inside the directory

`cd wallet`

Install all gemfile

`bundle install`

Make a new `.env` file containing these lines

```
PROD_DATABASE=storage/production.sqlite3
RAPIDAPI_KEY=52b451c1dfmsh89eaa6e00e7b079p108731jsn33feba9ad3b7
RAPIDAPI_HOST=latest-stock-price.p.rapidapi.com
RAPIDAPI_BASE_URL=https://latest-stock-price.p.rapidapi.com/
```

Start server

`rails s`

Then access `localhost:3000` from your browser