## Development environment advanced concepts

### Layout of the development environment

The development environment will install itself in the */vagrant* directory of your virtual machine.
In this directory there are a few key sub-directories:

#### /vagrant/apps
This directory is the workspace that developers can use to work on apps. All of the applications are checked out here in their own directory.

#### /vagrant/config

The config directory contains two files: the *apps* file describes which apps to check out in the development environment, and the ports to start them on. If your app does not requrire a port simply set this to 0.

So, to add an app from the git repo *my-app* on port *8000* add this to the file:

```
my-app:8000
```

and to add an app called *my-no-port-app* with no port add this

```
my-no-port-app:0
```

The *virtual-env-global-requirements.txt* is a pip requirements file containing global requirements required in all virutual environments to make the development environment work. Application dependencies should not be checked into this file.

#### /vagrant/logs

This directory contains the individual log files for each application, and the log files of the virtual environment setup used during unit testing.

#### /vagrant/script

This directory contains the core scripts for the development environment. Anything put in */vagrant/script/bin* will be on the path for the VM user.

### Adding new applications to the development environment.

In order to work on a new application in the development environment you can follow this simple process.

First, create a git repository for the application and push it to github. In your application you will need to create the following files:

#### If you want your application to be startable by scripts like *dev-run-app*

You should add a *run_dev.sh* in the root of the application. This does not need to be executable and must issue the startup command for the application. It should not set any environment variables, the mechanism for this is described below.

#### If your application needs environment specific configuration

Adding an *environment.sh* into the root of the application directory which declares the environment as shell variables is all you need to do.
*NOTE*: You do *NOT* need to set SETTINGS='config.DevelopmentConfig' here, many of the scripts currently do and this reduces our flexibility.

If you add an *environment_test.sh* into the root of the application directory you can add specific requirements for tests here.

Note that the development environment will import *environment.sh* when starting the application, and will import *environment.sh* and then *environment_test.sh* when running test, so you don't need to duplicate properties in *environment_test.sh* if they don't need to change when testing. Also note, you do *not* need to add SETTINGS='config.TestConfig' here, the development system will do this for you.

#### If your application needs to create a database

Create a folder in your app called *db*

Inside this folder create two scripts, one called *create-database.sh* and the other called *upgrade-database.sh*
Note: These scripts *need to be executable*

In the create-database.sh script run your database creation code, and in the update-database.sh script call your
migration code. (If it is a python app you may need to do this in a virtual environment, see the section below)

The database creation is run every time you run a *vagrant provision*, so if you add a new database then developers
will need to run *vagrant provision*

Database migrations can be run each time you start the app if you add a call to *upgrade-database.sh* in your *run-dev.sh*

You can also call the command *dev-upgrade-all-databases* to run all of the migrations.


#### If your application needs to run python unit tests

If you want unit tests to be run by *dev-run-unit-tests* then you need to add a *tests* directory to the root of your app. Note: you need to place an *__init__.py* file in each test directory to ensure that it is picked up by py.test.

#### Writing scripts to run in the virtual environmnet

The development enviromnet wraps the provision of the python virtual environments. In certain cases you might want to execute scripts in the virtual environment, for example to load test data.

In order to do this, create an executable script in your application (*do not call it run_dev.sh*) and source in the development environment functions. You can then create the virtual environment with the *create_virtual_env <app-name>* and run the command required. Don't foget to call *deactivate* afterwards in the script to turn off the virtual env.

A good example can be found in the service frontend here: https://github.com/LandRegistry/service-frontend/blob/master/create-user-for-integration-tests.sh

As an example, lets say I am working in an app called *my-app*. I could create a script called *do-stuff.sh* in my root and do the following:

```
#!/bin/bash

set -e
source /vagrant/script/dev-env-functions
source ./environment.sh

create_virtual_env "my-app"

# Now, any commands in this script will be in the virtual environment.
python do-stuff-in-virtual-env.py

# Now we'll leave the virtual env
deactivate
```

### Starting multiple applications

The environment scripts support two ways of starting applications, either a *multi start* which starts a group of applications, or a *single start* which starts an individual application. All of these mechanisms are supported by the same start scripts.

It is possible to run multiple single starts at the same time, but only one multi start.

The workflow that is envisioned is that a number of background applications will be started as a multi-start, with the application that developers are working on started individually in another window. This allows developers to quickly stop / start the application they are working on without restarting all of the applications.


All of the applicatications can be started with

```
dev-start-all
```

A selection of applications can be started with

```
dev-run-app [app-names]
```

For example, to run the system-of-record and casework frontend you can run

```
dev-run-app system-of-record casework-frontend
```

#### Starting individual applications

To start an individual application simply go into the application directory and run *dev-run-app*. So, for example, to start the someapp do:

```
cd /vagrant/apps/someapp
dev-run-app
```

### Running unit tests for individual applications

To run all of the *unit-tests* for an individual application you can run the following:

```
cd /vagrant/apps/[app-name]
dev-run-unit-tests
```
