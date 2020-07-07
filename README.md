# meme-machine

"Make a Learn Chef Meme in this web application.

## Build

    > This is a Ruby application so it is not built. Ideally, you would run some tests. But this project does not have any yet.

## Deploy

    > The assumption is that you have git, Ruby, and ImageMagick installed on the system.

    1. Clone this repository
    2. Install ImageMagick
    3. Run `bundle install`

## Run

    $ rackup

## About

When you run the application through the command `rackup`, the `rackup` command will look for and load the `config.ru` in the current working directory. This file is the Rackup (The 'ru' stands for Rackup) configuration file.

The Rackup configuration file loads the file that contains the website application and then launches this classic style Sinatra application.

The default port that Rackup will launch the application is 9292. When you visit that site you will be executing the code defined in the `lib/service.rb`. The default index page routes to the block of code defined for `get '/'`. It will render the index template found in `lib/views`. This will render a simple form that will request an image.

When you select an image and press 'Upload image', you will be routed to the block of code defined for `post 'packaged'`. This will find the images provided by you and then pass that image to the method (defined in `lib/meme.rb`) that creates the animation. That animated image is then saved to the websites public directory (a temporary directory) and then served up by the habitatized template found in `lib/views`
