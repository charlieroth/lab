const std = @import("std");

pub fn main() !void {
    const nums = [10]i32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    const nums_len = nums.len;
    std.debug.print("nums[{d}] = {d}\n", .{5, nums[5]});
    std.debug.print("nums length = {d}\n", .{nums_len});
}
