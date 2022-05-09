const std = @import("std");

test "if statment" {
    const age = 26;
    var can_enter = false;

    if (age > 21) {
        can_enter = true; 
    } else {
        can_enter = false;
    }

    try std.testing.expect(can_enter);
}

test "if statment (2)" {
    const age = 26;
    var can_enter = false;

    // if statment as an expression
    can_enter = if (age > 21) true else false;

    try std.testing.expect(can_enter);

}
