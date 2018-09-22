{% from slspath+"/map.jinja" import wireguard, wireguard_external_ips with context %}
{%- set current_host = grains['id'].split('.') | first %}