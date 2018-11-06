#!/usr/bin/env bash

PROTOCOL="http"
HOST="localhost"
PORT="5000"
### Reusable variable
VERB=
API=

###########
### Reusable behaviors
###########
function rejected () {
  echo "NOK. TEST $1 rejected.  Exiting..." && exit 1
}


function checked () {
  echo "--- $1 Checked"
}

###########
### Swagger tests - starts with 0????
###########
function 0001_up_n_running {
  TEST_CODE="0001"
  TEST_DESCRIPTION="Check if swagger is UP and RUNNING"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="GET"
  API=""
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "
  [[ $( curl  -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "<!-- HTML for static distribution bundle build -->" -c ) == "0" ]] && rejected $TEST_CODE 
 
  checked $TEST_CODE
}


###########
### Candidate tests - starts with 1????
###########

function 1001_candidatelist_return_any_json {
  TEST_CODE="1001"
  TEST_DESCRIPTION="List any json list (even empty) from Candidate controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="GET"
  API="api/Candidate/list"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "^\[.*]$" -c ) -gt 0 ]] || rejected $TEST_CODE 
  
  checked $TEST_CODE
}


###########
### Job tests - starts with 2????
###########

function 2001_joblist_return_any_json {
  TEST_CODE="2001"
  TEST_DESCRIPTION="List any json list (even empty) from Job controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="GET"
  API="api/Job/list"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "^\[.*]$" -c ) -gt 0 ]] || rejected $TEST_CODE 
  
  checked $TEST_CODE
}


###########
###########
###########
###########

###########
### Tests orchestration 
###########
0001_up_n_running

1001_candidatelist_return_any_json

2001_joblist_return_any_json



