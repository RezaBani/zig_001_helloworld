const std = @import("std");
const lib = @import("zig_001_helloworld_lib");
const exe = @import("zig_001_helloworld_exe");
const testing = std.testing;

test "use other module" {
    try testing.expectEqual(@as(i32, 150), lib.add(100, 50));
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try testing.fuzz(Context{}, Context.testOne, .{});
}

test "basic add functionality" {
    try testing.expect(lib.add(3, 7) == 10);
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // Try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try testing.expectEqual(@as(i32, 42), list.pop());
}

test "main module" {
    try testing.expectEqual(5, exe.simpleAdd(u8, 2, 3));
    try testing.expectEqual(5, exe.simpleAdd(i32, 2, 3));
    try testing.expectEqual(5, exe.lib.add(2, 3));
}
