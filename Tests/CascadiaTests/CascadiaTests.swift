import Testing
@testable import Cascadia

@Test func testStylesheet() async throws {
  // struct Style: Stylesheet {}
}

@Test func testProperties() async throws {
  _ = Color(.red)
  _ = Background(.color(.red))
  _ = BackgroundColor(.red)

  _ = color(.red)
  _ = background(.color(.red))
  _ = backgroundColor(.red)
}
