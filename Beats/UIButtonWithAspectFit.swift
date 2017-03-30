
import UIKit

class UIButtonWithAspectFit: UIButton {
    
    override func awakeFromNib() {
        self.imageView?.contentMode = .ScaleAspectFit
    }
    
}
