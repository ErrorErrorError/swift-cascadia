@testable import Cascadia
import Testing

@Suite("Property rendering tests")
struct PropertyRenderingTests {
  @Test func propertyRenderer() async throws {
    let a = Color(.red)
    let b = BackgroundColor(.red)
    let c = Background(.red)

    #expect(a.render() == "color: red;")
    #expect(b.render() == "background-color: red;")
    #expect(c.render() == "background: red;")
  }
}
