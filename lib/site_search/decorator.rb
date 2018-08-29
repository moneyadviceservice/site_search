module SiteSearch
  class Decorator < SimpleDelegator
    def page
      super + 1
    end

    def first_page?
      page == 1
    end

    def last_page?
      page == number_of_pages
    end

    def previous_page
      first_page? ? nil : __getobj__.page - 1
    end

    def next_page
      last_page? ? nil : __getobj__.page + 1
    end
  end
end
