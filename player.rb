load 'dimensions.rb'

class Player

    attr_accessor :x, :y, :score

    def initialize player
        if player == 1
            @image = Gosu::Image.new("media/player_1.png", :tileable => true)
        else
            @image = Gosu::Image.new("media/player_2.png", :tileable => true)
        end
        @x = @y = 0
        @score = 0
    end

    def warp (x, y)
        @x, @y = x, y
    end

    def move_up
        @y -= 15 if @y > (Dimensions::Window_height - Dimensions::Window_height) + 10
    end

    def move_down
        @y += 15 if @y < (Dimensions::Window_height - Dimensions::Player_height) - 10
    end

    def draw
        @image.draw(@x, @y, ZOrder::Player)
    end

end
