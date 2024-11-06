# frozen_string_literal: true

# Store module version
module Ovh
  def self.version = File.read(File.expand_path('../OVH_VERSION', __dir__)).strip
end
