#actions that change the state of the game

module Actions

    def self.move_snake(state)
        next_direction = state.curr_direction
        next_position = calc_next_position(state)
        
        if position_is_valid?(state, next_position)
            move_snake_to(state, next_position)
        else
            end_game(state)
        end
    end

    def self.change_direction(state, direction)
        if next_direction_is_valid?(state, direction)
            state.curr_direction = direction
        else
            puts "Invalid direction"
        end
        state
    end

    private

    def self.calc_next_position(state)
        curr_position = state.snake.positions.first
        case state.curr_direction
            when Model::Directions::UP
                return Model::Coord.new(
                    curr_position.row - 1, 
                    curr_position.col
                )
            when Model::Directions::RIGHT
                return Model::Coord.new(
                    curr_position.row, 
                    curr_position.col + 1
                )
            when Model::Directions::DOWN
                return Model::Coord.new(
                    curr_position.row + 1, 
                    curr_position.col
                )
            when Model::Directions::LEFT
                return Model::Coord.new(
                    curr_position.row, 
                    curr_position.col - 1
                )
        end
    end

    def self.position_is_valid?(state, next_position)
        is_invalid = ((next_position.row >= state.grid.rows || next_position.row < 0) || (next_position.col >= state.grid.cols || next_position.col < 0))
        return false if is_invalid
        return !(state.snake.positions.include? next_position)
    end

    def self.move_snake_to(state, next_position)
        new_positions = [next_position] + state.snake.positions[0...-1]
        state.snake.positions = new_positions
        state
    end

    def self.end_game(state)
        state.game_finished = true
        state
    end

    def self.next_direction_is_valid?(state, direction)
        case state.curr_direction
            when Model::Directions::UP
                return true if direction != Model::Directions::DOWN
            when Model::Directions::DOWN
                return true if direction != Model::Directions::UP
            when Model::Directions::RIGHT
                return true if direction != Model::Directions::LEFT
            when Model::Directions::LEFT
                return true if direction != Model::Directions::RIGHT
        end
        return false
    end

end