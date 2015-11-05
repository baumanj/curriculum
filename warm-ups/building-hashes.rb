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
end

def convert(input)
  key_value_pairs = input.split("&").map do |key_value_string|
    key, value = key_value_string.split("=")
    [key.to_sym, value.gsub("*", " ")]
  end
  Hash[key_value_pairs]
end
