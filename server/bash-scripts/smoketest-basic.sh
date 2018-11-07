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

function 1001_list_candidates {
  TEST_CODE="1001"
  TEST_DESCRIPTION="List any json list (even empty) through Candidate's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="GET"
  API="api/Candidate/list"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "^\[.*]$" -c ) -gt 0 ]] || rejected $TEST_CODE 
  
  checked $TEST_CODE
}

function 1002_create_candidate_somebody {
  TEST_CODE="1002"
  TEST_DESCRIPTION="Create user 'somebody' through Candidate's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="POST"
  API="api/Candidate/save"
  curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API"  -H "accept: application/json" -H "Content-Type: text/json" -d "{ \"username\": \"somebody\", \"email\": \"somebody@email.net\", \"name\": \"somebody added as Candidate\", \"verified\": true}" 
  
  VERB="GET"
  API="api/Candidate/get/somebody"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "somebody@email.net" -c ) -gt 0 ]] || rejected_bypassed $TEST_CODE 
 
  checked $TEST_CODE
}

function 1003_look_for_candidate_somebody {
  TEST_CODE="1003"
  TEST_DESCRIPTION="List any json list (even empty) through Candidate's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="GET"
  API="api/Candidate/get/somebody"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "somebody@email.net" -c ) -gt 0 ]] || rejected $TEST_CODE 
  
  checked $TEST_CODE
}

function 1004_remove_candidate_somebody {
  TEST_CODE="1004"
  TEST_DESCRIPTION="Delete somebody through Candidate's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="DELETE"
  API="api/Candidate/remove/somebody"
  curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API"
  
  VERB="GET"
  API="api/Candidate/get/somebody"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "somebody@email.net" -c ) -ne 0 ]] && rejected_bypassed $TEST_CODE 
  
  checked $TEST_CODE
}

###########
### Job tests - starts with 2????
###########

function 2001_list_jobs {
  TEST_CODE="2001"
  TEST_DESCRIPTION="List any json list (even empty) through Job's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="GET"
  API="api/Job/list"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "^\[.*]$" -c ) -gt 0 ]] || rejected $TEST_CODE 
  
  checked $TEST_CODE
}

function 2002_create_job_someposition {
  TEST_CODE="2002"
  TEST_DESCRIPTION="Create job 'someposition' through Job's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="POST"
  API="api/Job/save"
  curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"id\": 333, \"name\": \"someposition\", \"description\": \"A generic Position for test propose\", \"company\": \"Arcadia\", \"recruiter\": \"VeryGoodOne\", \"open\": true}"
  
  VERB="GET"
  API="api/Job/get/333"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "someposition" -c ) -eq 0 ]] && rejected_bypassed $TEST_CODE 
 
  checked $TEST_CODE
}


function 2003_look_for_job_333_someposition {
  TEST_CODE="2003"
  TEST_DESCRIPTION="Create job 'someposition' through Job's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="GET"
  API="api/Job/get/333"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "someposition" -c ) -eq 0 ]] && rejected $TEST_CODE 
 
  checked $TEST_CODE
}

function 2004_remove_job_application_to_333_someposition_of_somebody {
  TEST_CODE="2004"
  TEST_DESCRIPTION="Delete someposition through Job's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="DELETE"
  API="api/Job/remove/333"
  curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API"
  
  VERB="GET"
  API="api/Job/get/333"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "someposition" -c ) -eq 0 ]] || rejected_bypassed $TEST_CODE 
  
  checked $TEST_CODE
}


###########
### Application tests - starts with 3????
###########

function 3001_list_applications {
  TEST_CODE="3001"
  TEST_DESCRIPTION="List any json list (even empty) through Application's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="GET"
  API="api/Application/list"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "^\[.*]$" -c ) -gt 0 ]] || rejected $TEST_CODE 
  
  checked $TEST_CODE
}

function 3002_set_application_for_somebody_candidate_to_333_job {
  TEST_CODE="3002"
  TEST_DESCRIPTION="Create Application for 'someposition' to 333 job through Application's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "

  VERB="POST"
  API="api/Application/save"
  curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" -H "accept: application/json" -H "Content-Type: text/json" -d "{ \"jobId\": 333, \"username\": \"somebody\", \"status\": \"applied\"}"

  VERB="GET"
  API="api/Application/get/333/somebody"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "applied" -c ) -eq 0 ]] && rejected_bypassed $TEST_CODE 
 
  checked $TEST_CODE
}

function 3003_look_application_for_somebody_candidate_to_333_job {
  TEST_CODE="3003"
  TEST_DESCRIPTION="Look for Application for 'someposition' to 333 job through Application's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "
  
  VERB="GET"
  API="api/Application/get/333/somebody"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "applied" -c ) -eq 0 ]] && rejected $TEST_CODE 
 
  checked $TEST_CODE
}


function 3004_remove_application_for_somebody_candidate_to_333_job {
  TEST_CODE="3004"
  TEST_DESCRIPTION="Remove Application for 'someposition' to 333 job through Application's controller"
  echo "--- $TEST_CODE - $TEST_DESCRIPTION "
  
  VERB="DELETE"
  API="api/Application/remove/333/somebody"
  curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API"
  
  VERB="GET"
  API="api/Application/get/333/somebody"
  [[ $( curl -X $VERB -s "$PROTOCOL://$HOST:$PORT/$API" | grep "applied" -c ) -ne 0 ]] && rejected_bypassed $TEST_CODE 
 
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

1001_list_candidates
1002_create_candidate_somebody
1003_look_for_candidate_somebody
1001_list_candidates

2001_list_jobs
2002_create_job_someposition
2003_look_for_job_333_someposition
2001_list_jobs

3001_list_applications
3002_set_application_for_somebody_candidate_to_333_job
3003_look_application_for_somebody_candidate_to_333_job

###########
### Tear Down
###########

3004_remove_application_for_somebody_candidate_to_333_job
1004_remove_candidate_somebody
2004_remove_job_application_to_333_someposition_of_somebody

###########
### Print test resume  
###########
echo_resume
