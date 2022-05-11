const std = @import("std");
const expect = std.testing.expect;
const eql = std.mem.eql;

test "createFile, write, seekTo, read" {
    // create file
    const file = try std.fs.cwd().createFile("junk_file.txt", .{ .read = true });
    defer file.close();

    // write content to file
    const bytes_written = try file.writeAll("Hello file!");
    _ = bytes_written;

    // place read cursor back to beggining
    try file.seekTo(0);

    // read content into buffer
    var buffer: [100]u8 = undefined;
    const bytes_read = try file.readAll(&buffer);

    try expect(eql(u8, buffer[0..bytes_read], "Hello file!"));
}

test "file stat" {
    const file = try std.fs.cwd().createFile("junk_file2.txt", .{ .read = true });
    defer file.close();
    const stat = try file.stat();

    try expect(stat.size == 0);
    try expect(stat.kind == .File);
    try expect(stat.ctime <= std.time.nanoTimestamp());
    try expect(stat.mtime <= std.time.nanoTimestamp());
    try expect(stat.atime <= std.time.nanoTimestamp());
}
