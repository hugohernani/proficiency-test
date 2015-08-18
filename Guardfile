

# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rsspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separetly)
#  * 'just' rspec: 'rspec'

guard 'rspec', cmd: 'bundle exec rspec', :all_after_pass => false do
  watch('spec/spec_helper.rb') { "spec" }

  # watch(%r{^spec/(.*)/?(.*)_spec\.rb$})
  watch(%r{^spec/features/.+_spec\.rb$})
  watch(%r{^spec/controllers/.+_spec\.rb$})
  watch(%r{^spec/models/.+_spec\.rb$})
  watch(%r{^spec/mailers/.+_spec\.rb$})

  watch(%r{^app/models/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }
  # watch(%r{^app/helpers/(.+)\.rb$}) { |m| "spec/helpers/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) do |m|
    [
            # "spec/routing/#{m[1]}_routing_spec.rb",
            "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb"
    ]
  end

  watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
  # watch('config/routes.rb') { "spec/routing" }
  watch('app/controllers/application_controller.rb') { "spec/controllers" }

  # watch(%r{^spec/lib/.+_integration_spec\.rb$})

  watch(%r{^app/views/(.+)/.*\.(erb|haml)$}) do |matches|
    ["spec/controllers/#{matches[1]}_controller_spec.rb"] +
    request_specs(matches[1])
  end

end

# Returns the integration tests corresponding to the given resource.
def request_specs(resource = :all)
  resource == :all ? Dir["spec/requests/*"] : Dir["spec/requests/#{resource}_*.rb"]
end

# Returns the controller specs corresponding to the given resource.
def controller_spec(resource)
  "spec/controllers/#{resource}_controller_spec.rb"
end
