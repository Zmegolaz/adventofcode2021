-module(p1).
-export([start/0]).

start() ->
	{ok, InputFile} = file:open('input', [read]),
	Command = file:read_line(InputFile),
	currentPos(InputFile, Command, 0, 0),
	file:close(InputFile),
	ok.

currentPos(_, eof, Pos, Depth) ->
	io:format("~w~n", [Pos * Depth]),
	ok;

% Skip empty lines.
currentPos(InputFile, {ok, [10]}, Pos, Depth) ->
	currentPos(InputFile, file:read_line(InputFile), Pos, Depth),
	ok;

currentPos(InputFile, {ok, Command}, Pos, Depth) ->
	[Direction, DistanceStr] = string:split(Command, " "),
	{Distance, _} = string:to_integer(DistanceStr),
	case Direction of
		"forward" ->
			currentPos(InputFile, file:read_line(InputFile), Pos + Distance, Depth);
		"up" ->
			currentPos(InputFile, file:read_line(InputFile), Pos, Depth - Distance);
		"down" ->
			currentPos(InputFile, file:read_line(InputFile), Pos, Depth + Distance)
	end.

