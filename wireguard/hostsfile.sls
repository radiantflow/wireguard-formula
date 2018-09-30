{% from slspath+"/map.jinja" import wireguard, wireguard_external_ips with context %}


{% for netname, network in wireguard.get('networks', {}).items() %}
  {%  if network.hostsfile %}
    {% set domain = network.get('hostsfile_domain', netname) %}
    {% for hostname, host in network['nodes'].items() %}

      {%- if host.get('ipv4_address') %}
{{ hostname }}-host-entry_ipv4:
  host.only:
    - name: {{ host.get('ipv4_address')|json }}
    - hostnames: [{{ hostname + "." + domain }}]
      {%- endif -%}

      {%- if host.get('ipv6_address') %}
{{ hostname }}-host-entry_ipv6:
  host.only:
    - name: {{ host.get('ipv6_address')|json }}
    - hostnames: [{{ hostname + "." + domain }}]
      {%- endif -%}

    {% endfor %}
    {% for host in network.get('deleted_hosts', []) %}
  host.absent:
    - ip: {{ host.ip }}
    - name: {{ host.name }}
    {% endfor %}
  {% endif %}
{% endfor %}

