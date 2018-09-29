{% from slspath+"/map.jinja" import wireguard, wireguard_external_ips with context %}


{% for netname, network in wireguard.get('networks', {}).items() %}
  {%  if network.hostsfile %}
    {% set domain = network.get('hostsfile_domain', netname) %}
    {% for hostname, host in network['nodes'].items() %}

    {%- if host.get('ipv4_address') %}
{{ hostname }}-host-entry_ipv4:
  host.present:
    - ip: {{ host.get('ipv4_address')|json }}
    - name: {{ hostname + "." + domain }}
    {%- endif -%}

    {%- if host.get('ipv6_address') %}
{{ hostname }}-host-entry_ipv6:
  host.present:
    - ip: {{ host.get('ipv6_address')|json }}
    - name: {{ hostname + "." + domain }}
    {%- endif -%}

    {% endfor %}
  {% endif %}
{% endfor %}

