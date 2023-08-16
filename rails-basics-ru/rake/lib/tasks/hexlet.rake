# frozen_string_literal: true

require 'csv'

namespace :hexlet do
  desc 'Imports users'
  task :import_users, [:path] => :environment do |_t, args|
    path = args[:path]

    print "#{'=' * 50}\n"
    print "Importing users from file '#{path}'...\n"

    CSV.foreach(path, headers: true, header_converters: :symbol) do |user|
      user[:birthday] = Date.strptime(user[:birthday], '%m/%d/%Y')
      User.create(user)
      print '.'
    end

    print "\n...done\n"
    print "#{'=' * 50}\n"
  end
end
