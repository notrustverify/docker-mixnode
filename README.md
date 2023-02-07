# docker-mixnode


## Environments parameters

| Name | Default | Description |
|------|---------|-------------|
| `NAME_MIXNODE` | Mandatory | mixnode id |
| `ANNOUNCE_HOST`| public ip | announce host used by validator to detect the mixnode |
| `FORCE_INIT`   | `false` | force a new init of the mixnode |


## Update the image

Create a new release for example to build image with nym-binaries 1.1.6 create a tag and release called `v1.1.6` and then the [github action](.github/workflows/docker-image.yml) will be automatically build (take some time)

Check [here](https://github.com/nymtech/nym/releases) for the actual Nym release
