import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol: class {
    func save(game: BoggleGame)
    func fetchGames() -> [BoggleGame]
    
    func save(user: UserData)
    func fetchUser() -> UserData?
}

class CoreDataManager: CoreDataManagerProtocol {
    func fetchGames() -> [BoggleGame] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
}
