@testable import Cascadia
import Testing

@Suite("AtRules tests")
struct AtRuleTests {
  @Test func renderAtRuleStatements() async throws {
    #expect(Import("test.css").render() == "@import \"test.css\";")
    #expect(Import(.url("test.css")).render() == "@import url(\"test.css\");")
  }

  @Test func renderAtRuleBlock() async throws {
    let rule = Media("screen") {}
    #expect(rule.render() == "@media screen {}")
  }
}
