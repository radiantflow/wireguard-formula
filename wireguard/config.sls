{% from slspath+"/map.jinja" import wireguard, wireguard_external_ips with context %}
{%- set current_id = grains['id'].split('.') | first %}

{% for netname, network in wireguard.get('networks', {}).items() %}
  {% set current_host = network['nodes'].get(current_id, {}) %}
  {% if current_host.get('private_key') != None and (current_host.get("ipv4_address") != None or current_host.get("ipv6_address") != None) %}
wireguard-config-{{netname}}:
  file.managed:
    - name: /etc/wireguard/{{ netname }}.conf
    - mode: 700
    - user: root
    - group: root
    - clean: true
    - source: salt://wireguard/template/wireguard.conf.tmpl
    - template: 'jinja'
    - context:
        hostname: {{ current_id|json }}
        config: {{ current_host|json }}
        peers: {{ network.get('peers', {})|json }}

    - watch_in:
      - service: wireguard-service-{{ netname }}

  {% endif %}
{% endfor %}
