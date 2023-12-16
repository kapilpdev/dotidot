# README

* Ruby version
  - 3.2.2

* Rails version
  - 7.0.8

* Run bundle
  - bundle install

* Database creation
  - rails db:create
  - rails db:migrate

* Run project
  - rails s

* How to run the test suite
  - rspec

* Use in postman for create data
  - url = localhost:3000/scrapers/data
  - body
        {
          "url": "https://www.amazon.in/Stardust-Storage-Display-Triple-Camera/dp/B0CMTTRN8M/?th=1",
          "fields": {
              "price": ".a-price-whole",
              "title": ".product-title-word-break"
              // "meta": ["encrypted-slate-token", "description"]
          }
        }

  - body for meta tag
        {
          "url": "https://www.amazon.in/Stardust-Storage-Display-Triple-Camera/dp/B0CMTTRN8M/?th=1",
          "fields": {
              "meta": ["encrypted-slate-token", "description"]
          }
        }