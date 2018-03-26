# SiteSearch

Add search capability using local or external services for site searching.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'site_search'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install site_search

## Usage

The gem uses the adapter pattern to select the search service you need.
You can also setup the logger:


```
  SiteSearch.config do |config|
    config.adapter = :algolia
    config.logger = Rails.logger
  end
```

### Algolia

To do a query you can use the query class.
An example below search through "retirement" passing algolia specific
options:

```
SiteSearch::Query.new(
  'retirement',
  options: {
    index: 'pages',
    highlightPreTag: '<br>',
    highlightPostTag: '</br>',
    page: 1,
    hitsPerPage: 10
  }
).results
```

### Returning results for all adapters

This will return a collection of SiteSearch::Result:

```
[
  #<SiteSearch::Result @title=<br>Retirement</br> income tool,
    @link=/en/tools/retirement-income-tool, @description=<br>Retirement</br> income
    tool>
  #<SiteSearch::Result @title=<br>Retirement</br> adviser directory,
    @link=/en/tools/retirement-adviser-directory, @description=FCA regulated
    financial advisers for help with <br>retirement</br> planning, inheritance tax,
    equity release, wills and probate, long-term care and pension transfers.>
]
```

## Development

### Setup

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `rake spec` to run the tests.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`,
and then run `bundle exec rake release`, which will create a git tag for the
version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

The project uses dotenv gem so you can copy the env sample file:

```
 cp .env.sample .env
```

### Add new adapter

You need to create an object that responds to #options and #search(query).
Inheriting from ::SiteSearch::Adapter::Base will provide a basic
implementation.

An example:

```
  module SiteSearch
    module Adapter
      class MyAdapter < ::SiteSearch::Adapter::Base
        def search(query)
          {
            results: [],
            page: 0,
            query: query,
            total_results: 0,
            per_page: 0,
            number_of_pages: 0
          }
        end
      end
    end
  end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moneyadviceservice/site_search. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SiteSearch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/moneyadviceservice/site_search/blob/master/CODE_OF_CONDUCT.md).
