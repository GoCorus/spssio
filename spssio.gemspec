# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "spssio"
  s.summary = "Ruby bindings for spssdio"
  s.version = "0.1.0"
  s.author = "..."
  s.files = [
    "lib/spssio.rb",
    "bin/change_install_names.rb",
    "lib/spssio/libspssdio.rb",
    "lib/spssio/status.rb",
    "lib/spssio/reader.rb",
    "lib/spssio/api.rb",
    "lib/spssio.rb"
  ] + Dir["ext/**/*"]

  s.description = "Ruby bindings for IBM SPSS Statistics Input/Output Module"
  s.email = "..."
  s.homepage = "cor.us"
  # s.licenses = ?
  # s.metadata = ?
  s.date = "2019-12-10"

  s.add_development_dependency "rspec", "~> 0"
  s.add_runtime_dependency "ffi", "~> 1.0"
end
