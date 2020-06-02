//
//  UIImageView+Utilities.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(fromURL imageUrl: URL?) {
        guard let url = imageUrl else { return }
        
        let downloadTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self?.image = UIImage(data: data)
            }
        }
        
        downloadTask.resume()
    }
}
