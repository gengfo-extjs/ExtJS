require "test/unit"
require File.expand_path(File.dirname(__FILE__) + "/../lib/metrocardsystem")

class MetroCardTest < Test::Unit::TestCase
	def test_cost_within_3km
		card = MetroCard.new
		
		card.setAmount(100);
		peopleSquare = Stop.new
		peopleSquare.setIndex(6);
		huangpiRoad = Stop.new
		huangpiRoad.setIndex(7);
		
		card.enter(peopleSquare, 0);
		card.exit(huangpiRoad, 10);
		assert_equal(97, card.getAmount());
	end

	def test_cost_between_3km_and_8km
		card = MetroCard.new
		card.setAmount(100);
		peopleSquare = Stop.new
		peopleSquare.setIndex(6);
		huangpiRoad = Stop.new
		huangpiRoad.setIndex(10);
		
		card.enter(peopleSquare, 0);
		card.exit(huangpiRoad, 10);
		assert_equal(96, card.getAmount());
	end	
	
	def test_cost_interchange
		card = MetroCard.new
		card.setAmount(100);
		hanzhongRoad = Stop.new
		hanzhongRoad.setIndex(6);
		ralwayStation = Stop.new
		ralwayStation.setIndex(7);
		baoshanRoad = Stop.new
		baoshanRoad.setIndex(8);
		
		card.enter(hanzhongRoad, 0);
		card.exit(ralwayStation, 10);
		assert_equal(97, card.getAmount());

		card.enter(ralwayStation, 30);
		assert_equal(true, card.getIsInterchange())
		card.exit(baoshanRoad, 60);
		assert_equal(97, card.getAmount());
		
	end	
end
	