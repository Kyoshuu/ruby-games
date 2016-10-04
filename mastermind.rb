class Board

    def initialize(size=12)
        @size = size
        @guessing_zone = Array.new(4, 'x')
        @guess_history = Hash.new({:arr => Array.new(4, 'x'), :p => 'x', :c => 'x'})
    end

    def draw_board
        puts '-' * 26
        puts "|" << "MASTERMIND".center(24) << "|"
        puts "|" << '-' * 24 << "|"
        puts "|" << "Guesses".center(15) << "||" << " C " << "|" << " P " << "|"
        puts "|" << '-' * 24 << "|"
        each_guess { |guess| puts "|" << "#{guess[:arr][0]} | #{guess[:arr][1]} | #{guess[:arr][2]} | #{guess[:arr][3]}".center(15) << "||" << " #{guess[:c]} " << "|" << " #{guess[:p]} " << "|" }
        puts "|" << '-' * 24 << "|"

        puts "|" << "#{@guessing_zone[0]} | #{@guessing_zone[1]} | #{@guessing_zone[2]} | #{@guessing_zone[3]}".center(24) << "|"
        puts '-' * 26
    end

    private

    def each_guess
        @size.times do |i|
            yield @guess_history[i]
        end
    end
end
