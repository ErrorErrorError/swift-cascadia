@testable import Cascadia
import Testing

@Test func renderAtRule() {
  let storage = Renderer.TokensStorage()
  let renderer = Renderer(storage)
  renderer.statement("import", value: "\"test.css\"", use: true)

  #expect(storage.collect() == "@import \"test.css\";")
}

@Test func renderDeclaration() {
  let storage = Renderer.TokensStorage()
  let renderer = Renderer(storage)

  renderer.declaration("test", value: "value")

  #expect(storage.collect() == "test: value;")
}

@Test func renderBlockRule() async throws {
  let storage = Renderer.TokensStorage()
  let renderer = Renderer(storage)

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

  #expect(storage.collect() == "* {color: red;background: red;.all {hey: bye;}.container {test: value;}}")
}
