//
//  UIImageView+Extension.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie

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

    func addAnimationView(name: String, withContentMode: UIView.ContentMode = .scaleAspectFill) -> AnimationView {
        let size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        let animationView = AnimationView(name: name)
        animationView.contentMode = withContentMode
        animationView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        animationView.loopMode = .loop
        self.addSubview(animationView)
        return animationView
    }
}
