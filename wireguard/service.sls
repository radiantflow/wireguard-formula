{%- from slspath+"/map.jinja" import wireguard with context -%}

{% for network, network_settings in wireguard.networks.items() %}
wireguard-service-{{ network }}:
  service.running:
    - name: wg@{{ network }}
    - enable: {{ network_settings.enabled }}
    - watch:
      - file: /etc/wireguard/{{ network }}.conf
{% endfor %}



