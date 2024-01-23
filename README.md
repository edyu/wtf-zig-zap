# Zig Zap -- WTF is Zap

The power of **Zap** for Zig

---

Ed Yu ([@edyu](https://github.com/edyu) on Github and
[@edyu](https://twitter.com/edyu) on Twitter)
January.23.2024

---

![Zig Logo](https://ziglang.org/zig-logo-dark.svg)

## Introduction

[**Zig**](https://ziglang.org) is a modern systems programming language and although it claims to a be a **better C**, many people who initially didn't need systems programming were attracted to it due to the simplicity of its syntax compared to alternatives such as **C++** or **Rust**.

However, due to the power of the language, some of the syntaxes are not obvious for those first coming into the language. I was actually one such person.

Today we will explore an awesome **Zig** project called [**Zap**](https://github.com/zigzap/zap). From a high level, [**Zap**](https://github.com/zigzap/zap) is web-server. However, it's not a web-server fully implemented in **Zig**. It's a wrapper on top of a **C** web-server (library) called [facil.io](https://facil.io).

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

![](https://raw.githubusercontent.com/zigzap/zap/master/wrk/samples/req_per_sec_graph.png)
![](https://raw.githubusercontent.com/zigzap/zap/master/wrk/samples/xfer_per_sec_graph.png)

[**Zap**](https://github.com/zigzap/zap) is simple because [Rene](https://github.com/renerocksai) didn't implement anything he didn't need and when he does need a feature, he tried to implement it in a very straightforward way which is inline with the design philosophy of **Zig** itself. His code is a pleasure to read and I can honestly say that he was probably the primary reason I was able to learn **Zig**.
[**Zap**](https://github.com/zig) also has one of the best [examples](https://github.com/zigzap/zap/tree/master/examples) of any projects on github. Just by looking at the [example](https://github.com/zigzap/zap/tree/master/examples), you should be able to get up to speed quickly.

## Why Not Zap

Of course, [**Zap**](https://github.com/zigzap/zap) is not for everyone and here are three reasons why you may not want to use it:

    1. If you have [NIH Syndrome](https://en.wikipedia.org/wiki/Not_invented_here), [**Zap**](https://github.com/zigzap/zap) is **NOT** implemented in **Zig**. 
    2. If you are on Widnows or you need [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2) or [HTTP/3](https://en.wikipedia.org/wiki/HTTP/3) because [facil.io](https://facil.io) only implemented HTTP/1.0 and HTTP/1.1.
    3. You need to write a lot of code even for simple things in [**Zap**](https://github.com/zigzap/zap) compared to most other web frameworks because [**Zap**](https://github.com/zigzap/zap) is a web-server not a web framework.

![](https://www.opeadeoye.ng/CMSFiles/The-Lagoon-Chronicles/images/Dilbert-not-invented-here_strip.gif)

For any new language, there is a tendency for early adopters of that language to reimplement everything in the new shiny language. Even if the language is not new anymore, there will still be plenty of people creating a new *framework* in that language.  

This is certainly not the case for [**Zap**](https://github.com/zigzap/zap) because every feature that was exposed is used by [Rene](https://github.com/renerocksai) himself.

He also made it very clear that [**Zap**](https://github.com/zigzap/zap) will not reimplement everything in [facil.io](https://facil.io) using **Zig**. [Rene](https://github.com/renerocksai) also tried to minimize any changes to the upstream [facil.io](https://github.com/boazsegev/facil.io).  Unfortunately, it also means that [**Zap**](https://github.com/zigzap/zap) won't run on Windows.

Lastly, you do have to understand that even the simplest language and simplest wrapper would introduce artifacts that complicate the usage due to impedence mismatch. 

For example, to get a string parameter that are passed in the URL, you have to do the following in **Zap**.

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

There is also no authentication or authorization built-in so you'll end up writing a lot of code to implement these yourself.

In some private tests I've done myself, you end up writing about 5 times as much code in **Zig** and **Zap** than if you use something like Python [FastAPI](https://fastapi.tiangolo.com), or even comparing to an extremely a young web-framework such as Julia [Oxygen.jl](https://ndortega/Oxygen.jl). So whethat that's worth the tradeoff if up to you. 

Fortunately, as more people start using **Zig**, more features are being added. For example, **Zap** recently finally has *TLS* added. The   

## Bonus


## The End

**Zap** is [here](https://github.com/zigzap/zap) and the patched **facil.io** is [here](https://github.com/zigzap/facil.io).

**Facil.io** is [here](https://facil.io) and the code is [here](https://github.com/boazsegev/facil.io).

## ![Zig Logo](https://ziglang.org/zero.svg)
