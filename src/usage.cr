require "json"

module Cohere
    
    struct BilledUnits
        include JSON::Serializable

        getter images : Int64?
        getter input_tokens : Int64?
        getter output_tokens : Int64?
        getter search_tokens : Int64?
        getter classification : Int64?
    end

    struct Tokens
        include JSON::Serializable

        getter input_tokens : Int64?
        getter output_tokens : Int64?
    end

    struct Usage
        include JSON::Serializable

        getter billed_units : BilledUnits?
        getter tokens : Tokens?
    end
end