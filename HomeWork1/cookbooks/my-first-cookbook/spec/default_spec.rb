require 'chefspec'

describe 'my-first-cookbook::default' do

    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }
	let(:template) { chef_run.template('/var/www/AAR/AAR_config.py') }

    it 'creates apache config template with a VirtualHost definition' do
		expect(chef_run).to create_template('/etc/apache2/sites-enabled/AAR-apache.conf')
		expect(chef_run).to render_file('/etc/apache2/sites-enabled/AAR-apache.conf').with_content(/.<VirtualHost.+>./)
		expect(chef_run).to render_file('/etc/apache2/sites-enabled/AAR-apache.conf').with_content(/.<\/VirtualHost>./)
    end

    it 'restarts apache2 service on config file change' do
		expect(template).to notify('service[apache2]').to(:restart).immediately
		
    end

    it 'starts and enables apache2 service' do
		expect(chef_run).to start_service('apache2')
		expect(chef_run).to enable_service('apache2')
    end
	
	it 'install python-mysqldb' do
		expect(chef_run).to install_package('python-mysqldb')
	end
end
