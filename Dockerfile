FROM redactics/postexport-base:1.0.0

FROM amazon/aws-cli:2.4.2
COPY --from=0 /bin/agent-filestreamer /bin/agent-filestreamer
COPY upload-to-s3.sh /bin/upload-to-s3
ENTRYPOINT ["/bin/upload-to-s3"]