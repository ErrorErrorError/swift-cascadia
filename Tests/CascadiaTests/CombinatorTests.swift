import Testing
@testable import Cascadia

@Test func chainingSelectors() async throws {
  #expect((Element(.div) <> Class("container") <> ID("id")).render() == "div.container#id")
  #expect(Element(.div).chain(.class("container")).chain(.id("id")).render() == "div.container#id")
}

@Test func childCombinator() async throws {
  #expect(((All() > Element(.div)) > (Class("container") > ID("id"))).render() == "* > div > .container > #id")
  #expect(All().child(.element(.div)).child(.class("container")).child(.id("id")).render() == "* > div > .container > #id")
}

@Test func descendantCombinator() async throws {
  #expect((All() * Element(.div) * Class("container") * ID("id")).render() == "* div .container #id")
  #expect(All().descendant(.element(.div)).descendant(.class("container")).descendant(.id("id")).render() == "* div .container #id")
}

@Test func nextSiblingCombinator() async throws {
  #expect((All() + Element(.div) + Class("container") + ID("id")).render() == "* + div + .container + #id")
  #expect(All().next(.element(.div)).next(Class("container")).next(ID("id")).render() == "* + div + .container + #id")
}

@Test func subsequentSiblingCombinator() async throws {
  #expect((All() ~ Element(.div) ~ Class("container") ~ ID("id")).render() == "* ~ div ~ .container ~ #id")
  #expect(All().subsequent(.element(.div)).subsequent(Class("container")).subsequent(ID("id")).render() == "* ~ div ~ .container ~ #id")
}

@Test func mixCombinators() async throws {
  #expect((All() ~ Element(.div) * Class("container") + ID("id") <> Attribute("class") <> Pseudo(.active) > Class("box")).render() == "* ~ div .container + #id[class]:active > .box")
}