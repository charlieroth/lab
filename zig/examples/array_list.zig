const std = @import("std");
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator; // GeneralPurposeAllocator
const expect = std.testing.expect;

// std.ArrayList serves as a buffer which can change in size
//
// Similar to C++ std::vector<T> or Rust Vec<T>
test "array list" {
    var list = ArrayList(u8).init(test_allocator);
    defer list.deinit();

    try list.append('H');
    try list.append('e');
    try list.append('l');
    try list.append('l');
    try list.append('o');
    try list.appendSlice(", World!");
    try expect(eql(u8, list.items, "Hello, World!"));
}
