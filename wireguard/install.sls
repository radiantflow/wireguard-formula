{% from slspath+"/map.jinja" import wireguard with context %}

{%- if wireguard.installed == True %}

  {%- if grains.get('kernelrelease') != None %}

linux_kernel_headers:
  pkg.installed:
  - name: linux-headers-{{ grains.get('kernelrelease') }}
  - refresh: true

  {%- endif %}

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

{%- endif %}