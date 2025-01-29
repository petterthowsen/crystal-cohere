require "json"

module Cohere::Chat

    struct Logprobs
        include JSON::Serializable

        getter token_ids : Array(Int64)
        getter text : String?
        getter logprobs : Array(Float64)?
    end

    struct ChatResponse
        include JSON::Serializable
        
        enum FinishReason
            Complete
            StopSequence
            MaxTokens
            ToolCall
            Error
        end

        getter id : String

        getter finish_reason : FinishReason

        getter message : Message

        getter usage : Usage?

        getter logprobs : Array(Logprobs)?
    end
end