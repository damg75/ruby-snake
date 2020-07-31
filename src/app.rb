#Is the engine of our app

require_relative "view/ruby2d"
require_relative "model/state"
require_relative "actions/actions"



class App
    def initialize
        @state = Model::initial_state
        @speed = 0.5
    end

    def start
        @view = View::Ruby2dView.new(self)
        timer_thread = Thread.new { init_timer(@view) }
        @view.start(@state)
        timer_thread.join
    end
    
    def init_timer(view)
        snake_length = @state.snake.positions.length
        # puts @state.snake.positions.class
        loop do
            if @state.game_finished
                puts "Game finished"
                puts "Score: #{@state.snake.positions.length-2}"
                break
            end
            @state = Actions::move_snake(@state)
            view.render(@state)
            if snake_length < @state.snake.positions.length
                snake_length = @state.snake.positions.length
                calculate_speed_increment
            end
            sleep @speed
        end
    end

    def send_action(action, params)
        new_state = Actions.send(action, @state, params)
        if new_state.hash != @state.hash
            @state = new_state
            @view.render(@state)
        end
    end

    private 

    def calculate_speed_increment
        if @speed > 0.001
            @speed = @speed - (@speed * 0.05)
            if(@speed < 0.001)
                @speed = 0.001
            end
        end
    end
end


app = App.new
app.start