class Board
    attr_reader :fields

    def initialize
        @fields = Array.new

        (0..8).each { |e| @fields[e] = e }
    end

    def draw_board
        5.times do |i|
            if i % 2 == 1
                puts "---------"
            else
                puts "#{@fields[i/2 * 3]} | #{@fields[1 + i/2*3]} | #{@fields[2 + i/2*3]}"
            end
        end
    end
end

class GameManager
    def initialize
        @board = Board.new
        @player_turn = 'X'
    end

    def play
        puts "Player #{@player_turn} turn."
        puts
        @board.draw_board

        won = check_victory(manage_input)
        unless won
            change_player
            play
        else
            puts
            @board.draw_board
            puts
            puts "Player #{@player_turn} won."
        end
    end

    private

    def manage_input
        puts
        input = gets.strip
        if ('0'..'8').include? input and !['O', 'X'].include? @board.fields[input.to_i]
            @board.fields[input.to_i] = @player_turn
            input.to_i
        else
            puts "Wrong input"
            manage_input
        end
    end

    def check_victory input
        x = input % 3
        y = input / 3

        return true if @board.fields[y*3 + 0] == @board.fields[y*3 + 1] and @board.fields[y*3 + 0] == @board.fields[y*3 + 2]

        return true if @board.fields[0*3 + x] == @board.fields[1*3 + x] and @board.fields[0*3 + x] == @board.fields[2*3 + x]

        return true if x == y and @board.fields[0*3 + 0] == @board.fields[1*3 + 1] and @board.fields[0*3 + 0] == @board.fields[2*3 + 2]

        return true if x + y == 2 and @board.fields[2*3 + 0] == @board.fields[1*3 + 1] and @board.fields[2*3 + 0] == @board.fields[0*3 + 2]

        return false
    end

    def change_player
        if @player_turn == 'X'
            @player_turn = 'O'
        else
            @player_turn = 'X'
        end
    end
end

gm = GameManager.new
gm.play
