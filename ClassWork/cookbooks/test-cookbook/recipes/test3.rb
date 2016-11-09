
package 'tree' do
  action :install
end

md5_sum = shell_out('md5sum /usr/bin/tree').stdout

file '/tmp/tree.size' do
  content md5_sum
end
