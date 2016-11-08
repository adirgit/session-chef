require 'serverspec'

# Require by serverspec
set :backend, :exec

describe port ('80') do
	it {should be_listening}
end

describe command('a2query -m wsgi') do
	its(:stdout) { should contain('enabled') }
end

describe command('curl -X POST --silent --output /dev/null --write-out "%{http_code}" -F \'username=ad1\' -F \'password=ad1pw\' http://localhost/') do
	its(:stdout) { should contain('302') }
end

