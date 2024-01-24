# Zig Zap -- WTF is ⚡Zap⚡

The power of ⚡**Zap**⚡ for Zig

---

Ed Yu ([@edyu](https://github.com/edyu) on Github and
[@edyu](https://twitter.com/edyu) on Twitter)
January.23.2024

---

![Zig Logo](https://ziglang.org/zig-logo-dark.svg)

## Introduction

[**Zig**](https://ziglang.org) is a modern systems programming language and although it claims to a be a **better C**, many people who initially didn't need systems programming were attracted to it due to the simplicity of its syntax compared to alternatives such as **C++** or **Rust**.

However, due to the power of the language, some of the syntaxes are not obvious for those first coming into the language. I was actually one such person.

Today we will explore an awesome **Zig** project called ⚡[**Zap**](https://github.com/zigzap/zap)⚡. From a high level, [**Zap**](https://github.com/zigzap/zap) is web-server. However, it's not a web-server fully implemented in **Zig**. It's a wrapper on top of a **C** web-server (library) called [facil.io](https://facil.io).

## Why Zap

There are many reasons I like [**Zap**](https://github.com/zigzap/zap) but I'll list the top 3:

1. [**Zap**](https://github.com/zigzap/zap) is designed by [Rene](https://github.com/renerocksai), who's probably one of the most practical engineers I know. 
2. [**Zap**](https://github.com/zigzap/zap) is extremely fast.
3. [**Zap**](https://github.com/zigzap/zap) is very simple.

Let me explain each of these reasons:

[Rene](https://github.com/renerocksai) originally started [**Zap**](https://github.com/zigzap/zap) for his own use for work so it was designed to make his work easier. He made many decisions along the way and I believe he made many correct decisions.
He will not implement something just because every other webserver has it nor would he implement something in the same way that other web-servers implemented the feature.

[**Zap**](https://github.com/zigzap/zap) is extremely fast because [facil.io](https://facil.io) is extremely fast. You can check out the full benchmark [here](https://github.com/zigzap/zap/blob/master/blazingly-fast.md).
Of course, benchmarks doesn't tell the full story and can be easily manipulated but it will show at least that the bottleneck is definitely not in [**Zap**](https://github.com/zigzap/zap) or **Zig** itself. 

![Zap Request/Second](https://raw.githubusercontent.com/zigzap/zap/master/wrk/samples/req_per_sec_graph.png)
![Zap Transfer/Second](https://raw.githubusercontent.com/zigzap/zap/master/wrk/samples/xfer_per_sec_graph.png)

[**Zap**](https://github.com/zigzap/zap) is simple because [Rene](https://github.com/renerocksai) didn't implement anything he didn't need and when he does need a feature, he tried to implement it in a very straightforward way which is inline with the design philosophy of **Zig** itself. His code is a pleasure to read and I can honestly say that he was probably the primary reason I was able to learn **Zig**.
[**Zap**](https://github.com/zig) also has one of the best [examples](https://github.com/zigzap/zap/tree/master/examples) of any projects on github. Just by looking at the [example](https://github.com/zigzap/zap/tree/master/examples), you should be able to get up to speed quickly.

## Why Not Zap

Of course, [**Zap**](https://github.com/zigzap/zap) is not for everyone and here are three reasons why you may not want to use it:

1. If you have [NIH Syndrome](https://en.wikipedia.org/wiki/Not_invented_here), [**Zap**](https://github.com/zigzap/zap) is **NOT** implemented in **Zig**. 
2. If you are on Widnows or you need [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2) or [HTTP/3](https://en.wikipedia.org/wiki/HTTP/3) because [facil.io](https://facil.io) only implemented HTTP/1.0 and HTTP/1.1.
3. You need to write a lot of code even for simple things in [**Zap**](https://github.com/zigzap/zap) compared to most other web frameworks because [**Zap**](https://github.com/zigzap/zap) is a web-server not a web framework.

![Not Invented Here](https://www.opeadeoye.ng/CMSFiles/The-Lagoon-Chronicles/images/Dilbert-not-invented-here_strip.gif)

For any new language, there is a tendency for early adopters of that language to reimplement everything in the new shiny language. Even if the language is not new anymore, there will still be plenty of people creating a new *framework* in that language.  

This is certainly not the case for [**Zap**](https://github.com/zigzap/zap) because every feature that was exposed is used by [Rene](https://github.com/renerocksai) himself.

He also made it very clear that [**Zap**](https://github.com/zigzap/zap) will not reimplement everything in [facil.io](https://facil.io) using **Zig**. [Rene](https://github.com/renerocksai) also tried to minimize any changes to the upstream [facil.io](https://github.com/boazsegev/facil.io).  Unfortunately, it also means that [**Zap**](https://github.com/zigzap/zap) won't run on Windows.

Lastly, you do have to understand that even the simplest language and simplest wrapper would introduce artifacts that complicate the usage due to impedence mismatch. 

For example, to get a string parameter that are passed in the URL, you have to do the following in [**Zap**](https://github.com/zigzap/zap):

```zig
            if (r.getParamStr(allocator, "my-param", false)) |maybe_str| {
                if (maybe_str) |*s| {
                    defer s.deinit();

                    std.log.info("Param my-param = {s}", .{s.str});
                } else {
                    std.log.info("Param my-param not found!", .{});
                }
            }
```

There is also no authentication, authorization, or database built-in so you'll end up writing a lot of code to implement these yourself.

In some private tests I've done myself, you end up writing about 5 times as much code in **Zig** and [**Zap**](https://github.com/zigzap/zap) than if you use something like **Python** [**FastAPI**](https://fastapi.tiangolo.com), or even comparing to another extremely young web-framework such as **Julia** [**Oxygen.jl**](https://ndortega/Oxygen.jl). So whethat that's worth the tradeoff if up to you. 

Fortunately, as more people start using [**Zap**](https://github.com/zigzap/zap), more features are being added. For example, [**Zap**](https://github.com/zigzap/zap) recently finally has *TLS* added. The built-in [**Mustache**](https://mustache.github.io) template engine is also recently improved as well.   

## Zig 0.11 vs master (0.12)

By default, [**Zap**](https://github.com/zigzap/zap) is on **Zig** [0.11](https://ziglang.org/download/0.11.0/release-notes.html) so if you can, please use that instead.

However, **Zig** by default exposes *master*, which is currently pre-release [0.12.0](https://ziglang.org/download/), which would not build the [**Zap**](https://github.com/zigzap/zap) project properly.

## Build using Zig 0.11

You don't necessarily need to build [**Zap**](https://github.com/zigzap/zap) although it would make referring to the [examples](https://github.com/zigzap/zap/tree/master/examples) and the source code easier.

To build [**Zap**](https://github.com/zigzap/zap), you need to do the following:

    1. git clone git@github.com:zigzap/zap.git
    2. cd zap
    3. zig build

If you want to build all the examples:

    ./build_all.sh

If you only need to build a specific example such as `hello`: 

    zig build hello

## Zig master (0.12)

To build [**Zap**](https://github.com/zigzap/zap) on **Zig** master, you need to do the following:

    1. git clone git@github.com:zigzap/zap.git
    2. cd zap
    3. git switch zig-0.12.0
    3. zig build

The other steps are the same as 0.11.

## Setup for Zig 0.11

For your **Zap** project, you need to have the following in your `build.zig.zon`:

```zig
    .{
        .name = "wtf-zig-zap",
        .version = "0.0.1",

        .dependencies = .{
            // zap v0.4.0
            .zap = .{
                .url = "https://github.com/zigzap/zap/archive/refs/tags/v0.4.0.tar.gz",
                .hash = "1220a20e883195793cff0f298d647d35f675ad25e6556fe75b9ccabc98a349cbf082",
            }
        }
    }
```

For `build.zig`, you need the following:

```zig
    const exe = b.addExecutable(.{
        .name = "wtf-zig-zap",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const zap = b.dependency("zap", .{
        .target = target,
        .optimize = optimize,
    });
    exe.addModule("zap", zap.module("zap"));
    exe.linkLibrary(zap.artifact("facil.io"));
```

## Setup for Zig master (0.12)

Because all official [**Zap**](https://github.com/zigzap/zap) releases are based on **Zig** [0.11](https://ziglang.org/download/0.11.0/release-notes.html), for **Zig** master, you'll need to either build your own package or use a package I built.  

```zig
    .{
        .name = "wtf-zig-zap",
        .version = "0.0.1",
        // note the extra paths field for zig 0.12
        .paths = .{"."},

        .dependencies = .{
            // zap v0.4.0
            .zap = .{
                // note this is a package built from my forked repository
                .url = "https://github.com/edyu/zap/archive/refs/tags/v0.4.0.tar.gz",
                // the hash is also different
                .hash = "12203e381b737b077759d3c63a1752fe79bb35dd50d1122a329a3f7b4504156d5595",
            }
        }
    }
```

The `build.zig` has some more changes due to **Zig** 0.12:

```zig
    const exe = b.addExecutable(.{
        .name = "wtf-zig-zap",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const zap = b.dependency("zap", .{
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("zap", zap.module("zap"));
    exe.linkLibrary(zap.artifact("facil.io"));
```

## Hello World

This is basically the same example as `hello` in the official [examples](https://github.com/zigzap/zap/tree/master/examples):

The main entry to your code is the callback `on_request` which you specify in `zap.HttpListener.init()`.

In this example, there are `on_request_verbose` and `on_request_minimal` to illustrate how you get the `path` and `query` from the `zap.Request`:

You start the server by using calling `zap.start`.

The workers (`.workers`) do not share memory so if you store states in your [**Zap**](https://github.com/zigzap/zap) server in memory, you'll have multiple copies of the states. Therefore, I recommend to start with `.workers = 1` until you know what that means or that you make your server state-free and only use a shared database for states.

For threads, you use `.threads`; you can have more than 1 and note that if all the threads hang, your server will hang as well.

```zig
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

    pub fn main() !void {
        var listener = zap.HttpListener.init(.{
            .port = 3000,
            // .on_request = on_request_minimal,
            .on_request = on_request_verbose,
            .log = true,
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
```

You can now go to `localhost:3000` on your browser to see your server in action!

## Static Files

You can specify a folder for static files with `.public_folder`, which will be served by the server directly.

```zig
    const std = @import("std");
    const zap = @import("zap");

    fn on_request(r: zap.Request) void {
        r.setStatus(.not_found);
        r.sendBody("<html><body><h1>404 - File not found</h1></body></html>") catch return;
    }

    pub fn main() !void {
        var listener = zap.HttpListener.init(.{
            .port = 3000,
            .on_request = on_request,
            .log = true,
            .public_
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
```

## Bonus

This is not specific to [**Zap**](https://github.com/zigzap/zap) but I found that it's invaluable to keep track of memory leaks while developing my app.

**Zig** made it very easy to keep track of memory leaks so make sure to wrap your server in the following to keep track of memory leaks:

```zig
    pub fn main() !void {
        var gpa = std.heap.GeneralPurposeAllocator(.{
            .thread_safe = true,
        }){};

        {
            // use this allocator for all your memory allocation
            var allocator = gpa.allocator();

            var listener = zap.HttpListener.init(.{
                .port = 3000,
                .on_request = on_request,
                .log = true,
                .public_
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
```

Now, if you `Ctrl-C` out of your server, it will report whether you have memory leaks in your application.

## Until Next Time

Once again, I recommend reading the [examples](https://github.com/zigzap/zap/tree/master/examples) because there is pretty much an example of everything to get you started such as sending a file, using a template engine, and basic routing.

As I wrote earlier, there is no authentication built-in so if you want to use [cookies](https://en.wikipedia.org/wiki/HTTP_cookie) for authentication and/or [OAuth](https://en.wikipedia.org/wiki/OAuth), you need to implement it yourself. I'll likely follow up next time with an [oauth](https://en.wikipedia.org/wiki/OAuth) implementation in [**Zap**](https://github.com/zigzap/zap).

## The End

You can find the code for the article [here](https://github.com/edyu/wtf-zig-zap).

**Zap** is [here](https://github.com/zigzap/zap) and the patched **facil.io** is [here](https://github.com/zigzap/facil.io).

**Facil.io** is [here](https://facil.io) and the code is [here](https://github.com/boazsegev/facil.io).

The examples are [here](https://github.com/zigzap/zap/tree/master/examples).

## ![Zig Logo](https://ziglang.org/zero.svg)
