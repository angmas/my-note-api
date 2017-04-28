#!/bin/bash
# NT=note1 ND='this is a note' FAV=false UID=1 TOKEN= sh scripts/create-note.sh
API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/notes"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "note": {
      "note_title": "'"${NT}"'",
      "note_detail": "'"${ND}"'",
      "favorite": "'"${FAV}"'",
      "user_id": "'"${UID}"'"
    }
  }'

echo
