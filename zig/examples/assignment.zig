const std = @import("std");

pub fn main() !void {
    const immutable_value = 42;
    std.debug.print("immutable_value: {d}\n", .{immutable_value});
    const immutable_value_with_type: i32 = 42;
    std.debug.print("immutable_value_with_type: {d}\n", .{immutable_value_with_type});

    var mutable_value_with_type: u32 = 32;
    std.debug.print("mutable_value_with_type: {d}\n", .{mutable_value_with_type});

    const inferred_constant = @as(i32, 42);
    std.debug.print("inferred_constant: {d}\n", .{inferred_constant});
    var inferred_variable = @as(u32, 5000);
    std.debug.print("inferred_variable: {d}\n", .{inferred_variable});
}
