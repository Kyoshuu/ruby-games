class Board
    attr_reader :guessing_zone, :guess_history

    def initialize(chances=12)
        @chances = chances
        default_array = Array.new(4, 'x')
        @guessing_zone = default_array.clone
        @guess_history = Hash.new({:arr => default_array.clone, :p => 'x', :c => 'x'})
    end

    def draw_board
        puts get_board
    end

    def get_board
        board = ""
        board << '-' * 26 << "\n"
        board << "|" << "MASTERMIND".center(24) << "|" << "\n"
        board << "|" << '-' * 24 << "|" << "\n"
        board << "|" << "Guesses".center(15) << "||" << " C " << "|" << " P " << "|" << "\n"
        board << "|" << '-' * 24 << "|" << "\n"
        each_guess { |guess| board << "|" << "#{guess[:arr][0]} | #{guess[:arr][1]} | #{guess[:arr][2]} | #{guess[:arr][3]}".center(15) << "||" << " #{guess[:c]} " << "|" << " #{guess[:p]} " << "|" << "\n" }
        board << "|" << '-' * 24 << "|" << "\n"

        board << "|" << "#{@guessing_zone[0]} | #{@guessing_zone[1]} | #{@guessing_zone[2]} | #{@guessing_zone[3]}".center(24) << "|" << "\n"
        board << '-' * 26 << "\n"
        board
    end

    def clear_guessing_zone
        @guessing_zone.map! { |e| e = 'x' }
    end

    private

    def each_guess
        @chances.times do |i|
            yield @guess_history[i]
        end
    end
end
