guard :minitest do
  watch(%r{^spec/(.*)_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/#{ m[1] }_spec.rb" }
  watch(%r{^spec/spec_helper\.rb$}) { 'spec' }

  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/application_controller\.rb$}) { 'spec/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "spec/integration/#{ m[1] }_spec.rb" }
  watch(%r{^app/views/(.+)_mailer/.+}) { |m| "spec/mailers/#{ m[1] }_mailer_spec.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{ m[1] }_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/factories/(.+)_factory\.rb$}) { 'spec' }
  watch(%r{^spec/spec_helper\.rb$}) { 'spec' }
end

guard :bundler do
  watch('Gemfile')
end

guard :migrate, run_on_start: true do
  watch(%r{^db/migrate/(\d+).+\.rb})
  watch('db/seeds.rb')
end

guard :livereload do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{app/serializers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|sass|js|html|hamlc|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
end