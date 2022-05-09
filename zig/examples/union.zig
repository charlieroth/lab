const std = @import("std");
const expect = std.testing.expect;

// union types define types which store on value of many possible
// typed fields but only one field may be active at one time
//
// accessing a field in a union which is not active is detectable
// illegal behaviour

const Result = union {
    int: i64,
    float: f64,
    bool: bool,
};

test "simple union" {
    var res = Result{ .int = 1234 };

    // accessing float field is illegal
    res.float = 12.34;
}
