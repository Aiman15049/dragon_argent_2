require "guard/rspec/dsl"
dsl = Guard::RSpec::Dsl.new(self)

rspec = dsl.rspec
ruby = dsl.ruby
rails = dsl.rails(view_extensions: %w(erb haml jbuilder slim))

guard :rspec, cmd: "spring rspec" do


  # RSpec files
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)



  watch(rails.controllers) do |m|
    [
      rspec.spec.("routing/#{m[1]}_routing"),
      rspec.spec.("controllers/#{m[1]}_controller"),
      rspec.spec.("acceptance/#{m[1]}")
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

end

guard :rubocop, all_on_start: false, notification: true do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
