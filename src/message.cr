require "json"

module Cohere

    struct MessageContent
        include JSON::Serializable

        getter type : String = "text"
        getter text : String
        
        def initialize(
            @type : String = "text",
            @text : String = ""
        )
        end
    end

    struct Source
        include JSON::Serializable
        
        enum SourceType
            Document
            Tool
        end

        getter type : SourceType
        getter id : String?
        getter tool_output : Hash(String, JSONValue)?

        getter document : Hash(String, JSONValue)?

        def initialize(
            @type : SourceType,
            @id : String?,
            @tool_output : Hash(String, JSONValue)?,
            @document : Hash(String, JSONValue)?
        )
        end
    end

    struct Citation
        include JSON::Serializable

        # Start index of the cited snippet in the original source text.
        getter start : Int32?

        # End index of the cited snippet in the original source text.
        getter end : Int32?

        # The text snippet that is being cited.
        getter text : String?

        getter sources : Array(Source)?

        def initialize(
            @start : Int32?,
            @end : Int32?,
            @text : String?,
            @sources : Array(Source)?
        )
        end
    end

    class Message
        include JSON::Serializable

        enum Role
            System
            User
            Assistant
            Tool
        end

        property role : Role
        property content : MessageContent | String

        # For Tools
        property tool_call_id : String?

        def initialize(
            @role : Role,
            @content : MessageContent | String,
            @tool_call_id : String?
        )
        end
    end
end