service 'monit' do
	supports :status => false, :restart => false, :reload => true
	action :nothing
end

template "#{node[:monit][:conf_dir]}/elasticsearch_monit.conf" do
	source "elasticsearch_monitrc.conf.erb"

	owner "root"
	group "root"
	mode 0440

	notifies :reload, resources(service: 'monit'), :immediately
end
