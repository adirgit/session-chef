
puts 'This is a message from puts'

Chef::Log.info('This is a log INFO message')
Chef::Log.warn('This is a log WARN message')
Chef::Log.error('This is a log ERROR message')

log 'This is a log from the log resource'

ruby_block 'write logs' do
  block do
    Chef::Log.info('This is a log from a ruby block')
  end
end
