require "json"

module Cohere::Classify

    struct Example
        include JSON::Serializable

        property text : String
        property label : String

        def initialize(
            @text : String,
            @label : String
        )
        end
    end

    class ClassifyRequest
        include JSON::Serializable

        property model : String
        property preset : String?

        property inputs : Array(String)
        property examples : Array(Example)?

        def initialize(
            @model : String = "embed-multilingual-v2.0",
            @inputs : Array(String) = [] of String,
            @preset : String? = nil,
            @examples : Array(Example)? = nil
        )
        end

        def classify(text : String) : self
            @inputs = [text]
            self
        end

        def classify(*text : String) : self
            @inputs = text
            self
        end

        def classify(texts : Array(String)) : self
            @inputs = texts
            self
        end

        def with_examples(examples : Array(NamedTuple(text: String, label: String))) : self
            @examples = examples.map { |example| Example.new(example[:text], example[:label]) }
            self
        end

        def with_examples(examples : Hash(String, String)) : self
            @examples = examples.map { |example| Example.new(example.key, example.value) }
            self
        end
    end
end