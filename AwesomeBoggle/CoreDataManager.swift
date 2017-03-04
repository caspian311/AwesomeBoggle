import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol: class {
    func saveWord(text: String, score: Int)
    func fetchWordList() -> [BoggleWord]
}

class CoreDataManager: CoreDataManagerProtocol {
    func saveWord(text: String, score: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Word", in: managedContext)
        if let entity = entity {
            let word = NSManagedObject(entity: entity, insertInto: managedContext)

            word.setValue(text, forKeyPath: "text")
            word.setValue(score, forKeyPath: "score")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
    func fetchWordList() -> [BoggleWord] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Word")
        
        var wordList:[BoggleWord] = []
        do {
            let dataResults = try managedContext.fetch(fetchRequest)
            
            wordList = dataResults.map{ BoggleWord(($0 as! Word).text!) }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        return wordList
        
    }
}
