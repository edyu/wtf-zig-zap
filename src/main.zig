const std = @import("std");
const zap = @import("zap");

fn on_request_verbose(r: zap.Request) void {
    if (r.path) |the_path| {
        std.debug.print("PATH: {s}\n", .{the_path});
    }

    if (r.query) |the_query| {
        std.debug.print("QUERY: {s}\n", .{the_query});
    }
    r.sendBody("<html><body><h1>Hello from ZAP!!!</h1></body></html>") catch return;
}

fn on_request_minimal(r: zap.Request) void {
    r.sendBody("<html><body><h1>Hello from ZAP!!!</h1></body></html>") catch return;
}

fn on_request(r: zap.Request) void {
    r.setStatus(.not_found);
    r.sendBody("<html><body><h1>404 - File not found</h1></body></html>") catch return;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{
        .thread_safe = true,
    }){};

    {
        // use this allocator for all your memory allocation
        const allocator = gpa.allocator();
        _ = allocator;

        var listener = zap.HttpListener.init(.{
            .port = 3000,
            // .on_request = on_request,
            // .on_request = on_request_minimal,
            .on_request = on_request_verbose,
            .log = true,
            .public_folder = "public",
            .max_clients = 100000,
        });
        try listener.listen();

        std.debug.print("Listening on 0.0.0.0:3000\n", .{});

        // start worker threads
        zap.start(.{
            // if all threads hang, your server will hang
            .threads = 2,
            // workers share memory so do not share states if you have multiple workers
            .workers = 1,
        });
    }

    // all defers should have run by now
    std.debug.print("\n\nSTOPPED!\n\n", .{});
    // we'll arrive here after zap.stop()
    const leaked = gpa.detectLeaks();
    std.debug.print("Leaks detected: {}\n", .{leaked});
}
