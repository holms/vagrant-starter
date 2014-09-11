{% set os_code = salt['grains.get']('oscodename') %}

webupd_java_ppa:
  pkgrepo.managed:
    - humanname: Oracle Java PPA
    - name: ppa:webupd8team/java
    - dist: {{ os_code }}
    - file: /etc/apt/sources.list.d/oracle.list
    - keyserver: keyserver.ubuntu.com

oracle-ppa-accept:
  cmd.wait:
   - name: "echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections"
   - watch:
      - pkgrepo: webupd_java_ppa

oracle-java7-installer:
  pkg.installed:
    - require:
      - cmd: oracle-ppa-accept
