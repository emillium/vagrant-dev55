# Ansible Role: Node.js

Installs Node.js on Debian/Ubuntu.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    nodejs_version: "0.10"

The Node.js version to install. "0.10" is the default and works on all supported OSes. "0.12" is only supported on Debian/Ubuntu for now (see [this issue in the Nodesource repository](https://github.com/nodesource/distributions/issues/73)).

    nodejs_forever: true

Whether to install Forever, a simple process manager for Node.js. With forever installed, you can start a Node.js app with the command `forever start /path/to/app.js`, and manage the app via `forever` much the same as you would manage other services on your server with `service`.

    nodejs_npm_global_packages: []

Add a list of npm packages with a `name` and (optional) `version` to be installed globally. For example:

    nodejs_npm_global_packages:
      # Install a specific version of a package.
      - name: jslint
        version: 0.9.3
      # Install the latest stable release of a package.
      - name: node-sass

## Dependencies

None.

## Example Playbook

    - hosts: utility
      vars_files:
        - vars/main.yml
      roles:
        - geerlingguy.nodejs

*Inside `vars/main.yml`*:

    nodejs_forever: true
    nodejs_npm_global_packages:
      - name: jslint
      - name: node-sass
