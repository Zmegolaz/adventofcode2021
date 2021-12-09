-module(p2).
-export([start/0]).

start() ->
	{ok, InputFile} = file:open('input', [read]),
	{ok, FirstLine} = file:read_line(InputFile),
	{FirstLineInt, _} = string:to_integer(FirstLine),
	{ok, SecondLine} = file:read_line(InputFile),
	{SecondLineInt, _} = string:to_integer(SecondLine),
	{ok, ThirdLine} = file:read_line(InputFile),
	{ThirdLineInt, _} = string:to_integer(ThirdLine),
	FourthLine = file:read_line(InputFile),
	countIncreases(InputFile, FirstLineInt, SecondLineInt, ThirdLineInt, FourthLine, 0),
	file:close(InputFile),
	ok.

countIncreases(_, _, _, _, eof, Increases) ->
	io:format("~s~n", [integer_to_list(Increases)]),
	ok;

% Skip empty lines.
countIncreases(InputFile, FirstLine, SecondLine, ThirdLine, {ok, [10]}, Increases) ->
	countIncreases(InputFile, FirstLine, SecondLine, ThirdLine, file:read_line(InputFile), Increases),
	ok;

countIncreases(InputFile, FirstLineInt, SecondLineInt, ThirdLineInt, {ok, FourthLine}, Increases) ->
	{FourthLineInt, _} = string:to_integer(FourthLine),
	case FirstLineInt + SecondLineInt + ThirdLineInt < SecondLineInt + ThirdLineInt + FourthLineInt of
		true -> NewIncreases = Increases + 1;
		false -> NewIncreases = Increases
	end,
	countIncreases(InputFile, SecondLineInt, ThirdLineInt, FourthLineInt, file:read_line(InputFile), NewIncreases).

