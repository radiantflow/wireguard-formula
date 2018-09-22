{% from slspath+"/map.jinja" import wireguard with context %}

wireguard_package:
  pkg.installed:
    - name: wireguard


{%- if grains.get('os') == 'Ubuntu' %}

wireguard_ppa:
  pkgrepo.managed:
    - ppa: wireguard/wireguard
    - require_in:
      - pkg: wireguard_package

{%- endif %}
