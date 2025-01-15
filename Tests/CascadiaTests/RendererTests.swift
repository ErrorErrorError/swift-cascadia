@testable @_spi(Renderer) import Cascadia
import Testing

@Suite("Renderer tests")
struct RendererTests {
  @Test func renderAtRule() {
    var writer = _TextBufferWriter()
    var renderer = Renderer(&writer, config: .init())
    renderer.statement(atSymbol: true, "import", value: "\"test.css\"")

    #expect(writer.finish() == "@import \"test.css\";")
  }

  @Test func renderDeclaration() {
    var writer = _TextBufferWriter()
    var renderer = Renderer(&writer, config: .init())
    renderer.declaration("test", value: "value")
    #expect(writer.finish() == "test: value;")
  }

  @Test func renderBlockRule() {
    var writer = _TextBufferWriter()
    var renderer = Renderer(&writer, config: .init())

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

    #expect(writer.finish() == """
    * {
      color: red;
      background: red;
      .all {
        hey: bye;
      }
      .container {
        test: value;
      }
    }
    """)
  }

  @Test func renderWithOptions() {
    var writer = _TextBufferWriter()
    var renderer = Renderer(&writer, config: .init(indent: .minify))

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
}
