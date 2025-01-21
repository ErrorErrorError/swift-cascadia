import Cascadia
import Testing

@Suite("Cascadia tests")
struct CascadiaTests {
  @Test func minifiedStylesheet() async throws {
    let result = stylesheet(using: .init(indent: .minify)) {
      Charset(.utf8)
      Import("style.css")

      All() => {
        Background(.color(.red))

        Class("container") => {
          Color(.red)
        }
      }
    }

    #expect(result == #"@charset "UTF-8";@import "style.css";*{background:red;.container{color:red;}}"#)
  }

  @Test func minifiedCustomStylesheet() async throws {
    struct CustomSheet: StyleSheet {
      var body: some Rule {
        Charset(.utf8)
        Import("style.css")

        All() => {
          Background(.color(.red))

          Class("container") => {
            Color(.red)
          }
        }
      }
    }

    #expect(CustomSheet().render(using: .init(indent: .minify)) == #"@charset "UTF-8";@import "style.css";*{background:red;.container{color:red;}}"#)
  }

  @Test func spacingStylesheet() async throws {
    let result = stylesheet(using: .init(indent: .spaces(2))) {
      Charset(.utf8)
      Import("style.css")

      All() => {
        Background(.color(.red))
        BorderColor(.red)

        Class("container") => {
          Color(.red)
        }
      }
    }

    #expect(result ==
      """
      @charset "UTF-8";
      @import "style.css";
      * {
        background: red;
        border-color: red;
        .container {
          color: red;
        }
      }
      """
    )
  }

  @Test func spacingCustomStylesheet() async throws {
    struct CustomSheet: StyleSheet {
      var body: some Rule {
        Charset(.utf8)
        Import("style.css")

        All() => {
          Background(.color(.red))

          Class("container") => {
            Color(.red)
          }
        }
      }
    }

    #expect(CustomSheet().render(using: .init(indent: .spaces(2))) ==
      """
      @charset "UTF-8";
      @import "style.css";
      * {
        background: red;
        .container {
          color: red;
        }
      }
      """
    )
  }
}
