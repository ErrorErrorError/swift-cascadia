import Cascadia
import Testing

@Test func testStylesheet() async throws {
  let result = stylesheet {
    Import("style.css")
  }
  
  #expect(result == "@import \"style.css\";")
}

@Test func customStylesheet() async throws {
  struct CustomSheet: StyleSheet {
    var body: some Rule {
      Import("abc.css")

      StyleRule(.all) {
        Background(.red)

        StyleRule(.class("container")) {
          Color(.red)
        }
      }
    }
  }

  #expect(CustomSheet().render() == "@import \"abc.css\";* {background: red;.container {color: red;}}")
}