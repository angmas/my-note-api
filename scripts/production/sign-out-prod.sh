#!/bin/bash

curl --include --request DELETE https://mynoteapi.herokuapp.com/sign-out/1 \
--header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN"
