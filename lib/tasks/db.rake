
require 'yaml'

# Some of this code graciously borrowed from Magma <http://mag.ma>.

namespace :db do

  # desc 'dump database to temporary directory, sans large data'
  # task :dump_to_tmp do
  # 
  #   database = YAML::load_file(RAILS_ROOT+'/config/database.yml')
  #   filename = "/tmp/magma-dump.sql.gz"
  #   RAILS_ENV ||= 'development'
  #   db = database[RAILS_ENV]['database']    
  #   puts "Dumping #{RAILS_ENV} to #{filename} ..."
  # 
  #   # remind me to discuss the finer points of opt, --skip, missing indexes etc.
  #   # TODO: also ignore stats when dumping on staging, so that syncing to dev is nice & fast
  #   #  from prod -> stage we still want all data though (right?)
  #   ignore_stats = '' # " --ignore-table=#{db}.stats"
  #   ignore_tables = "--ignore-table=#{db}.old_stats --ignore-table=#{db}.stats_backup #{ignore_stats}"
  #   
  #   cmd = "mysqldump --opt #{ignore_tables}"
  #   `#{cmd} -u #{database[RAILS_ENV]['username']} --password=#{database[RAILS_ENV]['password']} #{db} | gzip > #{filename}`
  # end
  # 
  # desc 'dump last 30 days stats as a MySQL OUTFILE...'
  # task :dump_stats do
  #   # TODO: DRY with above!!! just a hackjob 4 now...
  #   database = YAML::load_file(RAILS_ROOT+'/config/database.yml')
  #   # filename = "/tmp/magma-dump-stats.outfile"
  #   filename = "dump-stats.outfile"
  #   full_filename = RAILS_ROOT+'/tmp/'+filename
  #   RAILS_ENV ||= 'development'
  #   db = database[RAILS_ENV]['database']
  #   puts "Dumping #{RAILS_ENV} stats for last 30 days to #{filename} ..."   
  #    
  #   query = "SELECT * FROM stats WHERE (created_at > DATE_SUB(NOW(), INTERVAL 30 DAY)) INTO OUTFILE '#{filename}';"    
  #   # OMG this is a gross hackery...
  #   `cd #{RAILS_ROOT}`
  #   `rm -f #{full_filename}`
  #   puts "query = #{query.inspect}"
  #   `mysql -u #{database[RAILS_ENV]['username']} --password=#{database[RAILS_ENV]['password']} #{db} -e "#{query}"`
  #   `gzip "#{full_filename}"`
  #   `mv #{filename} #{full_filename}`
  # end

  namespace :migrate do
    desc "Rollback the database schema to the previous version"
    task :rollback => :environment do
      ActiveRecord::Migrator.rollback("db/migrate/", 1)
    end
  end
end