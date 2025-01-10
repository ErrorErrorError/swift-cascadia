import Testing
@testable import Cascadia

@Test func atRuleTests() async throws {
  #expect(Import("test.css").render() == "@import \"test.css\"")
  #expect(Import(.url("test.css")).render() == "@import url(\"test.css\")")
}