import Foundation

protocol GamesServiceProtocol: class {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ())
    func inviteToGame(_ gameId: Int, _ opponenets: [Int], _ callback: @escaping (ErrorMessage?, GameData?) -> ())
    func startGame(_ callback: @escaping (ErrorMessage?, GameData?) -> ())
    func joinGame(_ gameId: Int, _ callback: @escaping (ErrorMessage?) -> ())
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
    
    func inviteToGame(_ gameId: Int, _ opponenets: [Int], _ callback: @escaping (ErrorMessage?, GameData?) -> ()) {
        let authToken = getAuthToken()
        
        let data: [String:Any] = [ "userIds": opponenets ]
        self.post(url: self.baseUrl.appendingPathComponent("/games/\(gameId)/invitations)"), auth: authToken, requestData: data) { (errorOptional, game: GameData?) in
            if let error = errorOptional {
                callback(error, nil)
            } else {
                callback(nil, game)
            }
        }
    }
    
    func startGame(_ callback: @escaping (ErrorMessage?, GameData?) -> ()) {
        let authToken = getAuthToken()
        
        self.post(url: self.baseUrl.appendingPathComponent("/games"), auth: authToken, requestData: [:]) { (errorOptional, game: GameData?) in
            if let error = errorOptional {
                callback(error, nil)
            } else {
                callback(nil, game)
            }
        }
    }
    
    func joinGame(_ gameId: Int, _ callback: @escaping (ErrorMessage?) -> ()) {
        let authToken = getAuthToken()
        
        self.put(url: self.baseUrl.appendingPathComponent("/games/\(gameId)/invitations"), auth: authToken, requestData: [:]) { (errorOptional, game: GameData?) in
            if let error = errorOptional {
                callback(error)
            } else {
                callback(nil)
            }
        }
    }
    
    func isGameReady(_ gameId: Int, _ callback: @escaping (ErrorMessage?, Bool?) -> ()) {
        let authToken = getAuthToken()
        let url = self.baseUrl
            .appendingPathComponent("game")
            .appendingPathComponent("\(gameId)")
        self.get(url: url, auth: authToken) {(errorOptional, gameOptional: GameData?) in
            if errorOptional != nil {
                callback(errorOptional, nil)
            } else {
                callback(nil, gameOptional?.isReady)
            }
        }
        
    }
    
    private func getAuthToken() -> String {
        let userData = self.coreDataManager.fetchUser()!
        return userData.authToken!
    }
}
