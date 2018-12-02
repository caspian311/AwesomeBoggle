import Foundation

protocol GamesServiceProtocol: class {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ())
}

class GamesService: BaseService, GamesServiceProtocol {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ()) {
        self.get(url: self.baseUrl.appendingPathComponent("/users")) { (errorOptional, availableGames: [UserData]?) in
            if let error = errorOptional {
                callback(error, nil)
            } else {
                callback(nil, availableGames)
            }
        }
    }
}
