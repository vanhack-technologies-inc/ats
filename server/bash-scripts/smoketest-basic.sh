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
TESTS_PASSED_SUM=0
TESTS_PASSED_LIST=
TESTS_REPROVED_SUM=0
TESTS_REPROVED_LIST=

function rejected () {
  TESTS_REPROVED_LIST="$TESTS_REPROVED_LIST:$1"
  TESTS_REPROVED_SUM=$(( $(echo $TESTS_REPROVED_LIST | tr ':' '\n' | wc -l ) -1 ))
  echo "NOK. TEST $1 rejected.  Exiting..." && echo_resume && exit 1
}

function rejected_bypassed () {
  TESTS_REPROVED_LIST="$TESTS_REPROVED_LIST:$1"
  TESTS_REPROVED_SUM=$(( $(echo $TESTS_REPROVED_LIST | tr ':' '\n' | wc -l ) -1 ))
  echo "NOT PASSED:  $1 - This error was bypassed to move to next test"
}

function checked () {
  TESTS_PASSED_LIST="$TESTS_PASSED_LIST:$1"
  TESTS_PASSED_SUM=$(( $(echo $TESTS_PASSED_LIST | tr ':' '\n' | wc -l ) -1 ))
  echo "--- $1 Checked"
}

function echo_resume {

  echo "########### Test Resume"
  echo "### Tests approved: $TESTS_PASSED_SUM"
  echo "### Tests reproved: $TESTS_REPROVED_SUM"
  echo "### Total of tests executed: $(( $TESTS_REPROVED_SUM + $TESTS_PASSED_SUM ))"
  echo "--------"
  echo "-- test details"
  echo "--------"

  echo "### Test cases reproved list: "
  for test in $( echo $TESTS_REPROVED_LIST | tr ':' '\n' )
  do
    echo "    x $test"
  done

  echo "### Test cases approved list: "
  for test in $( echo $TESTS_PASSED_LIST | tr ':' '\n' )
  do
    echo "    - $test"
  done

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
### Application tests - starts with 3????
###########

function 3001_applicationlist_return_any_json {
  TEST_CODE="3001"
  TEST_DESCRIPTION="List any json list (even empty) from Application controller"
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

3001_applicationlist_return_any_json

###########
### Print test resume  
###########
echo_resume
