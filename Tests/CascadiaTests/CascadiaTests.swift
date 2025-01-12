@testable import Cascadia
import Testing

@Test func testStylesheet() async throws {
  let stylesheet = StyleSheet {
    if true {
      Import("abc.css")
    } else {
      EmptyRule()
    }

    StyleRule(.all) {
      // Background(.red)
    }
  }

  #expect(stylesheet.render() == "@import \"abc.css\";* {}")
}