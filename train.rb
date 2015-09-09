class Train

 def initialize(window)
  @window=window
  @icon=Gosu::Image.new(@window,"train.png",true)
  @x=0
  @y=window.height-320
  @a=0
 end

 def draw
  @icon.draw @x, @y, 1
  @icon.draw @x-@icon.width, @y, 1
 end

 def move
  @a=@a+0.06
  if @a>13
   @a=13
  end
  @x=@x-@a
  if @x<0
   @x=@icon.width
  end
 end

 def reset
  @a = 0
 end
end
