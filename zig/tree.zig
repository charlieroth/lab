const std = @import("std");

fn Node(comptime T: type) type {
    return struct {
        data: T,
        left: ?*Node,
        right: ?*Node,
    };
}

fn Tree(comptime T: type) type {
    return struct {
        root: ?*Node(T),

        fn insert(self: *Tree, value: T) void {
            // Walk tree and insert in appropriate place
        }

        // fn search(value: T) void {
        //
        // }
        //
        // fn walk_df(self: *Tree) void {
        //     _ = self;
        // }
        //
        // fn walk_bf(self: *Tree) void {
        //     _ = self;
        // }
    };
}

fn create_tree(comptime T: type) Tree {
    return Tree(T){ .root = null };
}

pub fn main() !void {
    var root = Node(u8){ .data = 10, .left = null, .right = null };
    var n1 = Node(u8){ .data = 15, .left = null, .right = null };
    var n2 = Node(u8){ .data = 5, .left = null, .right = null };
    root.left = &n1;
    root.right = &n2;
}
