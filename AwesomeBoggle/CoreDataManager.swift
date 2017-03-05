import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol: class {
    func save(game: BoggleGame)
    func fetchGames() -> [BoggleGame]
}

class CoreDataManager: CoreDataManagerProtocol {
    func fetchGames() -> [BoggleGame] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
        
        var gameList: [BoggleGame] = []
        do {
            let dataResults = try managedContext.fetch(fetchRequest)
            
            gameList = (dataResults as! [Game]).map{ BoggleGame(id: $0.id!, date: $0.date as! Date, score: Int($0.score)) }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        return gameList
    }

    func save(game: BoggleGame) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        
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
}
