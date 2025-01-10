@testable import Cascadia
import Testing

@Test func testStylesheet() async throws {
  let stylesheet = Stylesheet {
    Import("abc.css")

    All() => {
      Background(.red)
      BackgroundColor(.red)
      Color(.red)
      ColorInterpolation(.linearRGB)

      Class("container") => {
      }
    }
  }
}

@Test func propertyBuilder() async throws {
  let o1 = Background(.red)
  let o2 = BackgroundColor(.red)
  let o3 = Color(.red)
  let o4 = ColorInterpolation(.linearRGB)
  let o5 = Select(.all) {}
  let o6 = Select(.class("abc")) {}

  let v1 = StatementBuilder.buildPartialBlock(first: o1)
  let v2 = StatementBuilder.buildPartialBlock(accumulated: v1, next: o2)
  let v3 = StatementBuilder.buildPartialBlock(accumulated: v2, next: o3)
  let v4 = StatementBuilder.buildPartialBlock(accumulated: v3, next: o4)
  let v5 = StatementBuilder.buildPartialBlock(accumulated: v4, next: o5)
  let v6 = StatementBuilder.buildPartialBlock(accumulated: v5, next: o6)

  let t1 = StatementBuilder.buildPartialBlock(first: o5)
  let t2 = StatementBuilder.buildPartialBlock(accumulated: t1, next: o4)
  let t3 = StatementBuilder.buildPartialBlock(accumulated: t2, next: o3)
  let t4 = StatementBuilder.buildPartialBlock(accumulated: t3, next: o2)
  let t5 = StatementBuilder.buildPartialBlock(accumulated: t4, next: o1)
}
