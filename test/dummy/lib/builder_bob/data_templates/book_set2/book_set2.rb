module BuilderBob
  module DataTemplates
    class BookSet2
      # Use this method to create data however you wish
      def self.generate_data
        Book.where(title: 'Game of Thrones').first_or_create!
        Book.where(title: 'A Clash of Kings').first_or_create!
      end
    end
  end
end
