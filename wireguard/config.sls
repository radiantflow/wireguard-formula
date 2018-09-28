{% from slspath+"/map.jinja" import wireguard, wireguard_external_ips with context %}
{%- set current_host = grains['id'].split('.') | first %}

{% for netname, network in wireguard.get('networks', {}).items() %}

{#  {% if network.config.get('private_key') != None %}#}
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
        hostname: {{ current_host|json }}
        config: {{ network['nodes'].get(current_host, {})|json }}
        peers: {{ network.get('peers', {})|json }}

    #- watch_in:
    #  - service: wireguard-service-{{ netname }}

{#  {% endif %}#}
{% endfor %}
