```
docker run --rm -ti \
    -e REMOTE_ADDR=example.com:1234
    -p 3333:1111
    --cap-add=NET_ADMIN
    --device=/dev/ppp
    -e OC_PASSWORD=supersecret
    calidae/anyconnect
    vpn.example.com:443
    --user=janedoe
    --servercert pin-sha256:Ade//Wf45D7vHit6PGrdEUHuNKG4nXowPbd4BQoIt2U
```