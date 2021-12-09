-module(p1).
-export([start/0]).

start() ->
	{ok, InputFile} = file:open('input', [read]),
	FirstLine = file:read_line(InputFile),
	SecondLine = file:read_line(InputFile),
	countIncreases(InputFile, FirstLine, SecondLine, 0),
	file:close(InputFile),
	ok.

countIncreases(_, _, eof, Increases) ->
	io:format("~w~n", [Increases]),
	ok;

% Skip empty lines.
countIncreases(InputFile, {ok, OldLine}, {ok, [10]}, Increases) ->
	countIncreases(InputFile, {ok, OldLine}, file:read_line(InputFile), Increases),
	ok;

countIncreases(InputFile, {ok, OldLine}, {ok, NewLine}, Increases) ->
	{OldLineInt, _} = string:to_integer(OldLine),
	{NewLineInt, _} = string:to_integer(NewLine),
	case OldLineInt < NewLineInt of
		true ->
			countIncreases(InputFile, {ok, NewLine}, file:read_line(InputFile), Increases+1);
		false ->
			countIncreases(InputFile, {ok, NewLine}, file:read_line(InputFile), Increases)
	end.

