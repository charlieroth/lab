const std = @import("std");
const expect = std.testing.expect;

fn total(values: []const u8) usize {
    var sum: usize = 0;
    for (values) |value| sum += value;
    return sum;
}

test "slices (1)" {
    const values = [_]u8{ 1, 2, 3, 4, 5, 6 };
    const slice = values[0..3];
    try expect(total(slice) == 6);
}

test "slices (2)" {
    const values = [_]u8{ 1, 2, 3, 4, 5, 6 };
    const slice = values[0..3];
    try expect(@TypeOf(slice) == *const [3]u8);
}
