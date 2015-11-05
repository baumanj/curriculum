require "rspec"
require "faker"

Vote = Struct.new(:question) do

  def self.votes_to_s(num_votes)
    "#{num_votes} #{num_votes == 1 ? 'vote' : 'votes'}"
  end

  def cast(option)
    results[option] += 1
  end

  def results
    @results ||= Hash.new { |hash, key| hash[key] = 0 }
  end

  def vote_count
    results.values.reduce(&:+)
  end

  def winner
    results.max_by(&:last).first
  end

  def stats
    puts "#{self.class.votes_to_s(vote_count)} total"
    results.sort_by(&:first).each do |option, num_votes_for|
      puts "#{option} (#{self.class.votes_to_s(num_votes_for)})"
    end
    puts
    puts "#{winner} is currently in the lead"
  end

end

describe Vote do
  presidential_vote = Vote.new("Who should run for president in 2016?")
  presidential_vote.cast("Hillary")
  presidential_vote.cast("Ada")
  presidential_vote.cast("Ada")

  it "returns the string that is passed in as an argument when the object is created for #question" do
    question = Faker::Lorem.sentence
    expect(Vote.new(question).question).to eq(question)
  end

  it "returns a hash with keys of the given answers and value of the number of votes that key has receieved for #results" do
    expect(presidential_vote.results).to eq({"Hillary" => 1, "Ada" => 2})
  end

  context "Silver" do

    it "returns a string of the top entry for #winner" do
      expect(presidential_vote.winner).to eq("Ada")
    end

    it "returns returns the number of total votes for #vote_count" do
      expect(presidential_vote.vote_count).to eq(3)
    end

  end

  context "Gold" do
    it "prints the current status when #stats is called" do
      stats_output = <<END
3 votes total
Ada (2 votes)
Hillary (1 vote)

Ada is currently in the lead
END
      expect { presidential_vote.stats }.to output(stats_output).to_stdout
    end
  end

end
