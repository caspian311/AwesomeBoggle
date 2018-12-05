import Foundation

protocol GamesServiceProtocol: class {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ())
    func joinGame(_ opponenets: [Int], _ callback: @escaping (ErrorMessage?, GameData?) -> ())
    func readyToPlay(_ gameId: Int, _ callback: @escaping (ErrorMessage?) -> ())
    func isGameReady(_ gameId: Int, _ callback: @escaping (ErrorMessage?, Bool?) -> ())
}

class GamesService: BaseService, GamesServiceProtocol {
    let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ()) {
        let authToken = getAuthToken()
        
        self.get(url: self.baseUrl.appendingPathComponent("/users"), auth: authToken) { (errorOptional, availableGames: [UserData]?) in
            if let error = errorOptional {
                callback(error, nil)
            } else {
                callback(nil, availableGames)
            }
        }
    }
    
    func joinGame(_ opponenets: [Int], _ callback: @escaping (ErrorMessage?, GameData?) -> ()) {
        let authToken = getAuthToken()
        
        let data: [String:Any] = ["userIds": opponenets]
        self.post(url: self.baseUrl.appendingPathComponent("/games"), auth: authToken, requestData: data) { (errorOptional, game: GameData?) in
            if let error = errorOptional {
                callback(error, nil)
            } else {
                callback(nil, game)
            }
        }
    }
    
    func readyToPlay(_ gameId: Int, _ callback: @escaping (ErrorMessage?) -> ()) {
        let authToken = getAuthToken()
        
        self.put(url: self.baseUrl.appendingPathComponent("/games/\(gameId)"), auth: authToken, requestData: [:]) {(errorOptional, gameData: GameData?) in
            callback(errorOptional)
        }
    }
    
    func isGameReady(_ gameId: Int, _ callback: @escaping (ErrorMessage?, Bool?) -> ()) {
        let authToken = getAuthToken()
        // TODO
        self.get(url: self.baseUrl.appendingPathComponent("/games/\(gameId)"), auth: authToken) {(errorOptional, gameOptional: GameData?) in
            if errorOptional != nil {
                callback(errorOptional, nil)
            } else {
                let game = gameOptional!
                // TODO
                callback(nil, false)
            }
        }
        
    }
    
    private func getAuthToken() -> String {
        let userData = self.coreDataManager.fetchUser()!
        return userData.authToken!
    }
}
