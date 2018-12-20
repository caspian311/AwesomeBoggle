import Foundation

class DataLoadingStatus {
    var progress: Int?
    var total: Int?
    var message: String?
    var status: StatusType = .Initialized
}

enum StatusType {
    case Initialized
    case Fetched
    case Loading
    case Done
    case Error
}
