#!/bin/bash

API="https://mynoteapi.herokuapp.com"
URL_PATH="/notes"
curl "${API}${URL_PATH}/${ID}" \
  --include \
  --request DELETE \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN"

echo
