//
//  AsyncImageView.swift
//  Weather
//
//  Created by Virender Dall on 01/09/21.
//

import UIKit

class AsyncImageView: UIImageView {

    private func loadImageFrom(url:URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(data: data)
                }
            }
            
        task.resume()
    }

    func downloadImage(url:String){
        guard let url = URL(string: url) else {
            return
        }
        loadImageFrom(url: url)
    }
}
