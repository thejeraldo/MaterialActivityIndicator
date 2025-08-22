//
//  File.swift
//  MaterialActivityIndicator
//
//  Created by Jerald Abille on 22/08/2025.
//

import SwiftUI
import UIKit

/// A view that hosts the activity indicator view.
/// For use in UIKit.
@objc
public final class MaterialActivityIndicatorHostView: UIView {
    
    // MARK: - Private Properties
    
    private var hostingController: UIHostingController<MaterialActivityIndicator>?
    
    // MARK: - Public Properties
    
    /// The thickness of the indicator.
    @objc public var lineWidth: CGFloat {
        didSet { updateRootView() }
    }
    
    /// The color of the indicator.
    @objc public var color: UIColor {
        didSet { updateRootView() }
    }
    
    // MARK: - Init
    
    @objc
    public init(lineWidth: CGFloat = 4, color: UIColor = .black) {
        self.lineWidth = lineWidth
        self.color = color
        super.init(frame: .zero)
        setupHostingController()
    }
    
    required init?(coder: NSCoder) {
        self.lineWidth = 4
        self.color = .black
        super.init(coder: coder)
        setupHostingController()
    }
    
    // MARK: - Setup
    
    private func setupHostingController() {
        let indicator = MaterialActivityIndicator(
            lineWidth: lineWidth,
            tintColor: color
        )
        let hosting = UIHostingController(rootView: indicator)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.backgroundColor = .clear
        addSubview(hosting.view)
        NSLayoutConstraint.activate([
            hosting.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hosting.view.topAnchor.constraint(equalTo: topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        self.hostingController = hosting
    }
    
    // MARK: - Private Methods
    
    private func updateRootView() {
        hostingController?.rootView = MaterialActivityIndicator(
            lineWidth: lineWidth,
            tintColor: color
        )
    }
}

// MARK: - Sample Usage & Preview

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityView = MaterialActivityIndicatorHostView(lineWidth: 4, color: .systemTeal)
        activityView.backgroundColor = .white
        activityView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityView)
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityView.widthAnchor.constraint(equalToConstant: 20),
            activityView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

struct SwiftUIPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return MyViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

#Preview {
    SwiftUIPreview()
}
