require "minitest/autorun"
require_relative "../src/actions/actions"
require_relative "../src/model/state"

class ActionTest < Minitest::Test 
    def test_move_nake 
        initial_state = Model::State.new(
                Model::Snake.new([
                    Model::Coord.new(1,1),
                    Model::Coord.new(0,1)
                ]),
                Model::Food.new(rand(5..8), rand(5..12)),
                Model::Grid.new(8, 12),
                Model::Directions::DOWN,
                false
        )

        expected_state = initial_state = Model::State.new(
            Model::Snake.new([
                Model::Coord.new(1,1),
                Model::Coord.new(0,1)
            ]),
            Model::Food.new(rand(5..8), rand(5..12)),
            Model::Grid.new(8, 12),
            Model::Directions::DOWN,
            false
        )

        actual_state = Actions::move_snake(initial_state)
        assert_equal actual_state, expected_state
        
    end
end