# Here we are loading the gems that we have defined in the Gemfile.
# @see http://www.sinatrarb.com/
# @see https://rmagick.github.io/
require 'sinatra'
require 'rmagick'

# The 'tmpdir' library ships with Ruby but is not automatically loaded.
# @see http://www.rubydoc.info/stdlib/tmpdir
require 'tmpdir'

# This is where the `package_me` method can be found.
require_relative 'meme'

# This is the front page of the site (e.g. http://localhost:PORT/ )
get '/' do
  # This loads the template file in `lib/views/index.erb`
  erb :index
end

# Create a temporary directory for us to use as a location to store
# the images that we create for the users that visit the site.
tmpdir = Dir.mktmpdir('packaged')
set :public_folder, tmpdir

# The form in the index page's HTML sends the image data to this
# page. The image is found, turned into an ImageMagick object,
# packaged, and then written out to the tmp directory.
post '/packaged' do
  tempfile = params[:file][:tempfile]
  subject = Magick::ImageList.new(tempfile.path)

  result = package_me(subject)

  result.write(File.join(tmpdir,'final.gif'))

  # This loads the template file in `lib/views/packaged.erb`
  erb :packaged
end
