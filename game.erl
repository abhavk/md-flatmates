-module(game).
-export([play/4]).

% This mechanism takes in 4 values, player A and B's valuations for each of the rooms. Assumption is that each player's total valuation must be greater than or equal to $1000 (the total rent). 
% It returns a tuple, { Alloc, Apay } where Alloc represents whether A receives room 1 (A receives Room 2 otherwise) 
% The mechanism first calculates the total value from each of the two possible allocations (A -> 1, B -> 2) & (A -> 2, B -> 1), subtracts from it the total payment (=$1,000) and takes the maximum. This allocation is chosen. 
% The payments are then calculated by dividing this surplus between each player. i.e. each player pays $Xi-(M/2), where Xi is the flatmate/player's valuation for the room player i has been allocated, and M is the maximum surplus.  

play(A1, A2, B1, B2) ->
    Surp1 = A1 + B2 - 1000,
    Surp2 = A2 + B1 - 1000,
    if 
        Surp1 > Surp2 -> { true, A1 - (Surp1/2) };
        Surp2 > Surp1 -> { false, A2 - (Surp2/2) };
        Surp1 == Surp2 -> 
            Toss = rand:uniform(2),
            if 
                Toss == 1 -> { true, A1 - (Surp1/2) };
                Toss == 2 -> { false, A2 - (Surp2/2) }
            end
    end.  
