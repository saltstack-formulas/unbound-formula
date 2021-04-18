{%- if grains['os'] == 'Ubuntu' %}
unbound-_test_dependencies-stop-systemd-resolved:
  service.dead:
    - name: systemd-resolved
    - enable: False
{%- endif %}
