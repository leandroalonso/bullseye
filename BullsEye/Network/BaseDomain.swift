struct BaseDomain {
  static var host: String {
    if !BaseDomain.isTestingEnvironment {
      return BaseDomain.hostProduction
    } else {
      return BaseDomain.hostDevelopment
    }
  }

  static var isTestingEnvironment = false

  static let hostProduction = "https://us-central1-capdev-score-api.cloudfunctions.net"
  static let hostDevelopment = "http://localhost:8080"
}
