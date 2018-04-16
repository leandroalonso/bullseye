import Quick
import Nimble

// These testes mocks the backend so we can manipulate it :)
// More about Swifter and iOS: http://swiftpearls.com/dynamic-ui-testing-http-mocking.html

class IntegrationSpecs: QuickSpec {
  override func spec() {
    describe("The BullsEye Game") {

      var app: XCUIApplication!
      var dynamicStubs: HTTPDynamicStubs!

      beforeSuite {
        dynamicStubs = HTTPDynamicStubs()
        dynamicStubs.setUp()
      }

      beforeEach {
        app = XCUIApplication()
        app.launchArguments.append("ui-tests")
        app.launch()
      }

      afterEach {
        app.terminate()
      }

      afterSuite {
        dynamicStubs.tearDown()
      }

      it("opens the score screen") {
        dynamicStubs.setupStub(url: "/api/scores", filename: "scores")

        app.buttons["starButton"].tap()

        expect(app.staticTexts["Fulano"].exists).toEventually(beTrue())
      }
    }
  }
}
