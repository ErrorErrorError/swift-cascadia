import Testing
import Cascadia

@Test func testStylesheet() async throws {
  let stylesheet = Stylesheet {
    Import("subs.css")
    Import("style.css")

    Class("container") {
      Background(.red)
    }

    All {
      Class("container") > ID("id") {
        Background(.red)
      }
    }
  }
}

@Test func testProperties() async throws {}
