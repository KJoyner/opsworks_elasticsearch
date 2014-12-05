include_attribute 'opsworks_agent_monit::default'

default[:elasticsearch][:version] = "1.1.1"

# specify parameters around the gateway that allows elasticseach to recover data from EBS volumes if full restart
# of the cluster is performed!
default[:elasticsearch][:cluster] = { name: 'opsworks-elasticsearch' }
default[:elasticsearch][:gateway] = { expected_nodes: 1 }

# help ElasticSearch spread data redundantly in separate zones
default[:elasticsearch][:custom_config]['cluster.routing.allocation.awareness.attributes'] = 'rack_id'
default[:elasticsearch][:custom_config]['node.rack_id'] = "#{node[:opsworks][:instance][:availability_zone]}"

# configure aws cloud plugin to automate discovery of the rest of the cluster (need to run recipe elasticsearch::aws)
default[:elasticsearch][:discovery][:type] = 'ec2'
default[:elasticsearch][:discovery][:zen][:mininum_master_nodes] = 1
default[:elasticsearch][:discovery][:zen][:ping][:multicast][:enabled] = false
default[:elasticsearch][:discovery][:ec2][:tag] =  { 'opsworks:stack' => 'elasticsearch' }

# setup nginx to act as proxy (need to run recipe elasticsearch::proxy)
#   by default, no credentials are set - assumes
default[:elasticsearch][:nginx][:allow_cluster_api] = true;
default[:elasticsearch][:nginx][:port] = 80;

default[:elasticsearch][:plugins]['mobz/elasticsearch-head'] = {}

