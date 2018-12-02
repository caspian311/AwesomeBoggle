import Foundation

protocol GamesServiceProtocol: class {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ())
    func joinGame(_ gameId: Int, _ callback: @escaping (ErrorMessage?, GameData?) -> ())
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
    
    func joinGame(_ gameId: Int, _ callback: @escaping (ErrorMessage?, GameData?) -> ()) {
        let data: [String:Any] = [:]
        self.post(url: self.baseUrl.appendingPathComponent("/games"), requestData: data) { (errorOptional, game: GameData?) in
            if let error = errorOpational {
                callback(error, nil)
            } else {
                callback(nil, game)
            }
        }
    }
}
