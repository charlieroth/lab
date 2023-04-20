const std = @import("std");

const io = std.io;
const heap = std.heap;
const mem = std.mem;
const assert = std.debug.assert;
const testing = std.testing;

const Person = struct {
    name: []u8,
    age: i8,
};

pub fn main() !void {
    var gpa = heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    defer {
        const didLeak = gpa.deinit();
        assert(!didLeak);
    }

    std.debug.print("Enter your name\n", .{});

    const stdin = io.getStdIn().reader();
    if (try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 400)) |name| {
        const nameCopy = name[0..];
        assert(@TypeOf(nameCopy) == *[]u8);
        const charlie = Person{
            .name = name[0..],
            .age = 27,
        };
        allocator.free(name);

        std.debug.print("charlie: {s}\n", .{charlie.name});
        // allocator.free(name);
    }
}
