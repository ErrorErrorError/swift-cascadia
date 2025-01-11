@testable import Cascadia
import Testing

@Test func renderAtRule() {
  let storage = Renderer.ByteBuffer()
  let renderer = Renderer(bytes: storage)

  renderer.statement("import", value: "\"test.css\"", use: true)

  #expect(storage.collect() == "@import \"test.css\";")
}

@Test func renderDeclaration() {
  let storage = Renderer.ByteBuffer()
  let renderer = Renderer(bytes: storage)

  renderer.declaration("test", value: "value")

  #expect(storage.collect() == "test: value;")
}

@Test func renderBlockRule() async throws {
  let storage = Renderer.ByteBuffer()
  let renderer = Renderer(bytes: storage)

  var b = renderer.block("*")
  b.declaration("color", value: "red")
  b.declaration("background", value: "red")

  var n1 = b.block(".all")
  n1.declaration("hey", value: "bye")

  var n2 = b.block(".container")
  n2.declaration("test", value: "value") 

  #expect(storage.collect() == "* {color: red;background: red;.all {hey: bye;}.container {test: value;}}")
}
