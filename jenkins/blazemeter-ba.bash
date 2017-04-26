#!/bin/bash

export BZA=https://a.blazemeter.com
export TEST_ID="5597665"
export USER="d8b2950468ff21a4df902f3f:6da71a14ebdc612cb7405eac184c9958d1f6d8c384e82e0fe8811c352a06f5fa0ff3a6e1"

echo "Running test on " $BZA
echo "Test ID = " $TEST_ID

SESSION_ID=$(curl --silent --insecure --user ${USER} ${BZA}/api/latest/tests/${TEST_ID}/start |  python -c 'import sys, json; print json.load(sys.stdin)["result"]["sessionsId"]' | tr -d \'[u])
echo "Test started .."

TEST_RUN_STATUS=$(curl --silent --insecure --user ${USER} ${BZA}/api/latest/sessions/${SESSION_ID} | python -c 'import sys, json; print json.load(sys.stdin)["result"]["status"]' | tr -d \'[u] )

while [ "$TEST_RUN_STATUS" != "ENDED" ]; do
        echo "Test status = " $TEST_RUN_STATUS
        echo "Report is visible here: ${BZA}/app/#reports/${SESSION_ID}/loadreport"
        sleep 30
	TEST_RUN_STATUS=$(curl --silent --insecure --user ${USER} ${BZA}/api/latest/sessions/${SESSION_ID} | python -c 'import sys, json; print json.load(sys.stdin)["result"]["status"]' | tr -d \'[u]  )
done


echo "Test status = " $TEST_RUN_STATUS
echo "Now fetching test's report (junit.xml)"

$(curl --silent --insecure --user ${USER} ${BZA}/api/latest/sessions/${SESSION_ID}/reports/thresholds/data?format=junit > $(pwd)/${SESSION_ID}.xml)

echo "Test has ended with status: $TEST_RUN_STATUS"
echo "Report is available here: ${BZA}/app/#reports/${SESSION_ID}/loadreport"
