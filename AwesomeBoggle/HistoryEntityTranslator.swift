import Foundation

class HistoryEntityTranslator {
    static func translate(datum: [String:Any]) -> GameHistoryEntry {
        let createdOn = datum["createdOn"] as! String
        
        let inBoundDateFormatter = DateFormatter()
        inBoundDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inBoundDateFormatter.locale = Locale(identifier: "en_US")
        let createdOnDate = inBoundDateFormatter.date(from: createdOn)!
        
        let outBoundDateFormatter = DateFormatter()
        outBoundDateFormatter.locale = Locale(identifier: "en_US")
        
        outBoundDateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/YYYY")
        let humanReadableCreatedOnDate = outBoundDateFormatter.string(from: createdOnDate)
        
        outBoundDateFormatter.setLocalizedDateFormatFromTemplate("hh:mm:ss a")
        let humanReadableCreatedOnTime = outBoundDateFormatter.string(from: createdOnDate)
        
        let gameTime = " on \(humanReadableCreatedOnDate) at \(humanReadableCreatedOnTime)"
        
        let gameResult = (datum["win"] as! Int) == 1
        let rawScores = datum["scores"] as! [[String:Any]]
        let scores: String = rawScores.map(rawToScoreText).joined(separator: ", ")
        return GameHistoryEntry(gameResult: gameResult, gameTime: gameTime, scores: scores)
    }
    
    static func rawToScoreText(rawScore: [String:Any]) -> String {
        return "\(rawScore["username"] as! String): \(rawScore["score"] as! Int)"
    }
    
    struct ScoreEntry {
        var username: String
        var score: Int
    }
}
