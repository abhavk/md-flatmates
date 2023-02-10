-module(player).
-export([avg_payoff/3, payoffA/3]).

avg_payoff(Room1, Room2, Strategy) ->
    avg_payoffs(Room1, Room2, Strategy, 100000, 100000, 0). 
    
avg_payoffs(_Room1, _Room2, _Strategy, 0, Maxgames, Totalpayoff) ->
    Totalpayoff/Maxgames;
avg_payoffs(Room1, Room2, Strategy, I, Maxgames, Totalpayoff) ->
    B1 = rand:uniform(1000),
    { A1, A2 } = erlang:apply(strategies, Strategy, [Room1, Room2]), 
    Outcome = game:play(A1, A2, B1, 1000-B1), 
    Payoff = payoffA(Room1, Room2, Outcome), 
    avg_payoffs(Room1, Room2, Strategy, I-1, Maxgames, Totalpayoff + Payoff). 

payoffA(Room1, Room2, Outcome) ->
    { Allocation, Payment } = Outcome,
    case Allocation of
        true -> Room1 - Payment;
        false -> Room2 - Payment
    end.    

payoffB(Room1, Room2, Outcome) ->
    { Allocation, Payment } = Outcome,
    payoffA(Room1, Room2, { not Allocation, 1000-Payment} ).
