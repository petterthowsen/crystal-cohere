API_KEY = begin
    File.read("./spec/api_key.txt")
rescue e
    raise "Please create a file called './spec/api_key.txt' containing your Cohere API key"
end

require "spec"
require "../src/cohere"