module SiteSearch
  class Result
    attr_reader :title, :description, :link, :raw

    def initialize(response_result)
      @title = response_result[:title]
      @description = response_result[:description]
      @link = response_result[:link]
      @raw = response_result[:raw]
    end

    def to_s
      "#<SiteSearch::Result
          @title=#{@title},
          @link=#{@link},
         @description=#{@description}>".gsub(/\n\s*/, ' ')
    end
  end
end
