@testable @_spi(Renderer) import Cascadia
import Testing

@Test func renderAtRule() {
  var renderer = _CSSTextRenderer()
  renderer.statement("import", value: "\"test.css\"", use: true)

  #expect(renderer.finish() == "@import \"test.css\";")
}

@Test func renderDeclaration() {
  var renderer = _CSSTextRenderer()
  renderer.declaration("test", value: "value")

  #expect(renderer.finish() == "test: value;")
}

@Test func renderBlockRule() async throws {
  var renderer = _CSSTextRenderer()

  renderer.block("*") { b in
    b.declaration("color", value: "red")
    b.declaration("background", value: "red")

    b.block(".all") { n in
      n.declaration("hey", value: "bye")
    }

    b.block(".container") { n in
      n.declaration("test", value: "value")
    }
  }

  #expect(renderer.finish() == "* {color: red;background: red;.all {hey: bye;}.container {test: value;}}")
}
