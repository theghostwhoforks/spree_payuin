require 'rails/generators'
require 'rails/generators/migration'     

module SpreePayuin
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include ::Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      
      desc "add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "create_payuin_payment_transactions.rb", "db/migrate/create_payuin_payment_transactions.rb"
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_payuin'
      end

      def run_migrations
         res = ask "Would you like to run the migrations now? [Y/n]"
         if res == "" || res.downcase == "y"
           run 'bundle exec rake db:migrate'
         else
           puts "Skiping rake db:migrate, don't forget to run it!"
         end
      end
    end
  end
end
