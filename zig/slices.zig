const std = @import("std");
const expect = std.testing.expect;
const mem = std.mem;

// Slices can be thought of as a pair:
// 1. `[*]T` - pointer to the data
// 2. `usize` - the element count
//
// Slice syntax is `[]T`
//
// Slices have the same attributes as pointers, meaning
// there also exists `const` slices
//
// String literals in Zig coerce to `[]const u8`

fn total(arr: []const u8) u8 {
    var sum: u8 = 0;
    for (arr) |n| {
        sum += n;
    }
    return sum;
}

test "slices" {
    const array = [_]u8{ 1, 2, 3, 4, 5, 6, 7 };
    // Creates a new slice with syntax arr[n..m]
    const slice = array[0..3];
    try expect(total(slice) == 6);
}

test "slices 2" {
    const array = [_]u8{ 1, 2, 3, 4, 5, 6, 7 };
    const slice = array[0..3];
    // When `n, m` are known at compile time
    // the slice syntax will produce a pointer
    // to an array
    try expect(@TypeOf(slice) == *const [3]u8);
}

test "slices 3" {
    var a: [5]u8 = .{ 'h', 'e', 'l', 'l', 'o' };
    const b: []const u8 = a[0..]; // slice (pointer) to a
    const c: [5]u8 = a; // array (copy of) a

    try expect(mem.eql(u8, &a, b));
    try expect(mem.eql(u8, &a, &c));

    a[0] = 'c';

    try expect(mem.eql(u8, &a, b));
    try expect(!mem.eql(u8, &a, &c));
}

test "slices 4" {
    const msg = "hello";
    // string literals are of this type to make them
    // interopable with C
    try expect(@TypeOf(msg) == *const [5:0]u8);

    var msg2 = "hello";
    try expect(@TypeOf(msg2) == *const [5:0]u8);
}

pub fn main() void {
    const msg = "hello";
    poopyPrint(msg);
}

fn poopyPrint(msg: []const u8) void {
    std.debug.print("💩 {s} 💩\n", .{msg});
}

// Will throw compilation error since passing in
// *const [5:0]u8
//
// fn poopyPrint(msg: []u8) void {
//     std.debug.print("💩 {s} 💩\n", .{msg});
// }
