.PHONY: check

TOKEN := $(shell cat .token)
check:
	docker ps | grep -q "home-assistant"; \
		if [ $$? -ne 0 ]; then \
			echo "Using docker run"; \
			docker run -it --rm -v /home/pi/home-assistant-config:/config:ro -v /etc/localtime:/etc/localtime:ro homeassistant/home-assistant:stable hass -c /config --script check_config -i -f ; \
		else \
			echo "Using docker exec"; \
			docker exec -it home-assistant hass -c /config --script check_config -i -f ; \
		fi

restart:
	curl -X POST -H "Authorization: Bearer $(TOKEN)" -H "Content-Type: application/json" 127.0.0.1:8123/api/services/homeassistant/restart

reload:
	curl -X POST -H "Authorization: Bearer $(TOKEN)" -H "Content-Type: application/json" 127.0.0.1:8123/api/services/automation/reload

entities:
	curl -X GET -H "Authorization: Bearer $(TOKEN)" -H "Content-Type: application/json" 127.0.0.1:8123/api/states | jq '.[] | {name: .attributes.friendly_name, entity_id}'
