import Foundation
import UIKit

protocol AvailableGamesViewProtocol: class {
    
}

class AvailableGamesView: GradientView {
    weak var delegate: AvailableGamesViewProtocol?
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
