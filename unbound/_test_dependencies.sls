{%- if grains['os'] == 'Ubuntu' or grains['os_family'] == 'Arch' %}
unbound-_test_dependencies-stop-systemd-resolved:
  service.dead:
    - name: systemd-resolved
    - enable: False
{%- endif %}

{%- if grains.get('osfinger', '') == 'Ubuntu-18.04' %}
unbound-_test_dependencies-no-ipv6:
  cmd.run:
    - name: 'echo "  do-ip6: no" >> /etc/unbound/unbound.conf'
    - require:
      - file: unbound-config-file-file-managed
    - require_in:
      - service: unbound-service-running-service-running
{%- endif %}
