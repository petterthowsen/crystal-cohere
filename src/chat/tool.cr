require "json"

module Cohere::Chat

    class FunctionParameter
        include JSON::Serializable
        getter name : String
        getter schema : JSONValue
    end

    class Function
        include JSON::Serializable
        getter name : String
        getter parameters : Array(FunctionParameter)
        getter description : String?

        def initialize(
            @name : String,
            @parameters = [] of FunctionParameter,
            @description : String? = nil
        )
        end
    end

    class Tool
        include JSON::Serializable
        getter name : String
        getter function : Function
        getter description : String?

        def initialize(
            @name : String,
            @function : Function,
            @description : String? = nil,
        )
        end
    end
end