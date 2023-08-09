const std = @import("std");
const http = std.http;

const uri = std.Uri.parse("https://ziglang.org/") catch unreachable;

test {
    var client: http.Client = http.Client{ .allocator = std.testing.allocator };
    defer client.deinit();

    var headers: http.Headers = http.Headers.init(std.testing.allocator);
    var req = try client.request(.GET, uri, headers, .{});
    defer req.deinit();

    try std.testing.expect(req.response.headers.status == .ok);
}
