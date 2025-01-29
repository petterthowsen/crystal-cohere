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

    struct Meta
        include JSON::Serializable

        struct APIVersion
            include JSON::Serializable

            getter version : String
            getter is_deprecated : Bool?
            getter is_experimental : Bool?
        end

        getter api_version : APIVersion?

        getter billed_units : BilledUnits?

        getter tokens : Tokens?

        getter warnings : Array(String)?
    end
end