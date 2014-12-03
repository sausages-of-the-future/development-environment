## Development Environment

This repository contains the setup scripts for developers to quickly get up and running. By bootstrapping their developer environment from these scripts developers will be able to get all of the code repositories, run the unit tests and start the various applications that make up the land registry systems.

**Very important consideration for those of you with 4gb memory or less**
*set an environment variable VM_MEMORY for less than 4gb, before running vagrant up*

## Prerequisites

In order to run the development environment locally you will need

* VirtualBox 4.3.14 or above (https://www.virtualbox.org/wiki/Downloads)
* Vagrant (http://www.vagrantup.com/downloads.html)
* git must be installed locally

### Configuring the hostfile

Before using the service ensure that the following line is in your hostfile on the host machine. (Normally in /etc/hosts)

```
172.16.42.43 govuk.local registry.govuk.local fishing.govuk.local organisations.govuk.local www.govuk.local
```

This is the most recent list of hosts at the time of writing this. When you vagrant ssh into the box you will see the latest list of apps.

### Configuring SSH agent forwarding

This is done automatically as part of the dev env provisioning process.

## Creating the environment

From the directory containing this repository run

```
vagrant up
```

This will create the virtual machine. Next, log into the virtual machine using the command:

```
vagrant ssh
```

This will log into the machine and check out all of the applications in the */vagrant/apps* directory

## Running all of the unit tests

To run all of the unit tests configured in the applications simply log into the VM and run

```
dev-run-all-unit-tests
```

## Starting up all of the applications

To start up all of the applications run

```
dev-start-all
```

## Appplication files & log locations

Each application will be stored in */vagrant/apps/*

Logs for each individual application can be found in */vagrant/logs*

## To update all of the apps

Simply run

```
dev-update-all-apps
```

## To upgrade all of the databases

Simply run

```
dev-upgrade-all-databases
```

## To create all of the databases

Run

```
dev-create-all-databases
```

Note: This will run automatically when the VM is provisioned.

## If your environment becomes corrupted

To clean out the environment and python virtual environments for all applications you can run

```
dev-clean
```

To clean out the whole environment and begin again from scratch you can run the following commands from the host machine, not inside the VM.

```
vagrant halt
vagrant destroy
vagrant up
```

## Advanced topics

For more detailed operations within the dev environment look here: https://github.com/sausages-of-the-future/development-environment/blob/master/README_Advanced.md
