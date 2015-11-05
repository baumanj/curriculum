require "rspec"

describe :breakfast do
  input = "first_name=Ada&last_name=Lovelace&dob=1815&title=Countess"
  output = {first_name: "Ada", last_name: "Lovelace", title: "Countess"}
  it "convert returns #{output} for #{input}" do
    expect(convert(input)).to eq(output)
  end
end

def convert(input)
  nil
end