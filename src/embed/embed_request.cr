require "json"

module Cohere::Embed
    class EmbedRequest
        include JSON::Serializable

        # Specifies the type of input passed to the model.
        # Required for embedding models v3 and higher.
        #
        # SearchDocument: Used for embeddings stored in a vector database for search use-cases.
        # SearchQuery: Used for embeddings of search queries run against a vector DB to find relevant documents.
        # Classification: Used for embeddings passed through a textt classifier.
        # Clustering: Used fo embeddings run through a clustering algorithm.
        # Image: Used for embeddings with image input.
        enum InputType
            SearchDocument
            SearchQuery
            Classification
            Clustering
            Image
        end

        # Specifies the type of embeddings you want to get back.
        # 
        # Float: Use this when you want to get back the default float embeddings. Valid for all models
        # Int8: Use this when you want to get back signed int8 embeddings. Valid for only v3 models
        # Uint8: Use this when you want to get back unsigned int8 embeddings. Valid for only v3 models
        # Binary: Use this when you want to get back signed binary embeddings. Valid for only v3 models
        # Ubinary: Use this when you want to get back unsigned binary embeddings. Valid for only v3 models
        enum EmbeddingTypes
            Float
            Int8
            Uint8
            Binary
            Ubinary
        end

        enum TruncationMode
            None
            Start
            End
        end

        # The embeddings model to use.
        property model : String

        # The type of input passed to the model
        property input_type : InputType

        # The type of embeddings you want to get back.
        property embedding_types : Array(EmbeddingTypes)

        # The texts to embed
        property texts : Array(String)

        # How to truncate the text input if it exceeds the model's maximum length.
        # If TruncationMode.None is specified, the response will be an error.
        property truncate : TruncationMode

        def initialize(
            @model : String = "embed-english-v2.0",
            @input_type : InputType = InputType::SearchDocument,
            embedding_types : Array(EmbeddingTypes) | EmbeddingTypes = [EmbeddingTypes::Float],
            @texts = [] of String,
            @truncate : TruncationMode = TruncationMode::None
        )
            if embedding_types.is_a?(Array)
                @embedding_types = embedding_types.as(Array(EmbeddingTypes))
            else
                @embedding_types = [embedding_types]
            end
        end
    end
end