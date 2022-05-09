const std = @import("std");
const expect = std.testing.expect;

test "optional" {
    var found_index: ?usize = null;
    const data = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 10 };
    for (data) |v, i| {
        if (v == 9) found_index = i;
    }
    try expect(found_index == null);
}

test "orelse" {
    var a: ?f32 = null;
    var b = a orelse 0;
    try expect(b == 0);
    try expect(@TypeOf(b) == f32);
}

test "orelse unreachable" {
    var a: ?f32 = 5;

    // the following statements are the equivalent
    var b = a orelse unreachable;
    var c = a.?;

    try expect(b == c);
    try expect(@TypeOf(c) == f32);
}
