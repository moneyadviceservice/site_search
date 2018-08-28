module SiteSearch
  class Decorator
    def self.call(collection)
      new(collection)
    end

    def initialize(collection)
      @collection = collection
    end

    def page
      collection.page + 1
    end

    def first_page?
      page == 1
    end

    def last_page?
      page == collection.number_of_pages
    end

    def previous_page
      first_page? ? nil : collection.page - 1
    end

    def next_page
      last_page? ? nil : collection.page + 1
    end

    private

    attr_reader :collection
  end
end
