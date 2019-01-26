import Foundation
import UIKit

protocol GamesServiceProtocol: class {
    func fetchAvailableGames(callback: @escaping (ErrorMessage?, [UserData]?) -> ())
    func inviteToGame(_ gameId: Int, _ opponenets: [Int], _ callback: @escaping (ErrorMessage?, [Invitation]?) -> ())
    func startGame(_ callback: @escaping (ErrorMessage?, GameData?) -> ())
    func joinGame(_ gameId: Int, _ callback: @escaping (ErrorMessage?) -> ())
    func isGameReady(_ gameId: Int, _ callback: @escaping (ErrorMessage?, Bool) -> ())
    func completedGame(_ gameId: Int, _ score: Int, _ callback: @escaping (ErrorMessage?) -> ())
    func fetchGameHistory(_ callback: @escaping (ErrorMessage?, [GameHistoryEntry]?) -> ())
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
    
    func isGameReady(_ gameId: Int, _ callback: @escaping (ErrorMessage?, Bool) -> ()) {
        let authToken = getAuthToken()
        let url = self.baseUrl.appendingPathComponent("/games/\(gameId)")
        self.get(url: url, auth: authToken) {(errorOptional, gameOptional) in
            
            if let error = errorOptional {
                callback(error, false)
                return
            }
            
            let gameData = gameOptional as! [String:Any]
            let isReady = gameData["isReady"] as! Bool
            callback(nil, isReady)
        }
    }
    
    private func getAuthToken() -> String {
        let userData = self.dataLayer.fetchUser()!
        return userData.authToken!
    }
    
    func completedGame(_ gameId: Int, _ score: Int, _ callback: @escaping (ErrorMessage?) -> ()) {
        let authToken = getAuthToken()
        
        self.put(url: self.baseUrl.appendingPathComponent("/games/\(gameId)"), auth: authToken, requestData: ["score": score]) { (errorOptional, gameOptional) in
            
            callback(errorOptional)
        }
    }
    
    func fetchGameHistory(_ callback: @escaping (ErrorMessage?, [GameHistoryEntry]?) -> ()) {
        self.get(url: self.baseUrl.appendingPathComponent("/games"), auth: getAuthToken()) { (errorOptional, gameListOptional) in
            
            if let error = errorOptional {
                callback(error, nil)
                return
            }
            
            let dataList = gameListOptional as! [[String:Any]]
            let gameList = dataList.map {
//                let dateFormatter = DateFormatter()
//                dateFormatter.locale = Locale(identifier: "en_US")
//                dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/YYYY hh:mm:ss a")
//                let humanReadableDate = dateFormatter.string(from: game.date)
//
//                return GameHistoryEntry(score: Int(game.score), date: humanReadableDate)
                GameHistoryEntry(score: $0["score"] as! Int, date: $0["date"] as! String) }
            callback(nil, gameList)
        }
    }
}
