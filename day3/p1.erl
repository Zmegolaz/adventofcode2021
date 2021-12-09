-module(p1).
-export([start/0]).

start() ->
	{ok, InputFile} = file:open('input', [read]),
	{ok, Line} = file:read_line(InputFile),
	BitResult = countBits(InputFile, {ok, Line}, lists:duplicate(length(Line) - 1, 0), 0),
	file:close(InputFile),
    BitLength = bit_size(BitResult),
    <<Result:BitLength>> = BitResult,
    InvertedResult = (bnot Result) band (trunc(math:pow(2, BitLength) - 1)),
	io:format("~w~n", [Result * InvertedResult]),
	ok.

countBits(_, eof, Power, TotalLines) ->
    mostCommonBit(Power, TotalLines, <<>>);

% Skip empty lines.
countBits(InputFile, {ok, [10]}, Power, TotalLines) ->
	countBits(InputFile, file:read_line(InputFile), Power, TotalLines);

countBits(InputFile, {ok, Line}, Power, TotalLines) ->
    NewPower = eachBit(Line, Power, []),
    NewLine = file:read_line(InputFile),
    countBits(InputFile, NewLine, NewPower, TotalLines + 1).

eachBit([10], _, Result) ->
    lists:reverse(Result);

eachBit([Line|LineRest], [Power|PowerRest], Result) ->
    {LineInt, _} = string:to_integer([Line]),
    eachBit(LineRest, PowerRest, [LineInt + Power | Result]).

mostCommonBit([], _, NewBits) ->
    NewBits;

mostCommonBit([FirstBit|RestBits], TotalLines, NewBits) when FirstBit >= TotalLines / 2 ->
    mostCommonBit(RestBits, TotalLines, <<NewBits/bits, 1:1>>);

mostCommonBit([_|RestBits], TotalLines, NewBits) ->
    mostCommonBit(RestBits, TotalLines, <<NewBits/bits, 0:1>>).