FROM ghcr.io/epicgames/unreal-engine:5.5 AS builder

# Copy project files
COPY . /project
WORKDIR /project

# Build dedicated server
RUN ./Engine/Build/BatchFiles/RunUAT.sh BuildCookRun \
    -project=/project/MyGame.uproject \
    -noP4 -platform=Linux \
    -server -cook -build -stage -pak -archive \
    -archivedirectory=/output

FROM ubuntu:22.04
WORKDIR /app

# Copy built binaries from builder
COPY --from=builder /output /app

EXPOSE 7777/udp
EXPOSE 8080
HEALTHCHECK CMD curl --fail http://localhost:8080/healthz || exit 1
CMD ["/app/LinuxServer/MyGameServer.sh"]
