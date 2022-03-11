FROM myoung34/github-runner:latest
COPY check_jobs.sh /
COPY entrypoint.sh /

RUN chmod +x /check_jobs.sh /entrypoint.sh

CMD ["/actions-runner/bin/Runner.Listener", "run"]