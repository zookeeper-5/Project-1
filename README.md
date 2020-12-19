# Project-1
First project of Bootcamp

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

!Update the path with the name of your diagram](Images/diagram_filename.png)
https://drive.google.com/file/d/1dBStLzYhO6BZAjpbKAWBeEl3QQ-_E9Hb/view?usp=sharing
In the Diagrams folder

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML file may be used to install only certain pieces of it, such as Filebeat.

  - Enter the playbook file._

---
- name: Config Web VM with Docker
  hosts: webservers
  become: true
  tasks:
    - name: docker.io
      apt:
        update_cache: yes
        name: docker.io
        state: present

    - name: Install pip3
      apt:
        name: python3-pip
        state: present

    - name: Install Docker python module
      pip:
        name: docker
        state: present

    - name: download and launch a docker web container
      docker_container:
        name: dvwa
        image: cyberxsecurity/dvwa
        state: started
        restart_policy: always
        published_ports: 80:80

    - name: Enable docker service
      systemd:
        name: docker
        enabled: yes



---
- name: Config ELK_VM_01 with Docker
  hosts: elk
#  remote_user: elk
  become: true
  tasks:
    - name: docker.io
      apt:
        update_cache: yes
        name: docker.io
        state: present

    - name: Install python3_pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

    - name: Install Docker python module
      pip:
        name: docker
        state: present

    - name: Enable docker service
      systemd:
        name: docker
        enabled: yes

#    - name: Increase virtual memory
#     command: sysctl -w vm.max_map_count=262144

    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: '262144'
        state: present
        reload: yes

    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        # Please list the ports that ELK runs on
        published_ports:
          -  5601:5601
          -  9200:9200
          -  5044:5044





---
- name: installing and launching filebeat
  hosts: webservers
  become: yes
  tasks:

  - name: download filebeat deb
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-amd64.deb

  - name: install filebeat deb
    command: dpkg -i filebeat-7.4.0-amd64.deb

  - name: drop in filebeat.yml
    copy:
      src: /etc/ansible/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

  - name: enable and configure system module
    command: filebeat modules enable system
    command:

  - name: setup filebeat
    command: filebeat setup

  - name: start filebeat service
    command: service filebeat start



This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- What aspect of security do load balancers protect? Availability. What is the advantage of a jump box? It is a highly secure computer that is never used for non-administrative tasks. It sits in front of the VMs on the network. It controls access to the other machines. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.
- What does Filebeat watch for? Log files
- What does Metricbeat record? Performance metrics

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name 	| Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.1   | Linux            |
| Web1 	|Web Server| 10.0.0.7   | Linux               |
| Web2 	|Web Server| 10.0.0.8   | Linux            |
| Web3 	|Web Server| 10.0.0.10  | Linux            |
| Elk01	|Monitoring| 10.1.0.4	  | Linux		     |		
### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Add whitelisted IP addresses_
107.77.209.220

Machines within the network can only be accessed by ssh.
- Which machine did you allow to access your ELK VM? What was its IP address?_
The jump box. From private IP- 10.0.0.1 
A summary of the access policies in place can be found in the table below.

| Name     	| Publicly Accessible 	| Allowed IP Addresses 	|
|----------	|---------------------	|----------------------	|
| Jump Box 	| Yes                 	| 107.77.209.220       	|
| Web1     	| No                  	| 10.0.0.1             	|
| Web2     	| No                  	| 10.0.0.1             	|
| Web3     	| No                  	| 10.0.0.1             	|
| Elk01    	| No                  	| 10.0.0.1             	|


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- What is the main advantage of automating configuration with Ansible? You don’t need to install any other software. It is very easy to do. You can configure more than one machine at a time.

The playbook implements the following tasks:
- In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
* Install Docker
* Install Python 3
* Install Docker Python module
* Enable Docker service
* Increase virtual memory
* Install Docker container

- ...

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

!Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)
In the image file.

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- List the IP addresses of the machines you are monitoring_
10.0.0.7
10.0.0.8
10.0.0.10

We have installed the following Beats on these machines:
- Specify which Beats you successfully installed_
Filebeat
Metricbeat

These Beats allow us to collect the following information from each machine:
- In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._
Filebeat is a log shipper that monitors logs and ships them into the ELK stack for analysis.
Metricbeat is a shipper that you can install on your servers to collect metrics from the operating system and services that run on the server. It takes the data it collects and ships it to the output that you specify.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
- Copy the filebeat configuration file to your Web VMs where you just installed filebeat. Copy to /etc/filebeat/filebeat.yml.
- Update the filebeat config file to include the private IP of the ELK server.
- Run the playbook, and navigate to the ELK server to check that the installation worked as expected.

_Answer the following questions to fill in the blanks:_
- _Which file is the playbook? filebeat-playbook.yml Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? host.cfg How do I specify which machine to install the ELK server on versus which to install Filebeat on? You specify it in the .yml file_
- _Which URL do you navigate to in order to check that the ELK server is running? http://52.188.172.82:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > /etc/ansible/files/filebeat-config.yml

Nano filebeat-config.yml
mv /etc/ansible/filebeat-playbook.yml .
Nano filebeat-playbook.yml
Ansible-playbook filebeat-playbook.yml

