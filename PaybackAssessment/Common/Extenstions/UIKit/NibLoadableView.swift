//
//  NibLoadableView.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import UIKit

public protocol NibLoadable: class {
    /// Nib name of this object
    static var nibName: String { get }

    /// Bundle containing nib of this object
    static var bundle: Bundle { get }
}

public protocol NibLoadableView: NibLoadable {
    /// Nib of this object
    static var nib: UINib { get }

    /// Loads this object from nib with some options
    ///
    /// - Parameter options: _(optional)_ A dictionary containing the options to use when opening the nib
    ///  file. For a list of available keys for this dictionary, see NSBundle UIKit Additions.
    /// - Returns: A new instance of this object
    static func loadFromNib(withOptions options: [UINib.OptionsKey: Any]?) -> Self
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }

    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

    static func loadFromNib(withOptions options: [UINib.OptionsKey: Any]? = nil) -> Self {
        guard let object = nib.instantiate(withOwner: nil, options: options).first else {
            fatalError("Could not load nib with name \"\(nibName)\"")
        }

        guard let result = object as? Self else {
            fatalError("Loaded object from nib with name \"\(nibName)\" is not of type \"\(self)\"")
        }

        return result
    }
}

public extension NibLoadable where Self: UIViewController {
    static var nibName: String {
        return String(describing: self)
    }

    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
}
