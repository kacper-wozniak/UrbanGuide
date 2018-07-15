//
//  PointOfInterestDetailsViewController.swift
//  UrbanGuide
//

import UIKit

class PointOfInterestDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var websiteLabel: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var pointOfInterest: PointOfInterest!

    override func viewDidLoad() {
        nameLabel.text = pointOfInterest.name
        addressLabel.text = pointOfInterest.address
        websiteLabel.text = pointOfInterest.website
        descriptionLabel.text = pointOfInterest.description
        imageView.image = UIImage(named: pointOfInterest.image)
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
