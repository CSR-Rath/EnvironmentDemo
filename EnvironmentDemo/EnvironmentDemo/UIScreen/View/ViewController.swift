//
//  ViewController.swift
//  EnvironmentDemo
//
//  Created by Rath! on 5/6/24.
//

import UIKit
import SwiftEntryKit


import SwiftEntryKit

class ViewController: UIViewController {
    
    private var tableView : UITableView!
    private let refreshControl = UIRefreshControl()
    var isPunchcard = true
    
    private var dataListPunch =  PunchCardModel(){
        didSet{
            tableView.reloadData()
            Loading.shared.hideLoading()
//            Loading.hideLoading(self)
            
        }
    }
    
    private var dataList =  RedeemListModel(){
        didSet{
            tableView.reloadData()
            Loading.shared.hideLoading()
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        print("Root_URL \(DemoEnvironment.rootURL)")
        print("Api_Kery \(DemoEnvironment.apiKey)")
        // Do any additional setup after loading the view.
        setupTableView()
        
        getdataFromApi()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
    
    
    private func setupTableView(){
        
        
        
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    
    private func getdataFromApi(){
        
        let viewModel = GetDataFromApi()
        
        Loading.shared.showLoading()
        //To to long tasks
        
        if isPunchcard {
        
            
            viewModel.tappedButtomRed { data in
                DispatchQueue.main.async { [self] in
                    dataListPunch = data
                }
            }
            
        }else{
            viewModel.tappedButtomOrange { data in
                DispatchQueue.main.async { [self] in
                    dataList = data
                }
            }
        }
    }
    
    
    
    @objc func ok (){
        
        
        
        
        //        var attributes = EKAttributes()
        //        attributes.position = .bottom
        ////        attributes.position = .center
        //        attributes.displayDuration = .infinity
        //        attributes.screenBackground = .color(color: .dimmedLightBackground)
        //        attributes.entryInteraction  = .absorbTouches
        //
        //
        //        let window = UIApplication.shared.windows.first
        ////        let topPadding = window?.safeAreaInsets.top
        //        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        //
        //
        //        // Set the position constraints
        //        let positionConstraints = EKAttributes.PositionConstraints(
        //            verticalOffset: -bottomPadding, // No spacing at the bottom
        //            maxSize: .init(
        //                width: .fill,
        //                height: .intrinsic
        //            )
        //        )
        //
        //        attributes.positionConstraints = positionConstraints
        //
        //        let contentView = PopUpMessageView()
        //        contentView.actionButton.addTarget(self,
        //                                           action: #selector(tappedOk),
        //                                           for: .touchUpInside)
        //        SwiftEntryKit.display(entry: contentView,
        //                              using: attributes)
    }
    
    
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        refreshControl.endRefreshing()
    }
    
    
    @objc func tappedOk(){
        SwiftEntryKit.dismiss()
        print("tappedOk")
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isPunchcard {
            return dataListPunch.results?.count ?? 0
        }else{
            return dataList.results?.count ?? 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Number \(indexPath.row)"
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let presentMessageView = PresentMessageView()
//        presentMessageView.messageLabel.text = "This is a custom modal presentation with scroll to dismiss."
//        presentMessageView.modalPresentationStyle = .overCurrentContext
//        presentMessageView.modalTransitionStyle = .crossDissolve
//        present(presentMessageView, animated: true)
//        

        
        let presentMessageView = AlertInternetVC()
            presentMessageView.messageLabel.text = "This is a custom modal presentation with scroll to dismiss."
            
            presentMessageView.modalPresentationStyle = .overFullScreen
            presentMessageView.modalTransitionStyle = .crossDissolve
            present(presentMessageView, animated: true, completion: nil)
    }
    

}






class AlertInternetVC: UIViewController {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }
    
    
    // MARK: - Properties
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.orange
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(AlertInternetVC.self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .gray.withAlphaComponent(0.5)
        return scrollView
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animatePresentation()
    }
    
    
    
    
    
    // MARK: - View Configuration
    private func configureView() {
        view.backgroundColor = .clear
        
        view.addSubview(scrollView)
        view.addSubview(containerView)
        
//        containerView.addSubview(messageLabel)
//        containerView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
//            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
//            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
//            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
//            
//            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
//            closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    // MARK: - Presentation Animation
    private func animatePresentation() {
        blurEffectView.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
            self.blurEffectView.alpha = 1
            self.containerView.transform = .identity
        }
    }
    
    // MARK: - Button Actions
    @objc private func closeButtonTapped() {
        animateDismissal()
    }
    
    private func animateDismissal() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
            self.blurEffectView.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}

public class PopUpMessageView: UIView {
    
    // MARK: - Properties
    
    private let  lineViewTop = UIView ()
    var imageView: UIImageView!
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    public let actionButton = UIButton()
    public var  didTapped : (()->())?
    
    private let  topView = UIView ()
    private let  bottomView = UIView ()
    
    lazy var stackView: UIStackView = {
        let  stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupLineTopView()
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupActionButton()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        topView.backgroundColor = .clear
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 15
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        
        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(bottomView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        let height = UIScreen.main.bounds.height-330
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            topView.heightAnchor.constraint(equalToConstant: height),
            bottomView.heightAnchor.constraint(equalToConstant: 330)
            
        ])
        
        // Create a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        // Add the gesture recognizer to the view
        topView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        print("View was tapped!")
    }
    
    private func setupLineTopView() {
        
        lineViewTop.layer.cornerRadius = 3
        lineViewTop.backgroundColor = .lightGray
        lineViewTop.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(lineViewTop)
        
        NSLayoutConstraint.activate([
            lineViewTop.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 15),
            lineViewTop.widthAnchor.constraint(equalToConstant: 60),
            lineViewTop.heightAnchor.constraint(equalToConstant: 6),
            lineViewTop.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
        ])
        
    }
    
    private func setupImageView() {
        
        imageView = UIImageView()
        imageView.image = .add.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
        ])
        
    }
    
    private func setupTitleLabel() {
        bottomView.addSubview(titleLabel)
        titleLabel.text = "Message"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
        ])
        
    }
    
    private func setupDescriptionLabel() {
        bottomView.addSubview(descriptionLabel)
        descriptionLabel.text = "Description"
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            
        ])
    }
    
    private func setupActionButton() {
        bottomView.addSubview(actionButton)
        actionButton.setTitle("Ok", for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = .red
        actionButton.layer.cornerRadius = 10
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            actionButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -30),
            actionButton.widthAnchor.constraint(equalToConstant: 400),
            actionButton.heightAnchor.constraint(equalToConstant: 45),
            actionButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
        ])
    }
}


//
//
//class ViewControllerAlert: UIViewController {
//
//    let presentationService = PresentationService()
//    
//    let buttonsStack: UIStackView = {
//        let stack = UIStackView()
//        stack.alignment = .fill
//        stack.distribution = .fill
//        stack.axis = .vertical
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.spacing = 12
//        return stack
//    }()
//     
//    let toastButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Present floating toast", for: .normal)
//        button.backgroundColor = .blue
//        return button
//    }()
//    
//    let alertButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Present alert", for: .normal)
//        button.backgroundColor = .blue
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(buttonsStack)
//        buttonsStack.addArrangedSubview(toastButton)
//        buttonsStack.addArrangedSubview(alertButton)
//        NSLayoutConstraint.activate([
//            buttonsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            toastButton.heightAnchor.constraint(equalToConstant: 56),
//            alertButton.heightAnchor.constraint(equalToConstant: 56)
//        ])
//        toastButton.addTarget(self, action: #selector(presentToast), for: .primaryActionTriggered)
//        alertButton.addTarget(self, action: #selector(presentAlert), for: .primaryActionTriggered)
//        customBannerButton.addTarget(self, action: #selector(presentCustomBanner), for: .primaryActionTriggered)
//    }
//    
//    @objc func presentToast() {
//        presentationService.presentToast(
//          title: "Error",
//          description: "Something went wrong",
//          image: UIImage(systemName: "exclamationmark.circle.fill")!
//        )
//    }
//    
//    @objc func presentAlert() {
//        //TODO: - add logic for alert presentation
//    }
//
//}





