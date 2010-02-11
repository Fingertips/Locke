namespace :locke do
  task :stats do
    sh File.expand_path('../../bin/locke', __FILE__)
  end
end