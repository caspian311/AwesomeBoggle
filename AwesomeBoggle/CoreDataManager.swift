import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol: class {
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

class CoreDataManager: CoreDataManagerProtocol {
    private let appDelegate: AppDelegate;
    
    init(_ appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    func fetchGames() -> [BoggleGame] {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
        
        var gameList: [BoggleGame] = []
        do {
            let dataResults = try managedContext.fetch(fetchRequest)
            
            gameList = (dataResults as! [Game]).map{ BoggleGame(id: $0.id!, date: $0.date! as Date, score: Int($0.score)) }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        return gameList
    }

    func save(game: BoggleGame) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Game", in: managedContext)
        if let entity = entity {
            let item = NSManagedObject(entity: entity, insertInto: managedContext)
            
            item.setValue(game.id, forKey: "id")
            item.setValue(game.date, forKey: "date")
            item.setValue(game.score, forKey: "score")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error)")
            }
        }
    }
    
    func fetchUser() -> UserData? {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        var user: UserData? = nil
        do {
                let dataResults = try managedContext.fetch(fetchRequest)
            
                if let data = dataResults.first {
                let id = data.value(forKey: "id") as! Int
                let username = data.value(forKey: "username") as! String
                let authToken = data.value(forKey: "authToken") as! String
                
                user = UserData(id: id, username: username, authToken: authToken)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        
        return user
    }
    
    func save(user: UserData) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        item.setValue(user.id, forKey: "id")
        item.setValue(user.username, forKey: "username")
        item.setValue(user.authToken, forKey: "authToken")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
    func save(currentGame: GameData) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CurrentGame", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        item.setValue(currentGame.id, forKey: "id")
        item.setValue(currentGame.grid, forKey: "grid")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
    func fetchCurrentGame() -> GameData? {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CurrentGame")
        
        var game: GameData? = nil
        do {
            let dataResults = try managedContext.fetch(fetchRequest)
            
            if let data = dataResults.first {
                let id = data.value(forKey: "id") as! Int
                let grid = data.value(forKey: "grid") as! String
                let isReady = data.value(forKey: "isReady") as! Bool
                
                game = GameData(id: id, grid: grid, isReady: isReady)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        
        return game
    }
    
    func fetchDictionaryWords() -> [DictWord] {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DictionaryWord")
        
        var wordList: [DictWord] = []
        do {
            let dataResults = try managedContext.fetch(fetchRequest)
            
            wordList = dataResults.map{ DictWord(text: $0.value(forKey: "text") as! String) }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        return wordList
    }
    
    func save(dictionaryWords: [DictWord]) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        dictionaryWords.forEach { (dictionaryWord) in
            let word = NSEntityDescription.insertNewObject(forEntityName: "DictionaryWord", into: managedContext) as! DictionaryWord
            word.text = dictionaryWord.text
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
    func fetchWordBy(text: String) -> DictWord? {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DictionaryWord")
        
        var word: DictWord? = nil
        do {
            fetchRequest.predicate = NSPredicate(format: "text = @", text)
            let dataResults = try managedContext.fetch(fetchRequest)
            if let data = dataResults.first {
                word = DictWord(text: data.value(forKey: "text") as! String)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        return word
    }
}
