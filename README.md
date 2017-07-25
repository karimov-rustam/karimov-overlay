# How to use this overlay

## with local overlays

[Local overlays](https://wiki.gentoo.org/wiki/Overlay/Local_overlay) should be managed via `/etc/portage/repos.conf/`.
To enable this overlay make sure you are using a recent Portage version (at least `2.2.14`), and create a `/etc/portage/repos.conf/karimov-overlay.conf` file containing precisely:

```
[karimov-overlay]
location = /usr/local/portage/karimov-overlay
sync-type = git
sync-uri = https://github.com/karimov-rustam/karimov-overlay.git
priority=9999
```

Afterwards, simply run `emerge --sync`, and Portage should seamlessly make all our ebuilds available.
