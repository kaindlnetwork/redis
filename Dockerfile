FROM redis:7.2.4-alpine3.19

# Add Healthcheck
LABEL org.opencontainers.image.description This is the mautrix-whatapp Container Image provided by Kaindl Network with added Healthcheck and higher security
LABEL org.opencontainers.image.authors Fabian Kaindl container@kaindlnetwork.de
LABEL org.opencontainers.image.source	https://github.com/kgncloud/mautrix-whatsapp/
LABEL org.opencontainers.image.documentation https://github.com/kgncloud/mautrix-whatsapp/
LABEL org.opencontainers.image.vendor Kaindl Network

HEALTHCHECK --interval=30s --timeout=3s --retries=5 --start-period=10s \
  CMD redis-cli ping
  
RUN apk -U upgrade && \

# Remove not needed packages to make it distroless
# iputils = ping command and co
# apk-tools alpine-tools alpine-keys libc-utils -> remove apk command
# Nobudy should be able to install software inside an image!!!
# bash = We dont need a shell inside a production container
# Curl is needed for healthcheck and is a dependency from the application!
# Bash is a Dependency of the Application Developer but should not be in the production enviroment -> Could be blacklisted from the removal list

apk del iputils apk-tools alpine-keys libc-utils wget
