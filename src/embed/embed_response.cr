require "json"
module Cohere::Embed

    enum EmbeddingsType
        Float
        Int8
        Uint8
        Binary
        Ubinary
    end

    alias FloatVector = Array(Float64)
    alias Int8Vector = Array(Int8)
    alias UInt8Vector = Array(UInt8)
    alias BinaryVector = Array(Int8)
    alias UBinaryVector = Array(UInt8)

    alias Embedding = FloatVector | Int8Vector | UInt8Vector | BinaryVector | UBinaryVector
    
    struct Image
        include JSON::Serializable
        getter width : Int64
        getter height : Int64
        getter format : String
        getter bit_depth : Int64
    end

    struct Embeddings
        include JSON::Serializable

        getter float : Array(FloatVector)?
        getter int8 : Array(Int8Vector)?
        getter uint8 : Array(UInt8Vector)?
        getter binary : Array(BinaryVector)?
        getter ubinary : Array(UBinaryVector)?

        def initialize(
            @float : Array(FloatVector)? = nil,
            @int8 : Array(Int8Vector)? = nil,
            @uint8 : Array(UInt8Vector)? = nil,
            @binary : Array(BinaryVector)? = nil,
            @ubinary : Array(UBinaryVector)? = nil
        )
        end
        
        def type() : EmbeddingsType
            case
            when @float
                EmbeddingsType::Float
            when @int8
                EmbeddingsType::Int8
            when @uint8
                EmbeddingsType::Uint8
            when @binary
                EmbeddingsType::Binary
            when @ubinary
                EmbeddingsType::Ubinary
            else
                EmbeddingsType::Float
            end
        end
    end

    struct EmbedResponse
        include JSON::Serializable

        getter id : String
        getter texts : Array(String)
        getter embeddings : Embeddings
        getter texts : Array(String)

        getter images : Array(Image)?
        getter meta : Meta?
    end
end