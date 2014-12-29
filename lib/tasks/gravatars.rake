desc "Import avatars from gravatar URL"
task :import_avatars => :environment do
	puts "Importing avatars from gravatar"
	User.get_gravatars
	puts "Avatars updated."	
end