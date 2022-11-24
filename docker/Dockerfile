FROM myoung34/github-runner:latest
COPY check_jobs.sh /

RUN sed -e "s/\(# Container's command (CMD) execution as runner user\)/if [[ -n \"\${JOBS_ACCEPTANCE_TIMEOUT}\" ]]; then \/check_jobs.sh \"\${JOBS_ACCEPTANCE_TIMEOUT}\" \& fi\n\1/g" /entrypoint.sh > /entrypoint2.sh
RUN mv /entrypoint.sh /entrypoint.sh.bak
RUN mv /entrypoint2.sh /entrypoint.sh
RUN chmod +x /check_jobs.sh /entrypoint.sh
