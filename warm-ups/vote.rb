require "rspec"
require "faker"

class Vote
  attr_accessor :question

  def initialize(question)
  end

  def cast(in_favor_of)
  end

  def results
  end
end

describe Vote do
  it "returns the string that is passed in as an argument when the object is created for #question" do
    question = Faker::Lorem.sentence
    expect(Vote.new(question).question).to eq(question)
  end

  it "returns a hash with keys of the given answers and value of the number of votes that key has receieved for #results" do
    vote = Vote.new("Who should run for president in 2016?")
    vote.cast("Hillary")
    vote.cast("Ada")
    vote.cast("Ada")
    expect(vote.results).to eq({"Hillary" => 1, "Ada" => 2})
  end
end
