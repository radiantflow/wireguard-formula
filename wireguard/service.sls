{%- from slspath+"/map.jinja" import wireguard with context -%}

{% for network, network_settings in wireguard.networks.items() %}
wireguard-service-{{ network }}:
  {%- if network_settings.active %}
  service.running:
  {%- else %}
  service.dead:
  {%- endif %}
    - name: wg-quick@{{ network }}
    - enable: true
    - watch:
      - file: /etc/wireguard/{{ network }}.conf
{% endfor %}



