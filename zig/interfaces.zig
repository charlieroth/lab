const std = @import("std");

pub const Cat = struct {
    anger_level: usize,

    pub fn talk(self: Cat) void {
        std.debug.print("Cat: meow! (anger lvl {d})\n", .{self.anger_level});
    }
};

pub const Dog = struct {
    name: []const u8,

    pub fn talk(self: Dog) void {
        std.debug.print("Dog: ruff! (name {s})\n", .{self.name});
    }
};

pub const Animal = union(enum) {
    cat: Cat,
    dog: Dog,

    pub fn talk(self: Animal) void {
        switch (self) {
            .cat => |cat| cat.talk(),
            .dog => |dog| dog.talk(),
        }
    }
};

pub fn main() !void {
    const kitty = Animal{
        .cat = Cat{
            .anger_level = 10,
        },
    };

    const doggo = Animal{
        .dog = Dog{
            .name = "kiwi",
        },
    };

    kitty.talk();
    doggo.talk();
}
