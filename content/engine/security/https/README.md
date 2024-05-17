---
_build:
  list: never
  publishResources: false
  render: never
---

This is an initial attempt to make it easier to test the TLS (HTTPS) examples in the protect-access.md
doc.

At this point, it is a manual thing, and I've been running it in boot2iechor.

My process is as following:

    $ boot2iechor ssh
    root@boot2iechor:/# git clone https://github.com/moby/moby
    root@boot2iechor:/# cd iechor/docs/articles/https
    root@boot2iechor:/# make cert

lots of things to see and manually answer, as openssl wants to be interactive

> **Note**: make sure you enter the hostname (`boot2iechor` in my case) when prompted for `Computer Name`)

    root@boot2iechor:/# sudo make run

Start another terminal:

    $ boot2iechor ssh
    root@boot2iechor:/# cd iechor/docs/articles/https
    root@boot2iechor:/# make client

The last connects first with `--tls` and then with `--tlsverify`, both should succeed.
