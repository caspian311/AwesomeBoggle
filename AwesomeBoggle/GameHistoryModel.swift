import Foundation
import UIKit

protocol GameHistoryModelProtocol: class {
    func showGameList(_ gameList: [GameHistoryEntry])
}

class GameHistoryModel {
    weak var delegate: GameHistoryModelProtocol?
    
    let dataLayer: DataLayerProtocol
    
    init(dataLayer: DataLayerProtocol = DataLayer()) {
        self.dataLayer = dataLayer
    }
    
    func populate() {
//        let gameList = self.dataLayer.fetchGames().map({ (game: BoggleGame) -> GameHistoryEntry in
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_US")
//            dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/YYYY hh:mm:ss a")
//            let humanReadableDate = dateFormatter.string(from: game.date)
//            
//            return GameHistoryEntry(score: Int(game.score), date: humanReadableDate)
//        })
//        self.delegate?.showGameList(gameList)
    }
}

class GameHistoryEntry {
    let date: String
    let score: Int
    
    init(score: Int, date: String) {
        self.date = date
        self.score = score
    }
}
