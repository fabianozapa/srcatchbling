# Problem:
Our new company, called "srcatchbling" (SB) was formed to sell the world’s fanciest back scratchers. SB would like to have customers and other clients access an API to list all of the back scratchers that they are selling on the market. In order to complete this, you, the developer, must create a simple RESTful interface that will provide access to the company’s
database.

A simple example of a back scratcher for sale is:
```
Name              Description                       Size                Price
"The Itcher"      "Scratch any itch"                ["XL"]              "$27.00"
"The Blinger"     "Diamonds"                        ["L"]               "$343.00"
"Glitz and Gold"  "Gold handle and fancy emeralds"  ["XL","L","M","S"]  "$4,343.00"
```
# Deliverables:
Software Deliverable
```
1. Working API - Should send links to a proper RESTful API.
    ● Create
    ● Read
    ● Update
    ● Destroy
2. Export basic rest calls from the Postman tool so the calls can be tested
3. Screenshots of rest call results
4. Deployment of API to AWS
5. Provide a link to the deployed AWS server
```

Extra Credit:
```
1. Enable token API access
2. User interface to visualize items
3. Admin panel with login credentials provided
```

# Tests:
```
rspec -f d
```

# CURL TESTS:
INDEX:
```
curl --location --request GET 'http://srcatchbling-1174557878.us-east-1.elb.amazonaws.com/api/v1/backscratchers' \
--header 'token: 01e014cb-1fb3-4189-93a3-b163e11f92d4'
```

CREATE:
```
curl --location --request POST 'http://srcatchbling-1174557878.us-east-1.elb.amazonaws.com/api/v1/backscratchers' \
--header 'token: 01e014cb-1fb3-4189-93a3-b163e11f92d4' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "The Itcher NEW",
    "description": "Scratch any itch NEW",
    "price": "$50.0",
    "sizes": ["S", "M"]
}'
```

UPDATE:
```
curl --location --request PUT 'http://srcatchbling-1174557878.us-east-1.elb.amazonaws.com/api/v1/backscratchers/4' \
--header 'token: 01e014cb-1fb3-4189-93a3-b163e11f92d4' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "The Itcher UPDATED",
    "description": "Scratch any itch UPDATED",
    "price": "$60.0",
    "sizes": ["S", "L"]
}'
```

DELETE:
```
curl --location --request DELETE 'http://srcatchbling-1174557878.us-east-1.elb.amazonaws.com/api/v1/backscratchers/4' \
--header 'token: 01e014cb-1fb3-4189-93a3-b163e11f92d4'
```

# POSTMAN TESTS:
http://srcatchbling-1174557878.us-east-1.elb.amazonaws.com/tests/srcatchbling.postman_collection.json
