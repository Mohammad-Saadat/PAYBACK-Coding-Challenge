//
//  UIImageViewExtension.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Kingfisher

extension UIImageView {
    @discardableResult
    func setImage(with resource: Resource?,
                  placeholder: Placeholder? = nil,
                  options: KingfisherOptionsInfo? = nil,
                  progressBlock: DownloadProgressBlock? = nil,
                  completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        var localOptions: KingfisherOptionsInfo = []
        if let options = options {
            localOptions = options
        }

        localOptions.append(.targetCache(ImageCache.default))
        
        return kf.setImage(with: resource,
                           placeholder: placeholder,
                           options: options,
                           progressBlock: progressBlock,
                           completionHandler: completionHandler)
    }
}
