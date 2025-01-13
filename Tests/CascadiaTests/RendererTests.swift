@testable import Cascadia
import Testing

@Test func renderAtRule() {
  let writer = CSSTextWriter()
  let renderer = Renderer(writer)
  renderer.statement("import", value: "\"test.css\"", use: true)

  #expect(writer.finish() == "@import \"test.css\";")
}

@Test func renderDeclaration() {
  let writer = CSSTextWriter()
  let renderer = Renderer(writer)

  renderer.declaration("test", value: "value")

  #expect(writer.finish() == "test: value;")
}

@Test func renderBlockRule() async throws {
  let writer = CSSTextWriter()
  let renderer = Renderer(writer)

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

  #expect(writer.finish() == "* {color: red;background: red;.all {hey: bye;}.container {test: value;}}")
}
