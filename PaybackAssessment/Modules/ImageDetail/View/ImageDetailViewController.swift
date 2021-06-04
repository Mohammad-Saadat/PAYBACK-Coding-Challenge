//
//  ImageDetailViewController.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//

import UIKit

class ImageDetailViewController: UIViewController {

    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("ImageDetailViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: ImageDetailFactory) {
        super.init(nibName: ImageDetailViewController.nibName, bundle: nil)
        self.factory = factory
        ImageDetailLogger.logInit(owner: String(describing: ImageDetailViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        ImageDetailLogger.logDeinit(owner: String(describing: ImageDetailViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var imageURL: URL?
    
    // MARK: Private
    private var factory: ImageDetailFactory!
    
    // MARK: - Outlets
    @IBOutlet weak var tailDetailImage: UIImageView!
}

// MARK: - View Controller

// MARK: Life Cycle
extension ImageDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage(with: imageURL)
    }
}

// MARK: - Methods

// MARK: Private
private extension ImageDetailViewController {
    func setupImage(with source: URL?) {
        guard let imageResource = source else { return }
        tailDetailImage.setImage(with: imageResource)
    }
}

// MARK: - Actions
extension HomeViewController {
    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
