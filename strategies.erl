-module(strategies).
-export([equalizing/2, truth_telling/2, almost_equalizing/2, optimal_lying/2, exact_lying/4]).

equalizing(Room1, Room2) ->
    Bid = (Room1 + Room2)/2,
    { Bid , Bid}.

truth_telling(Room1, Room2) ->
    { Room1, Room2 }.

almost_equalizing(Room1, Room2) ->
    Mid = (Room1 + Room2)/2,
    if 
        (Room1 > Room2) -> { Mid + 1, Mid - 1 };
        (Room1 < Room2) -> { Mid - 1, Mid + 1};
        Room1 == Room2 -> { Room1, Room2 }
    end.

optimal_lying(_Room1, _Room2) ->
    { 767, 233 }.

exact_lying(_R1, _R2, Bid1, Bid2) ->
    { Bid1, Bid2 }.
    
