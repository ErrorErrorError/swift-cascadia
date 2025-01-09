import Testing
@testable import Cascadia

@Test func testStylesheet() async throws {
  let stylesheet = Stylesheet {
    Import("subs.css")
    Import("style.css")
    All() => {
      Background(.red)
      BackgroundColor(.red)
      Color(.red)
      ColorInterpolation(.linearRGB)
    }
  }
}

@Test func multiSelector() async throws {
  #expect((Class("container") <> Attribute("data") * Element(.div)).render() == ".container[data] div")
}

@Test func propertyRenderer() async throws {
  let a = Color(.red)
  let b = BackgroundColor(.red)
  let c = Background(.red)

  #expect(a.value == .red, "color does not match")
  #expect(b.value == .red, "background color does not match")
  #expect(c.value == .red, "background does not match")
}
