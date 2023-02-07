# docker-mixnode

## How to run

1. Create a `docker-compose.yml` file and replace `WALLET_ADDRESS` with correct value. Check other environment variable [here](README.md#environments-parameters)
```yaml
version: '3'

services:

  nym-mixnode:
    build: .
    restart: unless-stopped
    environment:
      - WALLET_ADDRESS=<YOUR WALLET ADDRESS>
    volumes:
       - ./nym-data/:/home/user/.nym/
    ports:
      - 1789:1789
      - 1790:1790
      - 8000:8000

```

2. **Change the permissions of the nym-data folder `chown -R 10000:10000 nym-data`**

## Environments parameters

| Name | Default | Description |
|------|---------|-------------|
| `WALLET_ADDRESS` | **Mandatory** | wallet address used to bound the mixnode |
| `NAME_MIXNODE` | `docker-mixnode` | mixnode id |
| `ANNOUNCE_HOST`| public ip | announce host used by validator to detect the mixnode |
| `FORCE_INIT`   | `false` | force a new init of the mixnode |


## Update the image

Create a new release for example to build image with nym-binaries 1.1.6 create a tag and release called `v1.1.6` and then the [github action](.github/workflows/docker-image.yml) will be automatically build (take some time)

Check [here](https://github.com/nymtech/nym/releases) for the actual Nym release
