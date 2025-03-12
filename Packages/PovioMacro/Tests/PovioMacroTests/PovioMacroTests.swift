import PovioMacroMacros
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

let testMacros: [String: Macro.Type] = [
  "StructInit": StructInitMacro.self,
]

final class PovioMacroTests: XCTestCase {
  func testMacro() {
    assertMacroExpansion(
            """
            @StructInit
            struct Foo {
              var bar: Int
              var too: String
              var crake: String
            }
            """,
            expandedSource:
            """
            
            struct Foo {
              var bar: Int
              var too: String
              var crake: String
            
                public init(bar: Int, too: String, crake: String) {
                    self.bar = bar
                    self.too = too
                    self.crake = crake
                }
            }
            """,
            macros: testMacros
    )
  }
}
