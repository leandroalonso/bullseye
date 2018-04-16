import Alamofire

class ScoreService {

  let defaultSession = URLSession(configuration: .default)
  var dataTask: URLSessionDataTask?

  func all(completion: @escaping ([Score]) -> Void) {
    dataTask?.cancel()

    let url = URL(string: "\(BaseDomain.host)/api/scores/")
    dataTask = defaultSession.dataTask(with: url!) { [weak self] data, response, error in
      if let data = data {
        if let scores = self?.parse(jsonData: data) {
          completion(scores)
        } else {
          completion([])
        }
      }
    }

    dataTask?.resume()
  }

  func save(_ score: Score, completion: @escaping (Bool) -> Void) {
    let parameters: Parameters = ["name": score.name! as Any,
                                  "score": "\(score.score!)"]
    Alamofire.request("\(BaseDomain.host)/api/scores/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).response { response in
      if response.error == nil {
        completion(true)
      } else {
        completion(false)
      }
    }
  }

  private func parse(jsonData data: Data) -> [Score] {
    do {
      let decoder = JSONDecoder()
      let scores = try decoder.decode([Score].self, from: data)
      return scores
    } catch {
      print(error.localizedDescription)
    }
    return []
  }
}
