log_dirs = {
  '/usr/lib/kafka/logs' => '3d',
  '/var/log/kafka' => '3d',
  '/var/log/zookeeper' => '1d'
}

log_dirs.each do |kafka_logdir, retention|

  cron 'kafka_log_watch for' do
    hour '*/3'
    command "/usr/sbin/tmpreaper #{retention} #{kafka_logdir}"
  end

end

