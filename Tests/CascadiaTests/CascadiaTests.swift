import Cascadia
import Testing

@Test func testStylesheet() async throws {
  let stylesheet = StyleSheet {
    Import("abc.css")

    StyleRule(.all) {
      Background(.red)
    }
  }

  #expect(stylesheet.render() == "@import \"abc.css\";* {background: red;}")
}

@Test func propertyBuilder() async throws {
  let o1 = Background(.red)
  let o2 = BackgroundColor(.red)
  let o3 = Color(.red)
  let o4 = ColorInterpolation(.linearRGB)
  let o5 = StyleRule(.all) {}
  let o6 = StyleRule(.class("abc")) {}

  let v1 = RuleBuilder.buildPartialBlock(first: o1)
  let v2 = RuleBuilder.buildPartialBlock(accumulated: v1, next: o2)
  let v3 = RuleBuilder.buildPartialBlock(accumulated: v2, next: o3)
  let v4 = RuleBuilder.buildPartialBlock(accumulated: v3, next: o4)
  let v5 = RuleBuilder.buildPartialBlock(accumulated: v4, next: o5)
  let v6 = RuleBuilder.buildPartialBlock(accumulated: v5, next: o6)

  let t1 = RuleBuilder.buildPartialBlock(first: o5)
  let t2 = RuleBuilder.buildPartialBlock(accumulated: t1, next: o4)
  // let t3 = RuleBuilder.buildPartialBlock(accumulated: t2, next: o3)
  // let t4 = RuleBuilder.buildPartialBlock(accumulated: t3, next: o2)
  // let t5 = RuleBuilder.buildPartialBlock(accumulated: t4, next: o1)
}