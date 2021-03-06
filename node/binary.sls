{% set node = pillar.get('node', {}) -%}
{% set version = node.get('version', '4.2.6') -%}
{% set checksum = node.get('checksum', '919498f2eb855ef0468b428b97d9d3f604d0f83417502d65b98c136786eb94d5') -%}
{% set pkgname = 'node-v' ~ version ~ '-linux-x64' -%}
{% set path = node.get('path') %}

Get binary package:
  file.managed:
    - name: {{ path }}{{ pkgname }}.tar.gz
    - source: http://cilsdbxd1851.silver.com/{{ pkgname }}.tar.gz
    - source_hash: sha256={{ checksum }}

Extract binary package:
  archive.extracted:
    - name: {{ path }} 
    - source: {{ path }}{{ pkgname }}.tar.gz
    - archive_format: tar
    - if_missing: {{ path }}{{ pkgname }}

#Copy lib:
#  cmd.run:
#    - cwd: /usr/local/src/{{ pkgname }}/
#    - name: cp -r bin/ include/ lib/ share/ /usr/local/
#    - unless: cmp /usr/local/bin/node /usr/local/src/{{ pkgname }}/bin/node
