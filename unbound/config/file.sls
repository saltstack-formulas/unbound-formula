# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as unbound with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

unbound-config-file-file-managed:
  file.managed:
    - name: {{ unbound.config }}
    - source: {{ files_switch(['unbound.conf'],
                              lookup='unbound-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ unbound.rootgroup }}
    - makedirs: True
    - template: jinja
    - check_cmd: unbound-checkconf
    - tmp_dir: {{ unbound.config_dir }}
    - require:
      - sls: {{ sls_package_install }}
    - context:
        unbound: {{ unbound | json }}
