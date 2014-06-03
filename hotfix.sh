#!/usr/bin/env bash
set -ex

sudo sed -i -e 's/#{ChefServerWebui::Application.config.admin_default_password}/YOUR_INSTANCE_ID/'   /opt/chef-server/embedded/service/chef-server-webui/app/views/users/login.html.haml
