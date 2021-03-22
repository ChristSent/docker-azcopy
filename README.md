# Sync via AzCopy on Docker

## Usage

### Sync data between Local/AZBlob or AZBlob/AZBlob

Specify SOURCE and DEST as environment variables.

version: '2'
services:
  azcopy:
    image: christsent/docker-azcopy-sync	
    environment:
      SOURCE: </path/to/local> OR <https://storage-account-name.blob.core.windows.net/container-name>
      DEST: </path/to/local> OR <https://storage-account-name.blob.core.windows.net/container-name>
    volumes:
      - /data/on/server:/path/to/local
