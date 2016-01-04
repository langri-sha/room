# Room

This is a Debian container packed with much developer pow.

```
sudo docker run \
  --volume=$(pwd):/work:rw \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  -it room
```

# TODO

- [ ] Document configuration options
