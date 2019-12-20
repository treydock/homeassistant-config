check:
	docker run -it --rm -v /home/pi/home-assistant-config:/config:ro -v /etc/localtime:/etc/localtime:ro homeassistant/home-assistant:stable hass -c /config --script check_config -i -f

