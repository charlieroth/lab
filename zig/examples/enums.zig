const expect = @import("std").testing.expect;

const Direction = enum { North, South, East, West };
const Value = enum(u2) { Zero, One, Two };

test "enum ordinal value" {
    try expect(@enumToInt(Value.Zero) == 0);
    try expect(@enumToInt(Value.One) == 1);
    try expect(@enumToInt(Value.Two) == 2);
}

const Value2 = enum(u32) {
    Hundred = 100,
    Thousand = 1000,
    Million = 1000000,
    Next,
};

test "set enum ordinal value" {
    try expect(@enumToInt(Value2.Hundred) == 100);
    try expect(@enumToInt(Value2.Thousand) == 1000);
    try expect(@enumToInt(Value2.Million) == 1000000);
    try expect(@enumToInt(Value2.Next) == 1000001);
}

const Suit = enum {
    Clubs,
    Spades,
    Diamonds,
    Hearts,
    pub fn is_clubs(self: Suit) bool {
        return self == Suit.Clubs;
    }
};

test "enum method" {
    try expect(Suit.Spades.is_clubs() == false);
    try expect(Suit.Clubs.is_clubs() == true);
}
