require "rspec"

describe :breakfast do
  input = "first_name=Ada&last_name=Lovelace&dob=1815&title=Countess"
  output = {first_name: "Ada", last_name: "Lovelace", dob: "1815", title: "Countess"}
  it "convert returns #{output} for #{input}" do
    expect(convert(input)).to eq(output)
  end
end

def convert(input)
  key_value_pairs = input.split("&").map do |key_value_string|
    key, value = key_value_string.split("=")
    [key.to_sym, value]
  end
  Hash[key_value_pairs]
end
