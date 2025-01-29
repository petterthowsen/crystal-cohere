require "./spec_helper"

describe Cohere do
  # TODO: Write tests

  it "can embed text" do
    client = Cohere::Client.new(API_KEY)

    request = Cohere::Embed::EmbedRequest.new(
      model: "embed-english-v2.0",
      input_type: :SearchDocument,
      embeddings_type: :Float,
      texts: ["hello world", "cohere is great!"],
    )

    response = client.embed(request)

    puts response.to_pretty_json
  end
end
