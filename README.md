# pi-steup

My simple [Raspberry Pi] setup for a simple home server running various
services like [Pi-hole] and network-attached storage.

<img src="/docs/images/pi-unboxing.jpg" alt="Raspbery Pi 4 Unboxing" width="500">

## Architecture

Keeping things simple by managing most services via Docker containers that are
spun up and down by `systemd`. For a given service, the basic directory
structure is as such:

### Service Directory Structure

```
pi-setup
└── example-service
    ├── .env
    ├── .gitignore
    ├── docker-compose-example-service.service
    ├── docker-compose.yml
    └── <various config and data directories>
```

#### `.env`

Environment-variable configuration for injecting instance-specific configu
values and secrets maypped into the container via `docker-compose`. This should
be gitignored.

#### `.gitignore`

Git ignore rules specific to the given service.

####  `docker-compose-example-service.service`

The `systemd` service unit that declares how the service should be managed via
`systemd`. Registered with `systemctl`. For example:

```config
# docker-compose-example-service.service
[Unit]
Description=An example service managed by docker-compose
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/pi/pi-setup/example-service
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

```bash
pushd example-service
sudo systemctl enable "$PWD/docker-compose-example-service.service"
popd
```

####  `docker-compose.yml`

The configuration file for telling `docker-compose` how to run the container.
See [the Docker Compose docs][dcd] for more information.

## Getting Started

For now to keep things simple, I recommend just rolling with [Raspbian Lite]
for your OS and setting up some initial dependencies via [`deps.sh`](/deps.sh).
Then, to install the various services and get them up and running, run `make
install`.

[Raspberry Pi]: https://www.raspberrypi.org
[Pi-hole]: https://pi-hole.net
[dcd]: https://docs.docker.com/compose/
[Raspbian Lite]: https://www.raspberrypi.org/downloads/raspbian/
