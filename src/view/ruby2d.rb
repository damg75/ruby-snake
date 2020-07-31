#Renders the view of our app

require "ruby2d"
require_relative "../model/state"

module View

    class Ruby2dView

        def initialize(app)
            @pixel_size = 50
            @app = app
        end

        def start(state)
            extend Ruby2D::DSL
            set(
                title: "Simple Snake",
                width: @pixel_size * state.grid.cols, 
                height: @pixel_size * state.grid.rows
            )
            on :key_down do |event|
                handle_key_event(event)
                # puts event.key
            end
            show
        end

        def render(state)
            extend Ruby2D::DSL
            close if state.game_finished
            render_snake(state)
            render_food(state)
        end
        
        private

        def render_food(state)
            @food.remove if @food
            extend Ruby2D::DSL
            food = state.food
            @food = Square.new(
                x: food.col * @pixel_size, y: food.row * @pixel_size,
                size: @pixel_size,
                color: 'red',
            )
        end

        def render_snake(state)
            @snake_positions.each(&:remove) if @snake_positions
            extend Ruby2D::DSL
            snake = state.snake
            @snake_positions = snake.positions.map do |pos|
                Square.new(
                    x: pos.col * @pixel_size, y: pos.row * @pixel_size,
                    size: @pixel_size,
                    color: 'green',
                )
            end
        end

        def handle_key_event(event)
            # puts event.key
            case event.key
                when "up"
                    @app.send_action(:change_direction, Model::Directions::UP)
                when "down"
                    @app.send_action(:change_direction, Model::Directions::DOWN)
                when "right"
                    @app.send_action(:change_direction, Model::Directions::RIGHT)
                when "left"
                    @app.send_action(:change_direction, Model::Directions::LEFT)


                when "w"
                    @app.send_action(:change_direction, Model::Directions::UP)
                when "s"
                    @app.send_action(:change_direction, Model::Directions::DOWN)
                when "d"
                    @app.send_action(:change_direction, Model::Directions::RIGHT)
                when "a"
                    @app.send_action(:change_direction, Model::Directions::LEFT)
            end
        end

    end

end