//
//  ImageDetailDependencyContainer.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class ImageDetailDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        ImageDetailLogger.logInit(owner: String(describing: ImageDetailDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        ImageDetailLogger.logDeinit(owner: String(describing: ImageDetailDependencyContainer.self))
    }
}

// MARK: - Factory
extension ImageDetailDependencyContainer: ImageDetailFactory {
    func makeImageDetailViewController(imageURL: URL) -> ImageDetailViewController {
        let vc = ImageDetailViewController(factory: self)
        vc.imageURL = imageURL
        return vc
    }
}
