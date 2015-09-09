class Player

 attr_reader :x,:died,:y,:ponto

 def initialize(window)
  @window=window
  @icon=Gosu::Image::load_tiles(@window,"player.png",32,64,true)
  @x=450
  @y=@window.height-215
  @died=false
  @a=0
  @e=0
  @b=0
  @c=26
  @d=0
  @ponto=0
 end


 def r_point
  @ponto=0
 end

 def draw
  if @died==true || @x==0
  else
   icon=[@icon[35],@icon[34],@icon[33]]
   icon=icon[Gosu::milliseconds / 80 % icon.size]
   icon.draw(@x,@y,3)
  end
 end

 def cata_coin(coins)
  coins.reject! do |coin|
   if Gosu::distance(coin.x+24,coin.y+24,@x+16,@y+32)<30
    true
    @ponto=@ponto+rand(15)+1
   else
    false
   end
  end
 end

 def hit_by?(birds)
  @died=birds.any?{|bird|Gosu::distance(bird.x+34,bird.y+36,@x+16,@y+32)<34}
  if @died
   @ponto-=6
  end
 end

 def death_x
  if @x==0
   @ponto-=10
  end
 end
 
 def move_right
  @b=@b+0.1
  if @b>7
   @b=7
  end
  @x=@x+@b
  if @x>@window.width-@icon[34].width
   @x=@window.width-@icon[34].width
  end
 end

 def move_left
  @x=@x-9
  if @x<0
   @x=0
   @died=true
  end
 end

 def jump
  @c=@c-0.9
  if @c<0
   @c=0
  end
  @y=@y-@c
  if @y>@window.height-215
   @y=@window.height-215
  end
 end

 def reset
  @y=@window.height-215
  @x = 450
  @a=0
  @b=0
  @c=28
  @d=0
  @e=0
 end

 def move
  @d=@d+0.4
  if @d>11
   @d=11
  end
  @y=@y+@d
  if @y>@window.height-215 
   @y=@window.height-215
   @c=28
  end
  @a=@a+0.06
  if @a>5
   @a=5
  end 
  @x=@x-@a
  if @x<0
   @x=0
   if @x==0
    @died=true
   end
  end
 end

end
