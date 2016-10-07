require './board.rb'

class GameManager
    attr_reader :victory, :code

    def initialize
        @victory = false
        @tries = 11
        @board = Board.new
        @instruction_lines = File.open('instruction.txt').read.gsub(/\r\n?/, "\n").lines("\n")

        @code = (1..6).to_a.shuffle[1..4]
    end

    def draw_game
        @board.get_board.lines("\n").each_with_index do |e, i|
            puts e.chomp << " "*10 << (@instruction_lines[i].nil? ? "" : @instruction_lines[i])
        end
    end

    def get_input
        input = gets

        if matched = input.match(/([1-4]) ([1-6])/)
            pos, value = matched.captures
            @board.guessing_zone[pos.to_i-1] = value
        elsif input.match(/^confirm$/)
            p, c = check_match
            @board.guess_history[@tries] = { :arr => @board.guessing_zone.clone, :c => c, :p => p }
            @board.clear_guessing_zone
            @tries -= 1
            @victory = true if p == 4
        elsif input.match(/^exit$/)
            system 'clear'
            exit
        end
    end

    def end_game?
        return true if @victory or @tries < 0
        false
    end

    private

    def check_match
        p = c = 0

        @code.each_with_index do |e, i|
            if e == @board.guessing_zone[i].to_i
                p += 1
            elsif @board.guessing_zone.include? e.to_s
                c += 1
            end
        end
        [p, c]
    end
end
