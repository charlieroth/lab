const std = @import("std");

fn add_five(n: i32) i32 {
    return n + 5;
}

fn add_five_ptr(n: *i32) void {
    n.* += 5;
}

pub fn main() !void {
    var x: i32 = 12;
    std.debug.print("x = {d}\n", .{x});
    x = add_five(x);
    std.debug.print("x = {d}\n", .{x});
    add_five_ptr(&x);
    std.debug.print("x = {d}\n", .{x});
}
