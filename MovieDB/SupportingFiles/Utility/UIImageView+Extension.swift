//
//  UIImageView+Extension.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(urlString: String, completion: @escaping ((UIImage?, Error?) -> Void)) {
        guard let url = URL(string: urlString) else {
            completion(nil, URLError(URLError.Code.badURL))
            return
        }

        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completion(value.image, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
