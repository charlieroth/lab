const std = @import("std");
const assert = std.debug.assert;

const LinkedListError = error{ NotFound, Empty };

pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Link = struct {
            next: ?*Link = null,
            data: T,
        };

        head: ?*Link = null,

        pub fn prepend(self: *Self, link: *Link) void {
            link.next = self.head;
            self.head = link;
        }

        pub fn append(self: *Self, link: *Link) void {
            var it: ?*Link = self.head;
            while (it) |lnk| {
                if (it.?.next == null) {
                    break;
                } else {
                    it = lnk.next;
                }
            }
            it.?.next = link;
        }

        pub fn pop(self: *Self) LinkedListError!?*Link {
            const head = self.head orelse return LinkedListError.Empty;
            self.head = head.next;
            return head;
        }

        pub fn remove(self: *Self, link: *Link) LinkedListError!void {
            // Make sure link is in list
            _ = try self.find(link.data);

            // If link to remove is the head, use pop()
            var it: ?*Link = self.head;
            if (it) |lnk| {
                if (lnk.data == link.data) {
                    _ = try self.pop();
                    return;
                }
            }

            // Otherwise, remove link
            while (it) |lnk| : (it = lnk.next) {
                if (lnk.next.?.data == link.data) {
                    // `lnk` is now the previous link to link we want to remove
                    lnk.next = link.next;
                    break;
                }
            }
        }

        pub fn find(self: *Self, data: T) LinkedListError!?*Link {
            var it: ?*Link = self.head;
            while (it) |link| : (it = link.next) {
                if (link.data == data) return link;
            }

            return LinkedListError.NotFound;
        }

        pub fn len(self: *Self) usize {
            var size: usize = 0;
            var it: ?*Link = self.head;
            while (it) |link| : (it = link.next) {
                size += 1;
            }

            return size;
        }

        pub fn print(self: *Self) void {
            std.debug.print("list: ", .{});
            var it = self.head;
            while (it) |link| : (it = link.next) {
                if (link.next == null) {
                    std.debug.print("{}->null", .{link.data});
                } else {
                    std.debug.print("{}->", .{link.data});
                }
            }
            std.debug.print("\n", .{});
        }
    };
}

pub fn main() !void {
    const LL = LinkedList(u32);
    var list = LL{};

    // Try to pop from empty list
    _ = list.pop() catch |err| {
        std.debug.print("Cannot pop from empty list\n", .{});
        assert(err == LinkedListError.Empty);
    };

    var n1 = LL.Link{ .data = 1 };
    var n2 = LL.Link{ .data = 2 };
    var n3 = LL.Link{ .data = 3 };
    var n4 = LL.Link{ .data = 4 };

    // Add links to list
    list.prepend(&n1);
    list.prepend(&n2);
    list.prepend(&n3);
    list.append(&n4);
    list.print();

    // Pop link from list
    std.debug.print("popping from list\n", .{});
    _ = try list.pop();
    list.print();

    // Find link in list
    std.debug.print("searching for {} ... ", .{1});
    _ = try list.find(1);
    std.debug.print("found\n", .{});

    // Successfully fail to find already removed link
    _ = list.find(3) catch |err| {
        assert(err == LinkedListError.NotFound);
    };

    // Remove item that is not the head link
    std.debug.print("removing: {}\n", .{n1.data});
    try list.remove(&n1);
    list.print();

    // Remove head link
    std.debug.print("removing: {}\n", .{n2.data});
    try list.remove(&n2);
    list.print();

    // Try to remove link not in list anymore
    std.debug.print("removing: {}\n", .{n2.data});
    _ = list.remove(&n2) catch |err| {
        std.debug.print("failed to find: {}\n", .{n2.data});
        assert(err == LinkedListError.NotFound);
    };
    list.print();
}
