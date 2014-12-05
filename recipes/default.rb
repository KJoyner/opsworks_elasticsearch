#
# Cookbook Name:: opsworks_elasticsearch
# Recipe:: default
#
# Copyright (C) 2014 kjoyner
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# install and setup elastic search
include_recipe 'elasticsearch'

# enable aws features - auto-discovery of other nodes
# TODO: Need to set permissions in IAM (see https://github.com/elasticsearch/elasticsearch-cloud-aws)
include_recipe 'elasticsearch::aws'

# install, configure and run nginx as a reverse proxy to elasticsearch
include_recipe 'elasticsearch::proxy'

# setup monit for elasticsearch (need to account for Opswork already using on monit)
include_recpie 'opsworks_elasticsearch::monit'

# execute 'disable default nginx site' do
# 	command 'nxdissite default'
# 	notifies :restart, resources(:service => 'nginx'), :immediately
# 	only_if do
# 		::File.exists?('/etc/nginx/sites-enabled/default')
# 	end
# end
