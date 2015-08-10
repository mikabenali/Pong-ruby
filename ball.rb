load 'dimensions.rb'

class Ball

    attr_accessor :x, :y

    def initialize
        @image = Gosu::Image.new("media/ball.png", :tileable => true)
        default_position
        default_speed
    end

    def default_position 
        tiers = Dimensions::Window_height / 3
        @x = (Dimensions::Window_width / 2) - Dimensions::Ball_width
        @y = rand(tiers..tiers*3)
    end

    def default_speed
        @top = 12 * 1.2
        @middle = 8* 1.2
        @bottom = 4* 1.2
    end

    def speed_up
        speed_up = 1.1
        if speed_up < 1.3
            @top *= speed_up
            @middle *= speed_up
            @bottom *= speed_up
            speed_up += 0.1
        end
    end

    def move (direction)
        default_speed if direction.eql? :right or direction.eql? :left
        move_right if direction.eql? :right
        move_left if direction.eql? :left
        
        move_up_left if direction.eql? :up_left
        move_up_left_middle if direction.eql? :up_left_middle
        move_down_left if direction.eql? :down_left
        move_down_left_middle if direction.eql? :down_left_middle

        move_up_right if direction.eql? :up_right
        move_up_right_middle if direction.eql? :up_right_middle
        move_down_right if direction.eql? :down_right
        move_down_right_middle if direction.eql? :down_right_middle
    end

    def draw
        @image.draw(@x, @y, ZOrder::Ball)
    end

    private

    def move_right
        @x += @middle
    end

    def move_left
        @x -= @middle
    end

    def move_up_left
        @x -= @middle
        @y -= @middle
    end
    def move_up_left_middle
        @x -= @top
        @y -= @bottom
    end

    def move_up_right
        @x += @middle
        @y -= @middle
    end
    def move_up_right_middle
        @x += @top
        @y -= @bottom
    end
    def move_up_right
        @x += @middle
        @y -= @middle
    end

    def move_down_left
        @x += @middle
        @y += @middle
    end
    def move_down_left_middle
        @x += @top
        @y += @bottom
    end

    def move_down_right
        @x -= @middle
        @y += @middle
    end
    def move_down_right_middle
        @x -= @top
        @y += @bottom
    end

end
