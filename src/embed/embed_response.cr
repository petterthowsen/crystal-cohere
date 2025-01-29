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

        getter type : EmbeddingsType

        def initialize(
            @float : Array(FloatVector)? = nil,
            @int8 : Array(Int8Vector)? = nil,
            @uint8 : Array(UInt8Vector)? = nil,
            @binary : Array(BinaryVector)? = nil,
            @ubinary : Array(UBinaryVector)? = nil
        )
            # determine type
            @type = case
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
        
        def vectors() : Array(FloatVector | Int8Vector | UInt8Vector | BinaryVector | UBinaryVector)
            case @type
            when EmbeddingsType::Float
                @float.not_nil!
            when EmbeddingsType::Int8
                @int8.not_nil!
            when EmbeddingsType::Uint8
                @uint8.not_nil!
            when EmbeddingsType::Binary
                @binary.not_nil!
            when EmbeddingsType::Ubinary
                @ubinary.not_nil!
            else
                @float.not_nil!
            end
        end
    end

    struct EmbedResponse
        include JSON::Serializable

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

        getter id : String
        getter texts : Array(String)
        getter embeddings : Embeddings
        getter texts : Array(String)

        getter images : Array(Image)?
        getter meta : Meta?
    end
end