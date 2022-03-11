#!/bin/bash
# Check jobs acceptance timeout.
# If jobs cannot be confirmed, listening will be terminated.

_RUNNER_WORKDIR=${RUNNER_WORKDIR:-/_work}
_JOBS_ACCEPTANCE_TIMEOUT=${JOBS_ACCEPTANCE_TIMEOUT:-300}
sleep ${_JOBS_ACCEPTANCE_TIMEOUT}

if [ ! -e "${_RUNNER_WORKDIR}/_temp" ]; then
  echo Stop listening due to timeout.
  pkill --signal=SIGINT -f /actions-runner/bin/Runner.Listener
  exit 1
fi

echo Confirmed the acceptance of jobs.
exit 0
