require 'pathname'
require "rack/google-analytics"
require 'nokogiri'


# Reload the browser automatically whenever files change
configure :development do
 activate :livereload
end

activate :autoprefixer do |config|
  config.browsers = ['last 3 versions', 'Explorer >= 8']
end

activate :dotenv

activate :directory_indexes

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

sprockets.append_path File.join root, 'bower_components'

ready do
# Build the Puzzles
  data.puzzles.first[1].each_with_index do |puzzle, puzzle_index|
      solution_resources = sitemap.resources.select do |resource|
        resource.path.start_with?("puzzles/#{puzzle['puzzleDir']}")
      end

      solutions = solution_resources.map do |resource|
        filename = Pathname.new(resource.path).basename(".txt")
        {
          filename: filename,
          language: data.languages[filename.to_s],
          url: "http://www.ineverylang.com/#{puzzle.puzzleDir}/#{filename.to_s}",
          source: resource.metadata[:page]["source"],
          puzzle: puzzle,
          code: resource.render
        }
      end

      proxy "#{puzzle['puzzleDir']}.html", "puzzle.html", :locals => { :solutions => solutions, puzzle: puzzle, index: puzzle_index, :title => "#{puzzle['prettyName']} Solutions In Every Language", :description => Nokogiri::HTML(puzzle['description']).text}
      proxy "#{puzzle['puzzleDir']}.json", "puzzlejson.html", :locals => { :solutions => solutions, puzzle: puzzle}, :layout => false
      proxy "ddg-#{puzzle['puzzleDir']}.json", "ddg-puzzlejson.html", :locals => { :solutions => solutions, puzzle: puzzle}, :layout => false

      solutions.each do |solution|
        solution[:index] = puzzle_index
        solution[:title] = "#{puzzle['prettyName']} in #{solution[:language]}"
        solution[:smallFooter] = "true"
        solution[:description] = Nokogiri::HTML(puzzle['description']).text
        proxy "#{puzzle['puzzleDir']}/#{solution[:filename]}.html", "solution.html", :locals => solution
      end

  end
end

ignore "puzzle.html"
ignore "puzzlejson.html"
ignore "ddg-puzzlejson.html"
ignore "solution.html"

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash

  use Rack::GoogleAnalytics, :tracker => ENV['GA_CODE']
end
