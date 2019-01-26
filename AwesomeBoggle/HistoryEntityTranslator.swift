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
        
        let outBoundTimeFormatter = DateFormatter()
        outBoundTimeFormatter.locale = Locale(identifier: "en_US")
        outBoundTimeFormatter.setLocalizedDateFormatFromTemplate("hh:mm:ss a")
        let humanReadableCreatedOnTime = outBoundTimeFormatter.string(from: createdOnDate)
        
        let humanReadableDescription = "You \((datum["win"] as! Int) == 1 ? "won" : "lost") on \(humanReadableCreatedOnDate) at \(humanReadableCreatedOnTime)"
        
        let rawScores = datum["scores"] as! [[String:Any]]
        let scores: String = rawScores.map(rawToScoreText).joined(separator: ", ")
        return GameHistoryEntry(gameDescription: humanReadableDescription, scores: scores)
    }
    
    static func rawToScoreText(rawScore: [String:Any]) -> String {
        return "\(rawScore["username"] as! String): \(rawScore["score"] as! Int)"
    }
    
    struct ScoreEntry {
        var username: String
        var score: Int
    }
}
