default['mycookbook']['packages'] = %w{
	libapache2-mod-wsgi
	python-pip
	python-mysqldb
}

default['mycookbook']['apache']['conf_file'] = '/etc/apache2/sites-enabled/AAR-apache.conf'
default['mycookbook']['apache']['user'] = 'www-data'
default['mycookbook']['apache']['group'] = 'www-data'
default['mycookbook']['apache']['app_dir'] = '/var/www/AAR'

default['mycookbook']['app']['mysql_pass'] = 'root'
default['mycookbook']['app']['db_creation_script'] = '/usr/local/bin/make_AARdb.sql'
default['mycookbook']['app']['db_user'] = 'aarapp'
default['mycookbook']['app']['db_pass'] = '7ERwzg7E'
default['mycookbook']['app']['db_host'] = 'localhost'
default['mycookbook']['app']['db_name'] = 'AARdb'
default['mycookbook']['app']['config_file'] = "#{node['mycookbook']['apache']['app_dir']}/AAR_config.py"
