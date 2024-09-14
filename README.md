Ansible Role: Containerized monitoring stack
============================================

Role to run containerized monitoring stack via standalone Docker containers.

Deploys the following:
- [Prometheus](https://prometheus.io)
- [Alertmanager](https://github.com/prometheus/alertmanager)
- Prometheus [node-exporter](https://github.com/prometheus/node_exporter)
- [Grafana](https://grafana.com)

> **!! WARNING: !!** This role installs **Python 3** and [**Docker SDK for Python**](https://docker-py.readthedocs.io/en/stable/) packages to the target host(s) automatically!

Requirements
------------

N/A

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml) for the full variable list and their description

Dependencies
------------

See [meta](meta/) dir

Example Playbook
----------------

Clone this repo to your local role path or install via [Ansible Galaxy](https://docs.ansible.com/ansible/latest/galaxy/user_guide.html#installing-roles)

Create `my_playbook.yml` with the following contents:
```yaml
- hosts: my-awesome-host
  roles:
    - role: monitoring_stack
      # Uncomment the key below to override role vars
      # vars:
      #   prometheus_version: v2.26.0
```

And then run playbook - this will run node-exporter container on the `awesome` host:
```bash
ansible-playbook -v my_playbook.yml
```

Container restart and/or re-creation can be forced by overriding role default vars. Example for the Prometheus:
```bash
ansible-playbook -v my_playbook.yml --extra-vars "prometheus_container_restart=true prometheus_container_recreate=true"
```

Specific services deployment could be switched on/off using tags. For example to install only required packages and node_exporter run:
```bash
ansible-playbook --tags "packages,node_exporter" my_playbook.yml
```

Development
-----------

### Role testing

Script [test.sh](test.sh) activates Python virtualenv, installs all the required Python packages and executes linter.

More comprehensive functional tests could be executed like following:
```bash
source venv/bin/activate
molecule test
```

Author Information
------------------

[vi7](https://github.com/vi7)
