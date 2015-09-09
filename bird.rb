class Bird

 attr_reader :x,:y

 def initialize(window)
  @window=window
  @icon=Gosu::Image::load_tiles(@window,"passaro1.png",72,68,false)
  @y=rand(185)+100
  @x=rand(100)+@window.width+71
 end

 def update
  @x=@x-6
  if @x<-71
   @y=rand(185)+100
   @x=rand(100)+@window.width
  end
 end

 def draw
  icon=@icon[Gosu::milliseconds / 40 % @icon.size]
  icon1=icon.draw(@x,@y,3)
 end

 def reset
  @x = rand(100)+@window.width
  @y=rand(450)
 end

end

