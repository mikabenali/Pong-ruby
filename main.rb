require 'gosu'
require 'texplay'
load 'player.rb'
load 'ball.rb'
load 'dimensions.rb'

module ZOrder
    Background, Player, Ball, UI = *0..3
end

class GameWindow < Gosu::Window

    def initialize
        super Dimensions::Window_width, Dimensions::Window_height
        self.caption = "Ruby Pong @Michael_Ben_Ali"

        @background_image = Gosu::Image.new("media/background.jpg", :tileable => true)

        @player_1 = Player.new(1)
        @player_1.warp(30, 200)

        @player_2 = Player.new(2)
        @player_2.warp(Dimensions::Window_width - Dimensions::Player_width - 30, 200)

        @ball = Ball.new
        @direction = [:left, :right].sample

        @score_player_1 = Gosu::Font.new(240)
        @score_player_2 = Gosu::Font.new(240)
    end

    def button_down id
        close if id == Gosu::KbEscape
    end

    def update
        ## Player Logique
        # Humain
        @player_1.move_up if Gosu::button_down? Gosu::KbUp
        @player_1.move_down if Gosu::button_down? Gosu::KbDown
        # @player_2.move_up if Gosu::button_down? Gosu::KbUp
        # @player_2.move_down if Gosu::button_down? Gosu::KbDown
        # IA
        # Player  IA
        # if (rand(20) < rand(13..20)) 
        #     @player_1.move_up if @ball.y + 10 < @player_1.y + rand(10..70)
        #     @player_1.move_down if @ball.y - 10 > @player_1.y
        # end
        if (rand(20) < rand(13..20)) 
            @player_2.move_up if @ball.y + 10 < @player_2.y + rand(10..70)
            @player_2.move_down if @ball.y - 10 > @player_2.y
        end

        # Score
        @player_1.score = @player_1.score + 1 if @ball.x >= Dimensions::Window_width
        @player_2.score = @player_2.score + 1 if @ball.x <= 0

        ## Reset ball position if x = 0
        if @ball.x <= 0
            @direction = :right if @ball.x <= 0
            @ball.default_position if @ball.x <= 0
        elsif @ball.x >= Dimensions::Window_width
            @direction = :left if @ball.x >= Dimensions::Window_width
            @ball.default_position if @ball.x >= Dimensions::Window_width
        end

        ### Ball logique
        @ball.speed_up if rand(1000) < 10
        ## Colision player
        zone_player = Dimensions::Player_height / 4
        # Player 1
        @direction = :up_right if @ball.x <= 50 and @ball.y.between?(@player_1.y - 5, @player_1.y + zone_player)
        @direction = :up_right_middle if @ball.x <= 50 and @ball.y.between?(@player_1.y + zone_player, @player_1.y + (zone_player * 2))
        @direction = :down_left_middle if @ball.x <= 50 and @ball.y.between?(@player_1.y + (Dimensions::Player_height / 2), @player_1.y + (zone_player * 3))
        @direction = :down_left if @ball.x <= 50 and @ball.y.between?(@player_1.y + ((Dimensions::Player_height / 2) + zone_player), @player_1.y + Dimensions::Player_height + 5)
        # Player 2
        @direction = :up_left if @ball.x >= Dimensions::Window_width - 75 and @ball.y.between?(@player_2.y - 5, @player_2.y + zone_player)
        @direction = :up_left_middle if @ball.x >= Dimensions::Window_width - 75 and @ball.y.between?(@player_2.y + zone_player, @player_2.y + zone_player * 2)
        @direction = :down_right_middle if @ball.x >= Dimensions::Window_width - 75 and @ball.y.between?(@player_2.y + (Dimensions::Player_height / 2), @player_2.y + (zone_player * 3))
        @direction = :down_right if @ball.x >= Dimensions::Window_width - 75 and @ball.y.between?(@player_2.y + ((Dimensions::Player_height / 2) + zone_player), @player_2.y + Dimensions::Player_height + 5)
        ## Colision mur
        @direction = :down_left if @ball.y <= 0 and @direction == :up_right
        @direction = :down_left_middle if @ball.y <= 0 and @direction == :up_right_middle
        @direction = :up_right if @ball.y >= Dimensions::Window_height - Dimensions::Ball_height and @direction == :down_left
        @direction = :up_right_middle if @ball.y >= Dimensions::Window_height - Dimensions::Ball_height and @direction == :down_left_middle
        @direction = :down_right if @ball.y <= 0 and @direction == :up_left
        @direction = :down_right_middle if @ball.y <= 0 and @direction == :up_left_middle
        @direction = :up_left if @ball.y >= Dimensions::Window_height - Dimensions::Ball_height and @direction == :down_right
        @direction = :up_left_middle if @ball.y >= Dimensions::Window_height - Dimensions::Ball_height and @direction == :down_right_middle
        ## Action mouvement ball
        @ball.move(@direction)
    end


    def draw
        # Player
        @player_1.draw
        @player_2.draw
        # Ball
        @ball.draw
        # Score
        # @score_player_1.draw('%02d' % @player_1.score, 100, Dimensions::Window_height / 3 - 50, 1, scale_x = 1, scale_y = 1, color = 0xff_fe74c3c, mode = :default)
        # @score_player_2.draw('%02d' % @player_2.score, 460, Dimensions::Window_height / 3 - 50, 1, scale_x = 1, scale_y = 1, color = 0xff_fc0392b, mode = :default)
        # Background
        @background_image.draw(0, 0, ZOrder::Background)
    end
end

window = GameWindow.new
window.show
