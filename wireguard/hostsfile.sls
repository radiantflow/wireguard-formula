{% from slspath+"/map.jinja" import wireguard, wireguard_external_ips with context %}

include:
  - wireguard

{% for netname, network in wireguard.get('networks', {}).items() %}
  {% for hostname, host in network['nodes'].items() %}

{{ hostname }}-host-entry:
  host.present:
    - ip: {{ host.get('wireguard_ip', "")|json }}
    - names:
      - {{ hostname + "." + netname }}

  {% endfor %}
{% endfor %}
