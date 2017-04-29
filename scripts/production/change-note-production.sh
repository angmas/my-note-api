#!/bin/bash

API="https://mynoteapi.herokuapp.com"
URL_PATH="/notes"
curl "${API}${URL_PATH}/${ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "note": {
      "note_detail": "'"${ND}"'"
    }
  }'

echo
