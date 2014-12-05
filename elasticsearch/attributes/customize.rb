include_attribute 'opsworks_agent_monit::default'

normal[:elasticsearch][:version] = "1.1.1"

# specify parameters around the gateway that allows elasticseach to recover data from EBS volumes if full restart
# of the cluster is performed!
normal[:elasticsearch][:cluster] = { name: 'opsworks-elasticsearch' }
normal[:elasticsearch][:gateway] = { expected_nodes: 1 }

# help ElasticSearch spread data redundantly in separate zones
normal[:elasticsearch][:custom_config]['cluster.routing.allocation.awareness.attributes'] = 'rack_id'
normal[:elasticsearch][:custom_config]['node.rack_id'] = "#{node[:opsworks][:instance][:availability_zone]}"

# configure aws cloud plugin to automate discovery of the rest of the cluster (need to run recipe elasticsearch::aws)
normal[:elasticsearch][:discovery][:type] = 'ec2'
normal[:elasticsearch][:discovery][:zen][:mininum_master_nodes] = 1
normal[:elasticsearch][:discovery][:zen][:ping][:multicast][:enabled] = false
normal[:elasticsearch][:discovery][:ec2][:tag] =  { 'opsworks:stack' => 'elasticsearch' }

# setup nginx to act as proxy (need to run recipe elasticsearch::proxy)
#   by default, no credentials are set - assumes
normal[:elasticsearch][:nginx][:allow_cluster_api] = true;
normal[:elasticsearch][:nginx][:port] = 80;

