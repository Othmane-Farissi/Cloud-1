```markdown
# Cloud-1

This project demonstrates a practical implementation of Infrastructure as Code using Ansible to provision DigitalOcean servers and deploy a containerized PHP web application. It shows how to combine Ansible, Docker, and DigitalOcean resources to create repeatable, auditable deployments.

Highlights
- Provision and configure DigitalOcean droplets with Ansible
- Build and deploy a Dockerized PHP web app
- IaC approach for reproducible, version-controlled infrastructure
- Focus on automation: scripts, playbooks, and verifiable deployment steps

Prerequisites
- Local:
  - Ansible 2.10+ (or the version used by the project)
  - Ansible collections required by the playbooks (see ansible/requirements.yml)
  - Docker and Docker CLI (for local image build & tests)
  - doctl (optional) or a DigitalOcean API token for provisioning
  - git, jq, curl (useful helper tools)
- Remote (target droplets):
  - SSH access to created droplets (Ansible will use SSH)
  - Basic port access (HTTP/HTTPS) allowed in firewall rules

Quickstart (high level)
1. Create a DigitalOcean API token and store it securely.
2. Configure your inventory and variables (ansible/inventory/*, group_vars/*).
3. Install Ansible roles/collections: ansible-galaxy install -r ansible/requirements.yml
4. Provision droplets: ansible-playbook -i ansible/inventory ansible/playbooks/provision.yml
5. Configure and deploy: ansible-playbook -i ansible/inventory ansible/playbooks/deploy.yml

Configuration
- DigitalOcean API token:
  - You can export it as an environment variable or store it in an encrypted vault.
    Example:
    ```bash
    export DO_API_TOKEN="your_digitalocean_api_token_here"
    ```
- Ansible inventory & variables:
  - Create or edit ansible/inventory/hosts (or inventory.yml) to list your hosts or groups.
  - Use group_vars/all.yml (or appropriate group_vars) to set shared variables such as:
    - do_api_token
    - ssh_user
    - docker_image (image name or registry)
    - app_port
  - For sensitive data consider using Ansible Vault:
    ```bash
    ansible-vault create ansible/group_vars/all/vault.yml
    ```

Usage (concrete examples)

Install Ansible collections & roles
```bash
cd ansible
ansible-galaxy install -r requirements.yml
```

Provision infrastructure
```bash
# example: run the provisioning playbook (creates droplets)
ANSIBLE_STDOUT_CALLBACK=default DO_API_TOKEN="$DO_API_TOKEN" \
ansible-playbook -i inventory/hosts playbooks/provision.yml
```
- Replace inventory path and playbook name to match the repository structure.

Build and publish Docker image
```bash
# build locally (example)
docker build -t yourdockerhubuser/cloud-1:latest ./docker

# push to registry
docker push yourdockerhubuser/cloud-1:latest
```
- If using a CI pipeline, build & push in CI and tag with commit SHA.

Deploy application with Ansible
```bash
# deploy playbook pulls the image and runs the container (or docker-compose)
ansible-playbook -i ansible/inventory playbooks/deploy.yml \
  -e "docker_image=yourdockerhubuser/cloud-1:latest"
```
- The deploy playbook should install Docker on target hosts, ensure firewall rules, and start the container.



- Replace placeholder playbook and inventory names with exact paths from the repository.
- If you paste the repository tree or the key files (ansible/playbooks/*.yml, ansible/requirements.yml, docker/Dockerfile, app path), I will update this README to include exact commands, variables, and examples.
```
