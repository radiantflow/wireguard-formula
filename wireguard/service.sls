{%- from slspath+"/map.jinja" import wireguard with context -%}
{%- set current_id = grains['id'].split('.') | first %}

{% for netname, network in wireguard.get('networks', {}).items() %}
  {% set current_host = network['nodes'].get(current_id, {}) %}
  {% if current_host.get('private_key') != None and (current_host.get("ipv4_address") != None or current_host.get("ipv6_address") != None) %}
wireguard-service-{{ netname }}:
    {%- if network.active %}
  service.running:
    {%- else %}
  service.dead:
    {%- endif %}
    - name: wg-quick@{{ netname }}
    - enable: true
    - watch:
      - file: /etc/wireguard/{{ netname }}.conf
  {% endif %}
{% endfor %}



