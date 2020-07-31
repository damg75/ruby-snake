#Represents the state of our app

module Model

    module Directions 
        UP = :up
        RIGHT = :right
        DOWN = :down
        LEFT = :left
    end

    class Coord < Struct.new(:row, :col)
    end

    class Food < Coord
    end

    class Snake < Struct.new(:positions)
    end

    class Grid < Struct.new(:rows, :cols)
    end

    class State < Struct.new(:snake, :food, :grid, :curr_direction, :game_finished)
    end

    def self.initial_state
        Model::State.new(
            Model::Snake.new([
                Model::Coord.new(1,1),
                Model::Coord.new(0,1)
            ]),
            Model::Food.new(rand(5..7), rand(5..11)),
            Model::Grid.new(8, 12),
            Directions::DOWN,
            false
        )
    end

end