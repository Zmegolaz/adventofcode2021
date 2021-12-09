-module(p2).
-export([start/0]).

start() ->
	{ok, InputFile} = file:open('input', [read]),
	Command = file:read_line(InputFile),
	currentPos(InputFile, Command, 0, 0, 0),
	file:close(InputFile),
	ok.

currentPos(_, eof, Pos, Depth, _) ->
	io:format("~s~n", [integer_to_list(Pos * Depth)]),
	ok;

% Skip empty lines.
currentPos(InputFile, {ok, [10]}, Pos, Depth, Aim) ->
	currentPos(InputFile, file:read_line(InputFile), Pos, Depth, Aim),
	ok;

currentPos(InputFile, {ok, Command}, Pos, Depth, Aim) ->
	[Direction, DistanceStr] = string:split(Command, " "),
	{Distance, _} = string:to_integer(DistanceStr),
	case Direction of
		"forward" ->
			currentPos(InputFile, file:read_line(InputFile), Pos + Distance, Depth + Aim * Distance, Aim);
		"up" ->
			currentPos(InputFile, file:read_line(InputFile), Pos, Depth, Aim - Distance);
		"down" ->
			currentPos(InputFile, file:read_line(InputFile), Pos, Depth, Aim + Distance)
	end,
	ok.


