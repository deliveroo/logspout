FROM deliveroo/hopper-runner:1.0.3 as hopper-runner
FROM alpine:3.5

COPY --from=hopper-runner /hopper-runner /usr/bin/hopper-runner
VOLUME /mnt/routes
EXPOSE 80

COPY . /src
RUN cd /src && ./build.sh "$(cat VERSION)"

ENTRYPOINT ["hopper-runner"]
CMD ["sh -c '/bin/logspout $LOGS_DESTINATION'"]
