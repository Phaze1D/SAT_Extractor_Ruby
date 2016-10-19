
path = '/Users/david/Projects/NealsYard/RubyFacturasExt/lib'
ActiveRecord::Base.logger = Logger.new(path + '/config/debug.log')
configuration = YAML::load(File.open(path + '/config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['production'])


# ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, File.open(path + '/db/schema.rb', 'w'))
