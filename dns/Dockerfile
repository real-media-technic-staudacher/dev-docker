FROM alpine:3.17

RUN apk add --no-cache dnsmasq
RUN echo $PROXYTLD
EXPOSE 53/tcp
EXPOSE 53/udp
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["dnsmasq", "-k"]