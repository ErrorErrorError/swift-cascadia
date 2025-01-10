import Testing
@testable import Cascadia

@Test func chainingSelectors() async throws {
  let match = "div.container#id"
  #expect((Element(.div) <> Class("container") <> ID("id")).render() == match)
  #expect(Element(.div).chain(.class("container")).chain(.id("id")).render() == match)
}

@Test func childCombinator() async throws {
  let match = "* > div > .container > #id"
  #expect(((All() > Element(.div)) > (Class("container") > ID("id"))).render() == match)
  #expect(All().child(.element(.div)).child(.class("container")).child(.id("id")).render() == match)
}

@Test func descendantCombinator() async throws {
  let match = "* div .container #id"
  #expect((All() * Element(.div) * Class("container") * ID("id")).render() == match)
  #expect(All().descendant(.element(.div)).descendant(.class("container")).descendant(.id("id")).render() == match)
}

@Test func nextSiblingCombinator() async throws {
  let match = "* + div + .container + #id"
  #expect((All() + Element(.div) + Class("container") + ID("id")).render() == match)
  #expect(All().next(.element(.div)).next(Class("container")).next(ID("id")).render() == match)
}

@Test func subsequentSiblingCombinator() async throws {
  let match = "* ~ div ~ .container ~ #id"
  #expect((All() ~ Element(.div) ~ Class("container") ~ ID("id")).render() == match)
  #expect(All().subsequent(.element(.div)).subsequent(Class("container")).subsequent(ID("id")).render() == match)
}

@Test func mixCombinators() async throws {
  let match = "* ~ div .container + #id[class]:active > .box"
  #expect((All() ~ Element(.div) * Class("container") + ID("id") <> Attribute("class") <> Pseudo(class: .active) > Class("box")).render() == match)
  #expect(All().subsequent(.element(.div)).descendant(.class("container")).next(.id("id").chain(.attr("class").chain(.pseudo(class: .active)))).child(.class("box")).render() == match)
}