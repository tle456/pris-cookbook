require 'rest-client'
require 'rexml/document'

module Helpers

  def baseurl
    'http://localhost:8000/requisitions'
  end

  def requisition(name)
    doc = REXML::Document.new(RestClient.get("#{baseurl}/#{name}").to_str)
    doc.root.attributes.delete 'date-stamp'
    doc.root.attributes.delete 'last-import'
    output = ""
    doc.write output
    output
  end
end

RSpec.configure do |c|
  c.include Helpers
end
