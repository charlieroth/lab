const std = @import("std");

pub fn LinkedList(comptime Val: type) type {
    return struct {
        const This = @This();
        const Node = struct {
            val: Val,
            next: ?*Node,
        };
        gpa: std.mem.Allocator,
        head: ?*Node,
        tail: ?*Node,
        pub fn init(gpa: std.mem.Allocator) This {
            return This{
                .gpa = gpa,
                .head = null,
                .tail = null,
            };
        }
        pub fn insert(this: *This, val: Val) !void {
            const node = try this.gpa.create(Node);
            node.* = .{ .data = val, .next = null };
            if (!this.head and !this.tail) {
                this.head = node;
                this.head.next = this.tail;
            } else if (this.head and !this.tail) {
                this.tail = node;
            } else {
                this.tail.next = node;
            }
        }
        pub fn insert_head(this: *This, val: Val) !void {
            const node = try this.allocator.create(Node);
            node.* = .{ .data = val, .next = null };
            if (this.head) |head| {
                node.next = head;
                head = node;
            } else {
                this.head = node;
            }
        }
    };
}
