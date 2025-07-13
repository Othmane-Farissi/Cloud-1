# Cloud-1

I started this project by understand the key concepts of Ansible automation tool , which are the following :

**Inventory** : The **Inventory File** is where you define the **hosts (servers)** and **groups of hosts** that Ansible should manage.

Think of it as the **list of targets** Ansible connects to.

**Variable** : **Variables** in Ansible allow you to store and reuse values — like configuration options, file paths, usernames, IP addresses, or package versions — and inject them into your playbooks and templates.

**Playbook** : A **Playbook** is a **YAML file** that contains a list of **instructions (plays)** that tell Ansible:

- **Which machines** to target
- **What to do** on those machines
- **In what order** to do it
- **Using what configuration**

It's like a script or recipe to **automate configuration, deployment, or orchestration** tasks.

**Roles** : A **role** in Ansible is a **structured, self-contained unit** of automation. Each role is a collection of files, variables, tasks, templates, handlers, and more — all bundled together for a specific function (e.g., install nginx, configure firewall, manage users).

**Security** : Key areas of Ansible security :

- Use Ansible Vault
- Encrypt a file
- Decrypt a file

## Next I installed Ansible via pip and created a VM machine to understand it functionality properly :