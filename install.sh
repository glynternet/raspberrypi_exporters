#!/bin/bash

install-service-files() {
	local apps="${1:?must provide apps}"
	for app in $apps; do sudo mv -v "./$app/$app.service" /etc/systemd/system/; done
}

enable-services() {
	local apps="${1:?must provide apps}"
	for app in $apps; do sudo systemctl enable "$app"; done
}

apps="$(find * -maxdepth 0 -type d | tr '\n' ' ')"
echo "Apps to install: $apps"
install-service-files "$apps"
sudo systemctl daemon-reload
enable-services "$apps"
