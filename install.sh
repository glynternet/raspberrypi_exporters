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
		if [[ -f "/etc/systemd/system/$app.timer" ]]; then
			local systemUnit="$app.timer"
		else
			local systemUnit="$app.service"
		fi
		echo "Enabling $systemUnit"
		sudo systemctl enable "$systemUnit";
	done
}

start-services() {
	local apps="${1:?must provide apps}"
	for app in $apps; do
		if [[ -f "/etc/systemd/system/$app.timer" ]]; then
			local systemUnit="$app.timer"
		else
			local systemUnit="$app.service"
		fi
		echo "Enabling $systemUnit"
		sudo systemctl start "$systemUnit";
	done
}

apps="$(find * -maxdepth 0 -type d | tr '\n' ' ')"
echo "Apps to install: $apps"
install-service-files "$apps"
install-timer-files "$apps"
sudo systemctl daemon-reload
enable-services "$apps"
start-services "$apps"
