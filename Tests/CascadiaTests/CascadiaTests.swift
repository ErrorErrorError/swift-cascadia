@testable import Cascadia
import Testing

@Test func testStylesheet() async throws {
  let stylesheet = Stylesheet {
    // Import("subs.css")
    // Import("style.css")

    Class("container") > Class("abc") {
      Background(.red)
      Background(.red)
    }

    All {
      // let hry = Class("container") {
        // let a = StatementBuilder.buildExpression(Class("abc"))
        // let b = StatementBuilder.buildExpression(Color(.red))
        // let c = StatementBuilder.buildExpression(Color(.red))

        // StatementBuilder.buildBlock(a, b, c)
      // }

      Class("abc") {
        
      }
    }

    All() * Class("app") + All {}
  }

  let test = stylesheet.body
}

@Test func testProperties() async throws {
  let hello = Class("container") {
    let a = Class("abc")
    let b = Color(.red)
    let c = BackgroundColor(.red)
    let d = Background(.red)

    let e = StatementBuilder.buildBlock(b, c, d)
    // let f = StatementBuilder.buildBlock(b, c, a)
  }
}
