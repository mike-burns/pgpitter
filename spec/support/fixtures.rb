module Fixtures
  def read_fixture(filename)
      File.read(Rails.root.join("spec", "fixtures", filename))
  end
end

RSpec.configure do |config|
  config.include Fixtures
end
