bonding
=========

Role to create / configure properly bonding interfaces

Requirements
------------

Ansible 2.0, python-netaddr

Role Variables
--------------

| Name | Type | Required | Default | Description
|--- |--- |--- |--- |---
| slaves | list | yes | None | List of the slaves part of the bond
| bond | dict | yes | None | Name of the bond interface with ip informations
| vlans | list of dict | yes | None | vlans name with ip informations
| v1 | dict | yes | None | value: configure or not ip in bond interface, vlan: condifure or not vlan
| apply | boolean | no | true | Set to true to write the real configuration files in sysconfig
| apply_now | boolean | no | false | Restart the network restart after writing the configuration files
| el_network_sysconfig | string | no | /etc/sysconfig/network-scripts | Default directory for RH/CentOS
| tmp_dir | string | no | /tmp | TMP directory for the configuration files
| bond_options | list of dict | no | [{ 'key': 'mode', 'value': 'lacp'}, { 'key': 'miimon', 'value': '80'}] | Some default values for Bonding Options
| mtu | int | no | 1500 | Value of the MTU for the interface
| enable_ipv4 | boolean | no | false | Determines if you want to use ipv4 settings for the bond interface
| manage_gateway | boolean | no | true | Determines if you want to configure the gateway on the bond
| manage_dns_servers | boolean | no | true | Determines if you want to configure DNS on the bond configuration
| manage_hw_addr | boolean | no | true | Determines if you want to write the HWADDR in the slaves configuration
| ip_addr | string | no | None | The IPv4 for the bond interface
| netmask | string | no | None | The Netmask for the bond interface
| gateway | string | no | None | The gateway to use for the bond interface
| dns1 | string | no | None | DNS1 server
| dns2 | string | no | None | DNS2 server
| enable_ipv6 | boolean | no | true | Enable IPv6 on the bond interface
| init_ipv6 | boolean | no | true | Enable IPv6 initiatialization
| ipv6_autoconf | boolean | no | no | Enable IPv6 autoconfiguration
| keep_slave_ipv4 | boolean | no | false | Determines if you want to keep the slaves existing IPv4 configuration


Dependencies
------------

None

Example Playbook
----------------

```
---
- hosts: newservers
  remote_user: root
  roles:
   - role: bonding
  vars:
  - slaves:
    - eth0
    - eth1
  - bond: {name: 'bond0', ip_addr: '12.12.12.12', netmask: '255.255.0.0', gtw: '10.10.10.1' }
  - v1: { value: true, vlan: true}
  - vlans:
    - { name: 'vlan101', ip_addr: '10.10.10.10', netmask: '255.255.255.224', gtw: '10.10.10.1' }
    - { name: 'vlan102', ip_addr: '11.11.11.11', netmask: '255.255.255.0' }
  - dns1: 192.168.2.3
  - dns2: 8.8.8.8
```


License
-------

GPLv3

Author Information
------------------

Franck Moube
