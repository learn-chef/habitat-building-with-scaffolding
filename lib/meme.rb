# This method resizes the subject image and then creates an animation sequence
# of the subject being lowered into a Habitat container. The animation sequence
# is then optimized and returned.
#
# @param [ImageMagick] subject The subject provided needs to be an ImageMagick object.
# @return [ImageMagick] the animated image of the subject being packaged.
#
def package_me(subject)
  puts 'Packaging started!'

  # These two images create the container image. The subject will be placed
  # in between them.
  back = Magick::ImageList.new('assets/back.png')
  front = Magick::ImageList.new('assets/front.png')

  # The subject image is likely not the size of our container images so lets
  # resize it to make sure that everything works together nicely.
  new_width = 200
  new_height = new_width * subject.rows / subject.columns
  resized_subject = subject.adaptive_resize(new_width, new_height)

  # Let's pick a starting position, a number of frames to animate, and how
  # much we want to move with each frame.
  start_position = resized_subject.rows * -1
  frames = 20
  movement = 10

  # Create a new animation that will store all the individual images that we
  # create for each frame.
  animation = Magick::ImageList.new

  frames.times do |index|

    # For each frame we want to find the new position of the subject (lower and
    # lower each time). We then need to draw the subject over the background
    # image and then draw the foreground/front images on top of that. Then add
    # it to our animation.

    offset = start_position + index * movement

    subject_over_back = back.composite(resized_subject, Magick::CenterGravity, 0, offset, Magick::OverCompositeOp)

    final = subject_over_back.composite(front, Magick::CenterGravity, 0, 0, Magick::OverCompositeOp)

    # This was a way to view each frame of the animation.
    # final.write("frame_#{index}.gif")
    animation << final

  end

  # The final image should pause for a moment to give people the satisfaction of
  # seeing them in the container before repeating the sequence.
  animation[-1].delay = 200

  # This was required so that the animation looks correct. I have seen this
  # create weird animations for some images.
  animation.optimize_layers(Magick::OptimizePlusLayer)
end
