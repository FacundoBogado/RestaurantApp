//
//  CustomTableViewCell.swift
//  RestaurantApp
//
//  Created by Facu Bogado on 09/05/2022.
//

import UIKit

protocol tableViewProtocol {
    func configure(model: Restaurant)
}

private struct Constants {
    static let filledHearth = "filled-heart.png"
    static let emptyHearth = "empty-heart.png"
    static let theForkName = "TheFork"
    static let tripAdvisorName = "TripAdvisor"
    static let preferedSeparation = 5.0
    static let preferedSpaces = 70.0
    static let imageViewDimension = 300.0
    static let favButtonTrailing = 10.0
    static let ratingLeading = 40.0
}

class CustomTableViewCell: UITableViewCell, tableViewProtocol {
    static let identifier = "CustomTableViewCell"
    private var restaurantId: String = ""
    private let userDefault = UserDefaults.standard

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private lazy var taRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var tfRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private lazy var favouriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var restaurantPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var taLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "ta-logo")
        return imageView
    }()
    
    private lazy var tfLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "tf-logo")
        return imageView
    }()
    
    private lazy var locationLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "location")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: Restaurant) {
        self.nameLabel.text = model.name
        self.adressLabel.text = model.address.street
        self.tfRatingLabel.text = String(model.aggregateRatings.thefork.ratingValue)
        self.restaurantId = model.uuid
        setupUI(model: model)
        
    }

    @objc func didTapButton(sender: UIButton!) {
        if userDefault.bool(forKey: self.restaurantId) {
            userDefault.removeObject(forKey: restaurantId)
        } else {
            userDefault.setValue(true, forKey: self.restaurantId)
        }
        setupFavouriteState()
    }
}

// MARK: - Internal func
private extension CustomTableViewCell {
    func setupUI(model: Restaurant) {
        setupImage(imageURL: model.mainPhoto?.source)
        setupFavouriteState()
        setupTfRating(reviewCount: model.aggregateRatings.thefork.reviewCount,
                        ratingValue: String(model.aggregateRatings.thefork.ratingValue))
        setupTaRating(reviewCount: model.aggregateRatings.tripadvisor.reviewCount,
                        ratingValue: String(model.aggregateRatings.tripadvisor.ratingValue))
    }
    
    func setupTfRating(reviewCount: Int, ratingValue: String) {
        tfRatingLabel.text = setRatingText(companyName: Constants.theForkName,
                                           reviewCount: reviewCount,
                                           ratingValue: ratingValue)
    }

    func setupTaRating(reviewCount: Int, ratingValue: String) {
        taRatingLabel.text = setRatingText(companyName: Constants.tripAdvisorName,
                                           reviewCount: reviewCount,
                                           ratingValue: ratingValue)
    }
    
    func setRatingText(companyName: String, reviewCount: Int, ratingValue: String) -> String{
        return "\(companyName) got \(reviewCount) amount of reviews,\nwith a rating of \(ratingValue)"
    }

    func setupView() {
        setupNameLabel()
        setupFavButton()
        setupImageView()
        setupAdress()
        setupTfRating()
        setupTaRating()
    }
    
    func setupImage(imageURL: String?) {
        // NOTE: all of this is because some urls from the json are down :)
        do {
            let url = imageURL ?? ""
            let data = try Data(contentsOf: URL(string: url) ?? URL(string: Constants.emptyHearth)!)
            self.restaurantPhoto.image = UIImage(data: data)
        } catch {
            print("there was an error parsing an image")
        }
    }
    
    func setupFavouriteState() {
        let buttonImage = userDefault.bool(forKey: self.restaurantId) ? Constants.filledHearth : Constants.emptyHearth
        if let image = UIImage(named: buttonImage) {
            favouriteButton.setImage(image, for: .normal)
        }
    }
    
    func setupNameLabel() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.preferedSeparation),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.preferedSpaces),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.preferedSpaces)
        ])
    }
    
    func setupFavButton(){
        contentView.addSubview(favouriteButton)
        NSLayoutConstraint.activate([
            favouriteButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.preferedSeparation),
            favouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.favButtonTrailing)
        ])
    }
    
    func setupAdress() {
        contentView.addSubview(adressLabel)
        contentView.addSubview(locationLogo)
        NSLayoutConstraint.activate([
            adressLabel.topAnchor.constraint(lessThanOrEqualTo: restaurantPhoto.bottomAnchor, constant: Constants.preferedSeparation),
            adressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.preferedSpaces),
            adressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.preferedSpaces),
            locationLogo.leadingAnchor.constraint(lessThanOrEqualTo: adressLabel.leadingAnchor, constant: Constants.preferedSeparation),
            locationLogo.topAnchor.constraint(lessThanOrEqualTo: restaurantPhoto.bottomAnchor, constant: Constants.preferedSeparation)
        ])
    }

    func setupImageView() {
        contentView.addSubview(restaurantPhoto)
        NSLayoutConstraint.activate([
            restaurantPhoto.topAnchor.constraint(lessThanOrEqualTo: nameLabel.bottomAnchor, constant: Constants.preferedSeparation),
            restaurantPhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            restaurantPhoto.heightAnchor.constraint(equalToConstant: Constants.imageViewDimension),
            restaurantPhoto.widthAnchor.constraint(equalToConstant: Constants.imageViewDimension),
        ])
    }
    
    func setupTfRating() {
        contentView.addSubview(tfRatingLabel)
        contentView.addSubview(tfLogo)
        NSLayoutConstraint.activate([
            tfRatingLabel.topAnchor.constraint(lessThanOrEqualTo: adressLabel.bottomAnchor, constant: Constants.favButtonTrailing),
            tfRatingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tfLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.favButtonTrailing),
            tfLogo.topAnchor.constraint(lessThanOrEqualTo: adressLabel.bottomAnchor, constant: Constants.favButtonTrailing),
        ])
    }
    
    func setupTaRating() {
        contentView.addSubview(taRatingLabel)
        contentView.addSubview(taLogo)
        NSLayoutConstraint.activate([
            taRatingLabel.topAnchor.constraint(lessThanOrEqualTo: tfRatingLabel.bottomAnchor, constant: Constants.favButtonTrailing),
            taRatingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            taLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.preferedSeparation),
            taLogo.topAnchor.constraint(lessThanOrEqualTo: tfRatingLabel.bottomAnchor, constant: Constants.favButtonTrailing),
        ])
    }
}
