import Foundation

protocol GamesServiceProtocol: class {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ())
}

class GemesService: BaseService, GamesServiceProtocol {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ()) {
        self.get(url: self.baseUrl.appendingPathComponent("/users")) { (errorOptional, availableUsers: [UserData]?) in
            if let error = errorOptional {
                callback(error, nil)
            } else {
                callback(nil, availableUsers)
            }
        }
    }
}
