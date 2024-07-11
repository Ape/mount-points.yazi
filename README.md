# mount-points.yazi

This is a Yazi plugin for showing mount point information.

## Warning

This plugin is early in development and has currently serious performance
drawbacks. The problem is that the mount point information is queried every
time you even hover a different file.

## Dependencies

This plugin required the `findmnt` command that is provided by `util-linux`.

## Installation

Install the plugin:

```
ya pack -a Ape/mount-points
```

Create `~/.config/yazi/init.lua` and add:

```
require("mount-points"):setup()
```
