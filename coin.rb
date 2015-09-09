class Coin

 attr_reader :x,:y

 def initialize(window)
  @window=window
  @icon=Gosu::Image.new(@window,"moeda.png",false)
  @y=rand(190)+100
  @x=@window.width+47
 end

 def update
  @x=@x-4
  if @x<-47
   @y=rand(190)+100
   @x=@window.width
  end
 end

 def draw
  @icon.draw(@x,@y,4)
 end

 def reset
  @x =@window.width
 end

end
