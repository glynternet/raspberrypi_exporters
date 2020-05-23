#!/bin/bash

install-service-files() {
	local apps="${1:?must provide apps}"
	for app in $apps; do
		local appService="./$app/$app.service"
		if [[ ! -f "$appService" ]]; then
			echo "Skipping service install: No service for app:$app."
			continue
		fi
		sudo mv -v "$appService" /etc/systemd/system/;
	done
}

install-timer-files() {
	local apps="${1:?must provide apps}"
	for app in $apps; do
		local appTimer="./$app/$app.timer"
		if [[ ! -f "$appTimer" ]]; then
			echo "Skipping timer install: No timer for app:$app."
			continue
		fi
		sudo mv -v "$appTimer" /etc/systemd/system/;
	done
}

enable-services() {
	local apps="${1:?must provide apps}"
	for app in $apps; do
		echo "Enabling $app"
		sudo systemctl enable "$app";
	done
}

apps="$(find * -maxdepth 0 -type d | tr '\n' ' ')"
echo "Apps to install: $apps"
install-service-files "$apps"
install-timer-files "$apps"
sudo systemctl daemon-reload
enable-services "$apps"
