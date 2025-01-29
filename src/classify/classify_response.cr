require "json"

module Cohere::Classify
    
    struct Label
        include JSON::Serializable

        getter confidence : Float64?
    end

    enum ClassificationType
        SingleLabel
        MultiLabel
    end

    struct Classification
        include JSON::Serializable

        getter id : String
        getter predictions : Array(String)
        getter confidences : Array(Float64)
        getter labels : Hash(String, Label)
        getter classification_type : ClassificationType
        getter input : String?
    end

    class ClassifyResponse
        include JSON::Serializable

        property classifications : Array(Classification)
    end
end