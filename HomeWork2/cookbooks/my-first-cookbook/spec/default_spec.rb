require 'chefspec'

describe 'my-first-cookbook::default' do

    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }


    it 'creates apache config template with a VirtualHost definition' do
    end

    it 'restarts apache2 service on config file change' do
    end

    it 'starts and enables apache2 service' do
    end
end
