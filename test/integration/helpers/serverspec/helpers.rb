require 'rest-client'

module Helpers

  def baseurl
    'http://localhost:8000/requisitions'
  end

  def requisition(name)
    RestClient.get("#{baseurl}/#{name}")
  end
end

RSpec.configure do |c|
  c.include Helpers
end
