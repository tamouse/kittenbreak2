desc "Run tests in CI mode"
task :ci do |t|
  sh "testem ci -P 5 -R dot"
end

desc "Start testem driver"
task :testem do |t|
  require 'launchy'
  Launchy.open "http://localhost:7357"
  sh "testem"
end

task :default => :testem
