# Room

This is a Debian container packed with much bitwise surgical kapow for you to
operate with.

## Installation

Install
[`room/run.sh`](https://raw.githubusercontent.com/langri-sha/room/master/run.sh)
in your host environment via `curl`:

```
curl -L https://git.io/vuEqk -o /usr/local/bin/room
chmod +x /usr/local/bin/room
```

Run `sudo -i` first on permission denied errors.

## Usage

Change your current host working directory to the path of interest. Use the
Force:

```
$ room
```

By default, you start in a ZSH prompt. Additionally, you can provide commands
that will be passed to the container:

```
$ room npm install
```

## Thanks!

If you sift through the list of goodies and feel like it's missing some
:lollipop: pizzazz, please throw me a PR. I :heart: adding shiny new tools to
the collection!
