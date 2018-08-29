require 'site_search/version'
require 'algoliasearch'
require 'logger'

module SiteSearch
  module Adapter
    autoload :Base, 'site_search/adapter/base'
    autoload :Algolia, 'site_search/adapter/algolia'
    autoload :Local, 'site_search/adapter/local'
  end

  autoload :Config, 'site_search/config'
  autoload :Decorator, 'site_search/decorator'
  autoload :Query, 'site_search/query'
  autoload :Result, 'site_search/result'
  autoload :Results, 'site_search/results'

  def self.config
    @config ||= ::SiteSearch::Config.new

    yield @config if block_given?

    @config
  end
end
