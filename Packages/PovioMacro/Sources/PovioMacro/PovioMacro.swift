// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(member, names: named(init))
public macro StructInit() = #externalMacro(module: "PovioMacroMacros", type: "StructInitMacro")
