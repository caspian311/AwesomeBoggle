import Foundation
import UIKit

protocol GamesServiceProtocol: class {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ())
    func inviteToGame(_ gameId: Int, _ opponenets: [Int], _ callback: @escaping (ErrorMessage?, [Invitation]?) -> ())
    func startGame(_ callback: @escaping (ErrorMessage?, GameData?) -> ())
    func joinGame(_ gameId: Int, _ callback: @escaping (ErrorMessage?) -> ())
    func isGameReady(_ gameId: Int, _ callback: @escaping (ErrorMessage?, Bool?) -> ())
}

class GamesService: BaseService, GamesServiceProtocol {
    private let dataLayer: DataLayerProtocol
    
    init(dataLayer: DataLayerProtocol = DataLayer()) {
        self.dataLayer = dataLayer
    }
    
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ()) {
        let authToken = getAuthToken()
        
        self.get(url: self.baseUrl.appendingPathComponent("/users"), auth: authToken) { (errorOptional, availableGamesOptional) in
            if let error = errorOptional {
                callback(error, nil)
                return
            }
            
            let availableGamesData = availableGamesOptional as! [[String:Any]]
            let availableGames = availableGamesData.map {
                UserData(
                    id: $0["id"] as! Int,
                    username: $0["username"] as! String,
                    authToken: nil)
            }
            callback(nil, availableGames)
        }
    }
    
    func inviteToGame(_ gameId: Int, _ opponenets: [Int], _ callback: @escaping (ErrorMessage?, [Invitation]?) -> ()) {
        let authToken = getAuthToken()
        
        let data: [String:Any] = [ "userIds": opponenets ]
        self.post(url: self.baseUrl.appendingPathComponent("/games/\(gameId)/invitations"), auth: authToken, requestData: data) { (errorOptional, invitationsOptional) in
            
            if let error = errorOptional {
                callback(error, nil)
                return
            }
            
            let invitationData = invitationsOptional as! [[String:Any]]
            let invitations = invitationData.map {
                Invitation(
                    gameId: $0["gameId"] as! Int,
                    userId: $0["userId"] as! Int,
                    username: $0["username"] as! String,
                    accepted: $0["accepted"] as! Bool)
            }
            callback(nil, invitations)
        }
    }
    
    func startGame(_ callback: @escaping (ErrorMessage?, GameData?) -> ()) {
        let authToken = getAuthToken()
        
        self.post(url: self.baseUrl.appendingPathComponent("/games"), auth: authToken, requestData: [:]) { (errorOptional, gameOptional) in
            
            if let error = errorOptional {
                callback(error, nil)
                return
            }
            
            let gameData = gameOptional as! [String:Any]
            let game = GameData(
                id: gameData["gameId"] as! Int,
                grid: gameData["grid"] as! String,
                isReady: gameData["isReady"] as! Bool)
            callback(nil, game)
        }
    }
    
    func joinGame(_ gameId: Int, _ callback: @escaping (ErrorMessage?) -> ()) {
        let authToken = getAuthToken()
        
        self.put(url: self.baseUrl.appendingPathComponent("/games/\(gameId)/invitations"), auth: authToken, requestData: [:]) { (errorOptional, gameOptional) in
            
            callback(errorOptional)
        }
    }
    
    func isGameReady(_ gameId: Int, _ callback: @escaping (ErrorMessage?, Bool?) -> ()) {
        let authToken = getAuthToken()
        let url = self.baseUrl
            .appendingPathComponent("game")
            .appendingPathComponent("\(gameId)")
        self.get(url: url, auth: authToken) {(errorOptional, gameOptional) in
            
            if let error = errorOptional {
                callback(error, nil)
                return
            }
            
            let gameData = gameOptional as! [String:Any]
            let isReady = gameData["isRead"] as! Bool
            callback(nil, isReady)
        }
        
    }
    
    private func getAuthToken() -> String {
        let userData = self.dataLayer.fetchUser()!
        return userData.authToken!
    }
}
