import Testing
@testable import Cascadia

@Test func propertyRenderer() async throws {
  let a = Color(.red)
  let b = BackgroundColor(.red)
  let c = Background(.red)

  #expect(a.render() == "color: red;", "color does not match")
  #expect(b.render() == "background-color: red;", "background color does not match")
  #expect(c.render() == "background: red;", "background does not match")
}