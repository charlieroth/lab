const std = @import("std");
const testing = std.testing;
const mem = std.mem;

const Base64 = struct {
    table: *const [64]u8,

    pub fn init() Base64 {
        const upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        const lower = "abcdefghijklmnopqrstuvwxyz";
        const number_symbol = "0123456789+/";
        return Base64{
            .table = upper ++ lower ++ number_symbol,
        };
    }

    pub fn char_at(self: Base64, index: u8) u8 {
        return self.table[index];
    }

    pub fn char_index(self: Base64, char: u8) u8 {
        if (char == '=') {
            return 64;
        }

        var index: u8 = 0;
        for (0..63) |_| {
            if (self.char_at(index) == char) {
                break;
            }
            index += 1;
        }

        return index;
    }

    pub fn calculate_encode_length(input: []const u8) u64 {
        if (input.len < 3) {
            const n_output: u64 = 4;
            return n_output;
        }

        const len_as_float: f64 = @floatFromInt(input.len);
        const n_output: u64 = @intFromFloat(@ceil(len_as_float / 3.0) * 4.0);
        return n_output;
    }

    pub fn calculate_decode_length(input: []const u8) u64 {
        if (input.len < 4) {
            const n_output: u64 = 3;
            return n_output;
        }

        const len_as_float: f64 = @floatFromInt(input.len);
        const n_output: u64 = @intFromFloat(@ceil(len_as_float / 4.0) * 3.0);
        return n_output;
    }

    pub fn encode(self: Base64, allocator: mem.Allocator, input: []const u8) ![]u8 {
        if (input.len == 0) {
            return "";
        }

        const n_out = calculate_encode_length(input);
        var out = try allocator.alloc(u8, n_out);
        var buf = [3]u8{ 0, 0, 0 };
        var count: u8 = 0;
        var iout: u64 = 0;

        for (input, 0..) |_, i| {
            buf[count] = input[i];
            count += 1;

            // When `count` reaches 3, try to encode the 3 characters (or bytes)
            // accumulated until this point in `buf`

            // If a 3 byte window is encountered
            if (count == 3) {
                // `output[0]` = bit-shifting `input[0]` right 2 positions
                out[iout] = self.char_at(buf[0] >> 2);
                // `output[1]` = sum of
                //  - Last 2 bits of `input[0]` bit-shifted left 4 positions
                //  - Bits of `input[1]` bit-shifted right 4 positions
                out[iout + 1] = self.char_at(((buf[0] & 0x03) << 4) + (buf[1] >> 4));
                // `output[2]` = sum of
                // - Last 4 bits of `input[1]` bit-shifted left 2 positions
                // - Bits of `input[2]` bit-shifted right 6 positions
                out[iout + 2] = self.char_at(((buf[1] & 0x0f) << 2) + (buf[2] >> 6));
                // `output[3]` = last 6 bits of `input[2]`
                out[iout + 3] = self.char_at(buf[2] & 0x3f);
                // increment window position
                iout += 4;
                // reset counter that builds window
                count = 0;
            }
        }

        // If the end of ths string is reached and the `count` is less than 3
        // then `buf` contains the last 1 or 2 bytes from the input

        if (count == 1) {
            // `output[0]` = bit-shifting `input[0]` right 2 positions
            out[iout] = self.char_at(buf[0] >> 2);
            // `output[1]` = last 2 digits of `input[0]` bit-shifted left 4 positions
            out[iout + 1] = self.char_at((buf[0] & 0x03) << 4);
            // pad output
            out[iout + 2] = '=';
            out[iout + 3] = '=';
        }

        if (count == 2) {
            // `output[0]` = bit-shifting `input[0]` right 2 positions
            out[iout] = self.char_at(buf[0] >> 2);
            // `output[1]` = sum of
            // - Last 2 digits of `input[0]` bit-shifted left 4 positions
            // - Bits of `input[1]` bit-shifted right 4 positions
            out[iout + 1] = self.char_at(((buf[0] & 0x03) << 4) + (buf[1] >> 4));
            // `output[2]` = Last 4 digits of `input[1]` bit-shifted left 2 positions
            out[iout + 2] = self.char_at((buf[1] & 0x0f) << 2);
            // pad output
            out[iout + 3] = '=';
            // increment window position
            iout += 4;
        }

        return out;
    }

    pub fn decode(self: Base64, allocator: mem.Allocator, encoded: []const u8) ![]const u8 {
        if (encoded.len == 0) {
            return "";
        }

        const n_out = calculate_decode_length(encoded);
        std.debug.print("n_out: {}\n", .{n_out});
        var out = try allocator.alloc(u8, n_out);
        for (out, 0..) |_, i| {
            out[i] = 0;
        }

        var buf = [4]u8{ 0, 0, 0, 0 };
        var count: u8 = 0;
        var iout: u64 = 0;

        for (0..encoded.len) |i| {
            // build window
            buf[count] = self.char_index(encoded[i]);
            count += 1;

            // if window of 4 bytes is encountered
            if (count == 4) {
                // `output[0]` = sum of
                // - Bits of `input[0]` bit-shifted left 2 positions
                // - Bits of `input[1]` bit-shifted right 4 positions
                out[iout] = (buf[0] << 2) + (buf[1] >> 4);

                if (buf[2] != 64) {
                    // `output[1]` = sum of
                    // - Bits of `input[1]` bit-shifted left 4 positions
                    // - Bits of `input[2]` bit-shifted right 2 positions
                    out[iout + 1] = (buf[1] << 4) + (buf[2] >> 2);
                }

                if (buf[3] != 64) {
                    // `output[2]` = sum of
                    // - Bits of `input[2]` bit-shifted left 6 positions
                    // - Bits of `input[3]`
                    out[iout + 2] = (buf[2] << 6) + buf[3];
                }

                // move window
                iout += 3;
                // reset count
                count = 0;
            }
        }

        return out;
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const base64 = Base64.init();
    try stdout.print("Character at index 28: {c}\n", .{base64.char_at(28)});
}

// test "Encodes 'Hi' to 'SGk='" {
//     var memory_buffer: [1000]u8 = undefined;
//     var fba = std.heap.FixedBufferAllocator.init(&memory_buffer);
//     const allocator = fba.allocator();
//
//     const base64 = Base64.init();
//     const encoded = try base64.encode(allocator, "Hi");
//     try testing.expect(mem.eql(u8, "SGk=", encoded));
// }

test "Decodes 'Hi' from 'SGk='" {
    var memory_buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&memory_buffer);
    const allocator = fba.allocator();

    const base64 = Base64.init();
    const decoded = try base64.decode(allocator, "SGk=");
    try testing.expectEqualStrings("Hi", decoded);
}

// test "Encodes 'Testing some more shit' to 'VGVzdGluZyBzb21lIG1vcmUgc2hpdA=='" {
//     var memory_buffer: [1000]u8 = undefined;
//     var fba = std.heap.FixedBufferAllocator.init(&memory_buffer);
//     const allocator = fba.allocator();
//
//     const base64 = Base64.init();
//     const encoded = try base64.encode(allocator, "Testing some more shit");
//     try testing.expect(mem.eql(u8, "VGVzdGluZyBzb21lIG1vcmUgc2hpdA==", encoded));
// }
//
// test "Decodes 'Testing some more shit' from 'VGVzdGluZyBzb21lIG1vcmUgc2hpdA=='" {
//     var memory_buffer: [1000]u8 = undefined;
//     var fba = std.heap.FixedBufferAllocator.init(&memory_buffer);
//     const allocator = fba.allocator();
//
//     const base64 = Base64.init();
//     const decoded = try base64.decode(allocator, "VGVzdGluZyBzb21lIG1vcmUgc2hpdA==");
//     try testing.expect(mem.eql(u8, "Testing some more shit", decoded));
// }
