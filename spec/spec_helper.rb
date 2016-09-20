RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
require 'rspec'
require 'httparty'
require 'date'


def url(path)
<<<<<<< HEAD
  ('http://lacedeamon.spartaglobal.com' + path)
end

def create_todo

end

def delete_all()
    r = HTTParty.get url("/todos")
    r.each do |item|
      HTTParty.delete url("/todos/#{item['id']}")
    end
=======
  ('http://lacedeamon.spartaglobal.com/' + path)
>>>>>>> 7de281c88b0fd52ebc59b8f561521ed199b6c343
end
