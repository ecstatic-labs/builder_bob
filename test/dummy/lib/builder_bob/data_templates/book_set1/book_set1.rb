module BuilderBob
  module DataTemplates
    class BookSet1
      # Use this method to create data however you wish
      def self.generate_data
        Book.where(title: 'Lord of the Rings').first_or_create!
      end
    end
  end
end
