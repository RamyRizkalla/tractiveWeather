//Copyright © 2020 Tractive. All rights reserved.

import UIKit

extension UITableView {
    func dequeueCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: "\(Cell.self)", for: indexPath) as? Cell ?? Cell()
    }
}
