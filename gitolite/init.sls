{% from "gitolite/defaults.jinja" import gitolite with context %}

gitolite-software:
  pkg.installed:
    - pkgs:
      - gitolite3
{%- if gitolite.annex %}
      - git-annex
{% endif -%}

gitolite-debconf:
  debconf.set:
    - name: gitolite3
    - data:
        'gitolite3/gituser': {'type': 'string', 'value': '{{ gitolite.gituser }}'}
        'gitolite3/gitdir': {'type': 'string', 'value': '{{ gitolite.gitdir }}'}
        'gitolite3/adminkey': {'type': 'string', 'value': '{{ gitolite.adminkey }}'}
    - required_in:
      - pkg: gitolite-software
# otherwise: /usr/bin/gitolite setup -pk /gitolite-admin.pub

gitolite-config:
  file.managed:
    - name: {{ gitolite.gitdir }}/.gitolite.rc
    - source: salt://gitolite/files/gitolite.rc
    - user: {{ gitolite.gituser }}
    - mode: 600
    - template: jinja
    - defaults:
      - annex: {{ gitolite.annex }}
