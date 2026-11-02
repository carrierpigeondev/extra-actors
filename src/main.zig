const std = @import("std");

fn broadcast(io: std.Io) !void {
    try std.Io.File.stdout().writeStreamingAll(io, "fetch\ninstall");
}

fn fetch(argv: []const []const u8) void {
    _ = argv;
    std.log.err("Not yet implemented. I lied.", .{});
}

fn install(argv: []const []const u8) void {
    _ = argv;
    std.log.err("Not yet implemented. I lied.", .{});
}

pub fn main(init: std.process.Init) !void {
    const argv = try init.minimal.args.toSlice(init.arena.allocator());

    const called_role = argv[1];
    if (std.mem.eql(u8, called_role, "broadcast")) {
        try broadcast(init.io);
    } else if (std.mem.eql(u8, called_role, "fetch")) {
        fetch(argv);
    } else if (std.mem.eql(u8, called_role, "install")) {
        install(argv);
    }
}
