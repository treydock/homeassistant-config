TOKEN := $(shell cat .token)
check:
#	docker run -it --rm -v /home/pi/home-assistant-config:/config:ro -v /etc/localtime:/etc/localtime:ro homeassistant/home-assistant:stable hass -c /config --script check_config -i -f
  docker exec -it home-assistant hass -c /config --script check_config -i -f

restart:
	curl -X POST -H "Authorization: Bearer $(TOKEN)" -H "Content-Type: application/json" 127.0.0.1:8123/api/services/homeassistant/restart

entities:
	curl -X GET -H "Authorization: Bearer $(TOKEN)" -H "Content-Type: application/json" 127.0.0.1:8123/api/states | jq '.[] | {name: .attributes.friendly_name, entity_id}'
