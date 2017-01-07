# Room

[![Build Status][travis_badge]][travis]

This is a Debian container packed with much bitwise surgical kapow for you to operate with.

Currently works with `docker-machine` only.

## Usage

Change your current host working directory to the path of interest. Use the Force:

```
$ room
```

By default, you start in a ZSH prompt. Additionally, you can provide commands that will be passed to the container:

```
$ room npm install
```

## Installation

To make available system-wide Install in your host environment via `curl`:

```
curl -sL https://git.io/v69Xg | sh -
```

Alternatively, you clone the repository and run [`room.sh`](room.sh) directly:

```
git clone https://github.com/langri-sha/room.git
./room/room.sh
```

## Thanks!

If you sift through the list of goodies and feel like it's missing some :lollipop: pizzazz, please throw me a PR. I :heart: adding shiny new tools to the collection!

[travis_badge]: https://travis-ci.org/langri-sha/room.svg?branch=master
[travis]: https://travis-ci.org/langri-sha/room
[room.sh]: https://raw.githubusercontent.com/langri-sha/room/master/room.sh
