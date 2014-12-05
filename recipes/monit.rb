template "#{node[:monit][:conf_dir]}/elasticsearch_monit.conf" do
	source "elasticsearch_monitrc.conf.erb"

	owner "root"
	group "root"
	mode 0440
end