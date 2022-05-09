const std = @import("std");

pub fn main() !void {
    const name = [_]u8{'c','h','a','r','l','i','e'};

    for (name) |c, i| {
        std.debug.print("name[{d}] = {c}\n", .{i, c});
    }
    
    for (name) |c| {
        std.debug.print("{c},", .{c});
    }
    std.debug.print("\n", .{});
    
    for (name) |_, i| {
        std.debug.print("{d},", .{i});
    }
    std.debug.print("\n", .{});
}
