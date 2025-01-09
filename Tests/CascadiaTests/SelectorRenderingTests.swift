import Testing
@testable import Cascadia

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
}

@Test func elementSelector() async throws {
  #expect(Element(.a).render() == "a", "element does not match")
  #expect(Element(.address).render() == "address", "element does not match")
  #expect(Element(.div).render() == "div", "element does not match")
  #expect(Element(.button).render() == "button", "element does not match")
}

@Test func pseudoClass() async throws {
  #expect(Pseudo(.active).render() == ":active")
  #expect(Pseudo(.default).render() == ":default")
}

@Test func pseudoElement() async throws {
  #expect(Pseudo(.after).render() == "::after")
  #expect(Pseudo(.placeholder).render() == "::placeholder")
}
