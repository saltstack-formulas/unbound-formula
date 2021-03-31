# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as unbound with context %}

unbound-service-clean-service-dead:
  service.dead:
    - name: {{ unbound.service.name }}
    - enable: False
