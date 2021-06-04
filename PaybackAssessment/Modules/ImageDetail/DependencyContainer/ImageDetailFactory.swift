//
//  ImageDetailFactory.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

typealias ImageDetailFactory = ImageDetailViewControllerFactory

protocol ImageDetailViewControllerFactory {
    func makeImageDetailViewController(imageURL: URL) -> ImageDetailViewController
}
