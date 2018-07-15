//
//  PointOfInterestView.swift
//  UrbanGuide
//

import UIKit

class PointOfInterestView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        addBorder()
    }

    static var view: PointOfInterestView {
        let bundle = Bundle(for: self.classForCoder())
        let nibName = "PointOfInterestView"
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! PointOfInterestView
    }

    func configure(_ pointOfInterest: PointOfInterest, _ distance: Double) {
        nameLabel.text = pointOfInterest.name
        distanceLabel.text = "\(Int(distance)) m"
        imageView.image = UIImage(named: pointOfInterest.image)
    }

    func addBorder() {
        imageView.layer.cornerRadius = frame.width/2
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
    }

}
