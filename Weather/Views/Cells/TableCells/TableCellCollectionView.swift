//
//  TableCellCollectionView.swift
//  Weather
//
//  Created by Virender Dall on 01/09/21.
//

import UIKit

class TableCellCollectionView: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
