class Window<Gosu::Window

 def initialize
  super(800,505,false)
  @fundo=Gosu::Image.new(self,"fundo1.png",true)
  @fundo1=Gosu::Image.new(self,"fundo2.jpeg",true)
  @trem=Train.new(self)
  @player=Player.new(self)
  @coin=[Coin.new(self)]
  @birds = 3.times.map {Bird.new(self)}
  @run_game=true
  @font=Gosu::Font.new(self,Gosu::default_font_name,20)
  @time=61.0
  @estado="INICIO"
  @dead=0
 end

 def draw
  @fundo.draw 0,0,0
  if @estado=="INICIO"
   @fundo1.draw 0,0,0
  elsif @estado=="JOGANDO"
   @player.draw
   @coin.each {|coin|coin.draw}
   @trem.draw
   @birds.each {|bird| bird.draw}
   @running=true
   @font.draw("Pontos: #{@player.ponto}",10,10,5,1.0,1.0,0xffffff00)
   @font.draw("Tempo: #{@time.to_i}",10,30,5,1.0,1.0,0xffffff00)
  elsif @estado=="FIM"
   t0="GAME OVER"
   t1="VOCE MORREU #{@dead} VEZES"
   t2="PONTUACAO:#{@player.ponto}"
   t3="PRESSIONE R PARA IR PRO MENU"
   x=(self.width)/2-((@font.text_width(t3,1))/2)
   @font.draw(t0,x,100,3,1.0,1.0,0xffffff00)
   @font.draw(t1,x,150,3,1.0,1.0,0xffffffff)
   @font.draw(t2,x,170,3,1.0,1.0,0xffffffff)
   @font.draw(t3,x,190,3,1.0,1.0,0xffffffff)
  end
 end

 def update
  if @estado=="INICIO"
   if button_down? Gosu::Button::KbDelete
    @estado="JOGANDO"
   end
  elsif @estado=="JOGANDO"
   if @running==true
    if @player.hit_by? @birds
     @running=false
     @dead+=1
    elsif @player.death_x
     @running=false
     @dead+=1
    else
     game
    end
   end
   if @running == false
    @running = true
    @player.reset
    @coin.each {|coin|coin.reset}
    @trem.reset
    @birds.each{|bird| bird.reset}
   end
  elsif @estado=="FIM"
   if button_down? Gosu::KbR
    @estado="INICIO"
    @time=61.0
    @player.reset
    @coin.each {|coin|coin.reset}
    @trem.reset
    @birds.each{|bird| bird.reset}
    @player.r_point
    @dead=0
   end
  end
 end

 def game
  if @run_game==false
   if @run_game==false and button_down? Gosu::KbP
    @run_game=true
   end
  else
   @time-=1.0/60.0
      if @time.to_i==0
       @estado="FIM"
      end
   @trem.move
   @player.move
   if button_down? Gosu::KbP
    @run_game=false
   end
   if button_down? Gosu::KbRight
    @player.move_right
   elsif button_down? Gosu::KbLeft
    @player.move_left
   end
   if button_down? Gosu::KbUp
    @player.jump
   end
   @birds.each {|bird| bird.update}
   @coin.each {|coin|coin.update}
   @player.cata_coin @coin
   if (rand(80)<7 and @coin.size<4) then
    @coin.push(Coin.new(self))
   end
  end
 end

end
