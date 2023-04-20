const std = @import("std");

const json = std.json;
const testing = std.testing;
const mem = std.mem;
const debug = std.debug;
const io = std.io;
const fmt = std.fmt;

const Address = struct {
    street: []const u8,
    state: []const u8,
};

const Person = struct {
    name: []const u8,
    age: u8,
    address: Address,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();

    const reader = io.getStdIn().reader();
    const writer = io.getStdOut().writer();

    while (true) {
        // Read person JSON from stdin
        const info = try reader.readUntilDelimiterOrEofAlloc(allocator, '\n', 400);
        var stream = json.TokenStream.init(info.?);
        const p = try json.parse(Person, &stream, .{ .allocator = allocator });

        // Stringify person
        var string = std.ArrayList(u8).init(allocator);
        try std.json.stringify(p, .{}, string.writer());

        // Write stringified person to stdout
        try writer.print("{s}\n", .{string.items});

        // Free memory
        string.deinit();
        json.parseFree(Person, p, .{ .allocator = allocator });
        allocator.free(info.?);
    }

    const didLeak = gpa.deinit();
    if (!didLeak) {
        debug.print("No memory leaks\n", .{});
    } else {
        debug.print("Memory was leaked\n", .{});
    }
}

test "json stringify struct" {
    const name = "Charlie";
    const street = "9623 Westmore St.";
    const state = "Michigan";

    const p = Person{
        .name = name[0..],
        .age = 27,
        .address = Address{
            .street = street[0..],
            .state = state[0..],
        },
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();

    var string = std.ArrayList(u8).init(allocator);
    try std.json.stringify(p, .{}, string.writer());
    try testing.expect(mem.eql(u8, string.items,
        \\{"name":"Charlie","age":27,"address":{"street":"9623 Westmore St.","state":"Michigan"}}
    ));
    string.deinit();

    const didLeak = gpa.deinit();
    try testing.expect(!didLeak);
}
