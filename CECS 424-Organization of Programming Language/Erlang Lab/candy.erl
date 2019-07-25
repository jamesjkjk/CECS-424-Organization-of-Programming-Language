-module(candy).
-export([candy/4]).

%stops recursion 
candy(A,B,C,D) when (A==B) and (B==C) ->
	1; 
%recursion
candy(A,B,C,D) when A > 0 -> 
	%half the amount of candies
	Ahalf=A div 2,
Bhalf=B div 2,
Chalf=C div 2,

%give half the candies to kid to the right
NewB = Bhalf + Ahalf,
NewC = Chalf + Bhalf,
NewA = Ahalf + Chalf,

%if kid has an odd amount of candy
	if NewA rem 2 == 1 ->
		A2=NewA+1;
	true -> A2=NewA
	end,	
	if NewB rem 2 == 1 ->
		B2=NewB+1;
	true -> B2=NewB
	end,
	if NewC rem 2 == 1 ->
		C2=NewC+1;
	true -> C2=NewC
	end,
	
	%increment turn
	D2=D+1,
	io:fwrite("A:~p B:~p C:~p turns:~p\n", [A2,B2,C2,D2]),
	%call function
	candy:candy(A2,B2,C2,D2).
