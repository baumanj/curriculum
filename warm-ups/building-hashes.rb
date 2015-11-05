require "rspec"

describe :convert do

  it "passes breakfast" do
    input = "first_name=Ada&last_name=Lovelace&dob=1815&title=Countess"
    output = {first_name: "Ada", last_name: "Lovelace", dob: "1815", title: "Countess"}
    expect(send(subject, input)).to eq(output)
  end

  it "passes lunch" do
    input = "name=Ada*Lovelace&father=Lord*Byron&mother=Anne*Isabella*Milbanke"
    output = {name: "Ada Lovelace", father: "Lord Byron", mother: "Anne Isabella Milbanke"}
    expect(send(subject, input)).to eq(output)
  end

  it "passes dinner" do
    input = "person[first_name]=Ada&person[last_name]=Lovelace&century=19th&topic=analytical*engine"
    output = {person: {first_name: "Ada", last_name: "Lovelace"},
              century: "19th", topic: "analytical engine"}
    expect(send(subject, input)).to eq(output)
  end

  it "passes dessert" do
    input = "person[first_name]=Ada&person[last_name]=Lovelace&skills[]=programming&skills[]=math"
    output = {person: {first_name: "Ada", last_name: "Lovelace"},
              skills: ["programming", "math"]}
    expect(send(subject, input)).to eq(output)
  end

end

def convert(input)
  Hash.new { |hash, key| hash[key] = {} }.tap do |hash|
    input.split("&").each do |key_value_string|
      key, value = key_value_string.split("=")
      value.gsub!("*", " ")

      if (md = key.match(/(?<subhash>.*)\[(?<subhash_key>.*)\]/))
        hash[md[:subhash].to_sym][md[:subhash_key].to_sym] = value
      else
        hash[key.to_sym] = value
      end
    end
  end
end
