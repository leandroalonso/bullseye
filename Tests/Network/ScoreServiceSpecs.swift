import Quick
import Nimble
import OHHTTPStubs

@testable import BullsEye

class IntegrationSpecs: QuickSpec {
  override func spec() {
    describe("ScoreService") {
      describe("all") {
        it("returns an array of Score") {
          stub(condition: isHost("us-central1-capdev-score-api.cloudfunctions.net")) { _ in
            let stubPath = OHPathForFile("scores.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
          }
          let service = ScoreService()
          var scores: [Score]?

          service.all { scores = $0 }

          expect(scores?.count).toEventually(equal(8))
        }
      }

      describe("save") {
        it("has the name and score as parameters of the request") {
          var request: URLRequest?
          stub(condition: isHost("us-central1-capdev-score-api.cloudfunctions.net")) { req in
            request = req
            return OHHTTPStubsResponse(data: Data(), statusCode: 200, headers: nil)
          }
          let score = Score(name: "John Doe", score: 100)
          let service = ScoreService()

          service.save(score) { _ in }

          expect(request).toNotEventually(beNil())
          let jsonParameter = String(data: request!.ohhttpStubs_httpBody!, encoding: .utf8)
          expect(jsonParameter).toEventually(equal("{\"name\":\"John Doe\",\"score\":\"100\"}"))
          expect(request?.httpMethod).toEventually(equal("POST"))
        }
      }
    }
  }
}
