import Foundation

protocol GamesServiceProtocol: class {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ())
    func joinGame(_ opponenets: [Int], _ callback: @escaping (ErrorMessage?, GameData?) -> ())
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
    
    private func getAuthToken() -> String {
        let userData = self.coreDataManager.fetchUser()!
        return userData.authToken!
    }
}
