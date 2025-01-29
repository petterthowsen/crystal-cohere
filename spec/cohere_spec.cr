require "./spec_helper"

describe Cohere do
  # TODO: Write tests

  it "can embed text" do
    client = Cohere::Client.new(API_KEY)

    request = Cohere::Embed::EmbedRequest.new(
      model: "embed-english-v2.0",
      input_type: :SearchDocument,
      embedding_types: :Float,
      texts: ["hello world", "cohere is great!"],
    )

    response = client.embed(request)

    puts response.to_pretty_json
  end

  it "can classify text", focus: true do
    client = Cohere::Client.new(API_KEY)

    request = Cohere::Classify::ClassifyRequest.new()
      .with_examples([
        {text: "yeah!", label: "positive"},
        {text: "certainly", label: "positive"},
        {text: "no.", label: "negative"},
        {text: "meh", label: "negative"},
      ])
      .classify([
        "absolutely",
        "maybe",
        "whopsie!"
      ])

    response = client.classify(request)

    puts response.to_pretty_json
  end
end
