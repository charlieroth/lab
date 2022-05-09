const std = @import("std");
const expect = std.testing.expect;
const math = std.math;

const Triangle = struct {
    a: f32,
    b: f32,
    c: f32,
    pub fn is_right(self: Triangle) bool {
        return (math.pow(f32, self.a, 2.0) + math.pow(f32, self.b, 2.0)) == math.pow(f32, self.c, 2.0);
    }
};

test "struct usage" {
    const my_triangle = Triangle{
        .a = 3,
        .b = 4,
        .c = 5,
    };

    try expect(my_triangle.is_right() == true);
}

const Point2D = struct {
    x: i32,
    y: i32,
    fn swap(self: *Point2D) void {
        // Structs have the property that when given a pointer to
        // a struct, one level of dereferencing is done automatically
        // when accessing fields. This makes the below dot notation
        // work the same as normal dereferencing without the .* syntax
        // of other dereferencing
        const tmp = self.x;
        self.x = self.y;
        self.y = tmp;
    }
};

test "automatic derefence" {
    var point = Point2D{ .x = 10, .y = 30 };
    try expect(point.y == 30);
    try expect(point.x == 10);
    point.swap();
    try expect(point.x == 30);
    try expect(point.y == 10);
}
