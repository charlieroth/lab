const std = @import("std");
const eql = std.mem.eql;
const expect = std.testing.expect;
const test_allocator = std.testing.allocator;

test "io writer usage" {
    var list = std.ArrayList(u8).init(test_allocator);
    defer list.deinit();

    const bytes_written = try list.writer().write("Hello World!");
    try expect(bytes_written == 12);
    try expect(eql(u8, list.items, "Hello World!"));
}
