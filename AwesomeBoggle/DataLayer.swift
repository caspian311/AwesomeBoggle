import Foundation
import SQLite

protocol DataLayerProtocol: class {
    func save(user: UserData)
    func fetchUser() -> UserData?
    
    func save(currentGame: GameData)
    func fetchCurrentGame() -> GameData?
    func clearCurrentGame() -> ()
    
    func fetchWordCount() -> Int
    func save(dictionaryWords: [String])
    func fetchWordBy(text: String) -> DictWord?
    
    func save(invitations: [Invitation])
}

class DataLayer: DataLayerProtocol {
    private let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    
    private let db: Connection
    private let userData: Table
    private let userDataId: Expression<Int>
    private let userDataUsername: Expression<String>
    private let userDataAuthToken: Expression<String?>
    
    private let dictionaryWord: Table
    private let dictionaryWordId: Expression<Int>
    private let dictionaryWordText: Expression<String>
    
    private let currentGame: Table
    private let currentGameId: Expression<Int>
    private let currentGameGrid: Expression<String>
    private let currentGameIsReady: Expression<Bool>
    
    private let dictWord: Table
    private let dictWordId: Expression<Int>
    private let dictWordText: Expression<String>
    
    private let invitation: Table
    private let invitationId: Expression<Int>
    private let invitationGameId: Expression<Int>
    private let invitationUserId: Expression<Int>
    private let invitationUsername: Expression<String>
    private let invitationAccepted: Expression<Bool>
    
    init(_ dbPath: String? = nil) {
        let defaultPath = "\(path)/db.sqlite3"
        
        let databasePath = dbPath ?? defaultPath
        print("using database path: \(databasePath)")
        
        db = try! Connection(databasePath)
        
        userData = Table("UserData")
        userDataId = Expression<Int>("id")
        userDataUsername = Expression<String>("username")
        userDataAuthToken = Expression<String?>("authToken")
        
        dictionaryWord = Table("DictionaryWord")
        dictionaryWordId = Expression<Int>("id")
        dictionaryWordText = Expression<String>("text")
        
        currentGame = Table("CurrentGame")
        currentGameId = Expression<Int>("id")
        currentGameGrid = Expression<String>("grid")
        currentGameIsReady = Expression<Bool>("isReady")
        
        dictWord = Table("DictWord")
        dictWordId = Expression<Int>("id")
        dictWordText = Expression<String>("text")
        
        invitation = Table("invitation")
        invitationId = Expression<Int>("invitationId")
        invitationGameId = Expression<Int>("invitationGameId")
        invitationUserId = Expression<Int>("invitationUserId")
        invitationUsername = Expression<String>("invitationUsername")
        invitationAccepted = Expression<Bool>("invitationAccepted")
        
        try! db.run(userData.create(ifNotExists: true) { t in
            t.column(userDataId, primaryKey: .autoincrement)
            t.column(userDataUsername, unique: true)
            t.column(userDataAuthToken, unique: true)
        })
        
        try! db.run(dictionaryWord.create(ifNotExists: true) { t in
            t.column(dictionaryWordId, primaryKey: .autoincrement)
            t.column(dictionaryWordText, defaultValue: "")
        })
        
        try! db.run(currentGame.create(ifNotExists: true) { t in
            t.column(currentGameId, unique: true)
            t.column(currentGameGrid, defaultValue: "")
            t.column(currentGameIsReady, defaultValue: false)
        })
        
        try! db.run(dictWord.create(ifNotExists: true) { t in
            t.column(dictWordId, primaryKey: .autoincrement)
            t.column(dictWordText, defaultValue: "")
        })
        
        
        try! db.run(invitation.create(ifNotExists: true) { t in
            t.column(invitationId, primaryKey: .autoincrement)
            t.column(invitationGameId)
            t.column(invitationUserId)
            t.column(invitationUsername)
            t.column(invitationAccepted, defaultValue: false)
        })
    }
    
    func save(user: UserData) {
        let insert = userData.insert(userDataId <- user.id, userDataUsername <- user.username, userDataAuthToken <- user.authToken)
        try! db.run(insert)
    }
    
    func fetchUser() -> UserData? {
        return Array(try! db.prepare(userData).map { UserData(id: $0[userDataId], username: $0[userDataUsername], authToken: $0[userDataAuthToken]) }).first
    }
    
    func save(currentGame: GameData) {
        let insert = self.currentGame.insert(currentGameId <- currentGame.id, currentGameGrid <- currentGame.grid, currentGameIsReady <- currentGame.isReady)
        try! db.run(insert)
    }
    
    func fetchCurrentGame() -> GameData? {
        return Array(try! db.prepare(currentGame).map { GameData(id: $0[currentGameId], grid: $0[currentGameGrid], isReady: $0[currentGameIsReady]) }).first
    }
    
    func clearCurrentGame() {
        let del = self.currentGame.delete()
        try! db.run(del)
    }
    
    func fetchWordCount() -> Int {
        return try! db.scalar(dictWord.count)
    }
    
    func save(dictionaryWords: [String]) {
        let insertStatement = try! db.prepare("INSERT INTO DictWord (text) VALUES (?)")
        
        try! db.transaction(.deferred) { () -> Void in
            for text in dictionaryWords {
                try! insertStatement.run(text)
            }
        }
    }
    
    func fetchWordBy(text: String) -> DictWord? {
        return Array(try! db.prepare(dictWord.where(dictWordText == text.lowercased())).map { DictWord(id: $0[dictWordId], text: $0[dictWordText]) }).first
    }
    
    func save(invitations: [Invitation]) {
        invitations.forEach {
            let insert = invitation.insert(invitationGameId <- $0.gameId, invitationUserId <- $0.userId, invitationUsername <- $0.username, invitationAccepted <- $0.accepted)
            try! db.run(insert)
        }
    }
}
