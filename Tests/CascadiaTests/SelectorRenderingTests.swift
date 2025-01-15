@testable import Cascadia
import Testing

@Suite("Selector rendering tests")
struct SelectorRenderingTests {
  @Test func classSelector() async throws {
    #expect(Class("abc").render() == ".abc", "class does not match raw value")
    #expect(Class(".abc").render() == ".abc", "class with period does not match raw value")
  }

  @Test func idSelector() async throws {
    #expect(ID("abc").render() == "#abc", "id does not match raw value")
    #expect(ID("#abc").render() == "#abc", "id with hashbang does not match raw value")
  }

  @Test func allSelector() async throws {
    #expect(All().render() == "*", "id does not match raw value")
  }

  @Test func attributeSelector() async throws {
    #expect(Attribute("class").render() == "[class]")
    #expect(Attribute("class", match: .exact, value: "test").render() == "[class=\"test\"]")
    #expect(Attribute("class", match: .starts, value: "test").render() == "[class^=\"test\"]")
    #expect(Attribute("class", match: .ends, value: "test").render() == "[class$=\"test\"]")
    #expect(Attribute("class", match: .text, value: "test").render() == "[class*=\"test\"]")
    #expect(Attribute("class", match: .word, value: "test").render() == "[class~=\"test\"]")
    #expect(Attribute("class", match: .hyphen, value: "test").render() == "[class|=\"test\"]")
    #expect(Attribute("class", match: .exact, value: "test", caseSensitive: true).render() == "[class=\"test\" i]")
    #expect(Attribute("class", match: .exact, value: "test", caseSensitive: false).render() == "[class=\"test\" s]")
  }

  @Test func elementSelector() async throws {
    #expect(Element(.a).render() == "a", "element does not match")
    #expect(Element(.address).render() == "address", "element does not match")
    #expect(Element(.div).render() == "div", "element does not match")
    #expect(Element(.button).render() == "button", "element does not match")
  }

  @Test func pseudoClass() async throws {
    #expect(Pseudo(class: .active).render() == ":active")
    #expect(Pseudo(class: .default).render() == ":default")
    #expect(Pseudo(class: "custom").render() == ":custom")
    #expect(Pseudo(class: ":custom").render() == ":custom")
  }

  @Test func pseudoElement() async throws {
    #expect(Pseudo(element: .after).render() == "::after")
    #expect(Pseudo(element: .placeholder).render() == "::placeholder")
    #expect(Pseudo(element: "custom").render() == "::custom")
    #expect(Pseudo(element: "::custom").render() == "::custom")
  }
}