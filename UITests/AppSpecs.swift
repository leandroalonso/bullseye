import Quick
import Nimble

// Cheat sheet: https://github.com/joemasilotti/UI-Testing-Cheat-Sheet

class AppSpecs: QuickSpec {
  override func spec() {
    describe("The BullsEye Game") {

      var app: XCUIApplication!

      beforeEach {
        app = XCUIApplication()
        app.launch()
      }

      afterEach {
        app.terminate()
      }

      it("shows an alert with a message when the user succeeds") {
        let target = CGFloat(Double(app.staticTexts["targetLabel"].label)!)
        let normalizedTarget = CGFloat(target / 100)

        app.sliders["slider"].adjust(toNormalizedSliderPosition: normalizedTarget)

        app.buttons["hitMe"].tap()

        expect(app.alerts.firstMatch.exists).toEventually(beTrue())
      }

      it("opens the score screen") {
        app.buttons["starButton"].tap()

        expect(app.staticTexts["Juliana"].exists).toEventually(beTrue())
      }
    }
  }
}
