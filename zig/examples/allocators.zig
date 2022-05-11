const std = @import("std");
const expect = std.testing.expect;

// Zig has no hidden memory allocations. This means that programmers must choose how they want to allocate memory.
// The standard library provides patterns for allocating memory

// The most basic allocator is the `std.heap.page_allocator`. By the name, the program will ask the OS
// for a page of memory, which is a syscall, so this is a very inefficient form a memory allocation.
// Also from the name, this allocation happen in the heap
test "std.heap.page_allocator" {
    const allocator = std.heap.page_allocator;
    // Allocate 100 bytes of the type `u8` which results in a `[]u8` of length 100
    const data = try allocator.alloc(u8, 100);
    defer allocator.free(data);
    try expect(data.len == 100);
    try expect(@TypeOf(data) == []u8);
}

test "std.heap.page_allocator (2)" {
    // `alloc()` and `free()` are used for slices but for single items, use `create` and `destroy`
    const byte = try std.heap.page_allocator.create(u8);
    defer std.heap.page_allocator.destroy(byte);
    byte.* = 128;
}

// The `std.heap.FixedBufferAllocator` allocates memory into a fixed buffer and does not make any heap
// allocations (useful for kernel programming) and should be considered when performance matters.
// Will return an `OutOfMemory` error if it has run out of bytes.
test "std.heap.FixedBufferAllocator" {
    var buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    const data = try allocator.alloc(u8, 100);
    defer allocator.free(data);
    try expect(data.len == 100);
    try expect(@TypeOf(data) == []u8);
}

// The `std.heap.ArenaAllocator` recieves a child allocator and allows many allocations and one free
test "std.heap.ArenaAllocator" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    _ = try allocator.alloc(u8, 1);
    _ = try allocator.alloc(u8, 10);
    _ = try allocator.alloc(u8, 100);
}

test "std.heap.GeneralPurposeAllocator" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const leaked = gpa.deinit();
        // `try` cannot be used in `defer` so catch the error and panic
        if (leaked) expect(false) catch @panic("std.heap.GeneralPurposeAllocator test failed");
    }
    const bytes = try allocator.alloc(u8, 100);
    defer allocator.free(bytes);
}

// For high performance memory allocation use `std.heap.c_allocator`, however this requires Libc linking
