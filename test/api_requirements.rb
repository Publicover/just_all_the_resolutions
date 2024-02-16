# frozen_string_literal: true

require_relative '../test/support/call_and_response_helpers'
require_relative '../test/support/login_helpers'

module ApiRequirements
  class Minitest::Test
    include CallAndResponseHelpers
    include LoginHelpers
  end
end