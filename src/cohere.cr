require "./client"

module Cohere
  VERSION = "0.1.0"

  alias JSONValue = String | Int32 | Int64 | Float32 | Float64 | Bool | Array(JSONValue) | Hash(String, JSONValue)
end