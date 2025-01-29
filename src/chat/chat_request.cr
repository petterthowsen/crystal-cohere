require "json"

module Cohere::Chat
    class Document
        include JSON::Serializable

        property data : Hash(String, JSONValue)
        property id : String?

        def initialize(
            @data : Hash(String, JSONValue),
            @id : String?
        )
        end
    end

    class Request
        include JSON::Serializable

        struct CitationOptions
            include JSON::Serializable

            enum CitationMode
                Fast
                Accurate
                Off
            end

            getter mode : CitationMode = CitationMode::Fast
        end

        enum SafetyMode
            Contextual
            Strict
            Off
        end

        # Whether to stream the response back
        property stream : Bool

        # The name of a compatible Cohere model (such as command-r or command-r-plus)
        # or the ID of a fine-tuned model.
        property model : String

        # The messages to send to the model.
        property messages : Array(Message)

        # Tools that the LLM can invoke.
        property tools : Array(Tool)

        enum ToolChoice
            Required
            None
        end

        property tool_choice : ToolChoice?

        property strict_tools : Bool?

        # Documents that the LLM can read and cite.
        property documents : Array(Document)

        property citation_options : CitationOptions

        # The safety mode, defaults to Off
        property safety_mode : SafetyMode

        # The maximum number of tokens to generate in the response.
        property max_tokens : Int32?

        # Stop sequences to stop the model from generating further tokens.
        property stop_sequences : Array(String)?

        property temperature : Float64 = 0.3
        property seed : Int32?
        property frequency_penalty : Float64?
        property presence_penalty : Float64?
        property k : Float64?
        property p : Float64?
        property logprobs : Bool?

        def initialize(
            @model : String = "command-r",
            @messages : Array(Message) = [] of Message,
            @stream : Bool = false,
            @tools : Array(Tool) = [] of Tool,
            @documents : Array(Document) = [] of Document,
            @citation_options : CitationOptions = CitationOptions.new,
            @safety_mode : SafetyMode = SafetyMode::Off
        )
        end

        def force_tool_use() : self
            @tool_choice = ToolChoice::Required
            self
        end

        def no_tool_use() : self
            @tool_choice = ToolChoice::None
            self
        end

        def citation_mode_off() : self
            @citation_options.mode = CitationMode::Off
            self
        end
        
        def citation_mode_accurate() : self
            @citation_options.mode = CitationMode::Accurate
            self
        end

        def citation_mode_fast() : self
            @citation_options.mode = CitationMode::Fast
            self
        end

        def with_document(document : Document) : self
            @documents << document
            self
        end

        def with_documents(*documents : Document) : self
            @documents += documents
            self
        end
    end
end