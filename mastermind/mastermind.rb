require './game_manager.rb'

gm = GameManager.new

while !gm.end_game?
    system 'clear'
    gm.draw_game
    gm.get_input
end

system 'clear'
gm.draw_game
if gm.victory
    puts "You won!"
else
    puts "You lose!"
end
