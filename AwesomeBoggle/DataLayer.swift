import Foundation
import SQLite

protocol DataLayerProtocol: class {
    func save(game: BoggleGame)
    func fetchGames() -> [BoggleGame]
    
    func save(user: UserData)
    func fetchUser() -> UserData?
    
    func save(currentGame: GameData)
    func fetchCurrentGame() -> GameData?
    
    func fetchDictionaryWords() -> [DictWord]
    func save(dictionaryWords: [DictWord])
    func fetchWordBy(text: String) -> DictWord?
}

class DataLayer: DataLayerProtocol {
    private let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    
    private let db: Connection
    
    init() {
        db = try! Connection("\(path)/db.sqlite3")
    }
    
    func setup() {
        let userData = Table("UserData")
        let userDataId = Expression<Int64>("id")
        let userDataUsername = Expression<String?>("username")
        let userDataAuthToken = Expression<String>("authToken")

        try! db.run(userData.create(ifNotExists: true) { t in
            t.column(userDataId, primaryKey: .autoincrement)
            t.column(userDataUsername, unique: true)
            t.column(userDataAuthToken, unique: true)
        })
        
        
    }
    
    func save(game: BoggleGame) {}
    func fetchGames() -> [BoggleGame] {
        return []
        
    }
    
    func save(user: UserData) {}
    func fetchUser() -> UserData? {
        return nil
    }
    
    func save(currentGame: GameData) {}
    func fetchCurrentGame() -> GameData? {
        return nil
    }
    
    func fetchDictionaryWords() -> [DictWord] {
        return []
    }
    func save(dictionaryWords: [DictWord]) {}
    func fetchWordBy(text: String) -> DictWord? {
        return nil
    }
}
