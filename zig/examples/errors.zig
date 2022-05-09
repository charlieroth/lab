const std = @import("std");
const expect = std.testing.expect;

// An error set is like an enum where each error is a value
// There are no exceptions in Zig

const FileOpenError = error{ AccessDenied, OutOfMemory, FileNotFound };

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

// An error set type and a normal type can be combined with `!` operator to
// form an error union type
test "error union" {
    const maybe_error: AllocationError!u16 = 10;
    // `catch` is used to provide a fallback value if the expression on the LHS evaluates to an error
    const no_error = maybe_error catch 0;
    try expect(@TypeOf(no_error) == u16);
    try expect(no_error == 10);
}

test "error union (2)" {
    const is_error: FileOpenError!u16 = FileOpenError.AccessDenied;
    const fallback_value = is_error catch 32;
    try expect(@TypeOf(fallback_value) == comptime_int);
    try expect(fallback_value == 32);
}

fn deny_access() FileOpenError!void {
    return FileOpenError.AccessDenied;
}

test "fn denies access to file" {
    // This is called "payload capturing" and is used in many places in Zig
    // Similar to lambdas in other languages
    deny_access() catch |err| {
        try expect(err == FileOpenError.AccessDenied);
        return;
    };
}

fn fail_fn() FileOpenError!i32 {
    // This syntax is short for: `deny_access() catch |err| return err;`
    try deny_access();
    return 42;
}

test "try" {
    var v = fail_fn() catch |err| {
        try expect(err == FileOpenError.AccessDenied);
        return;
    };
    try expect(v == 42);
}
