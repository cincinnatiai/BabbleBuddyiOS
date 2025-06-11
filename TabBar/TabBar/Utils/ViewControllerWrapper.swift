//
//  ViewControllerWrapper.swift
//  TabBar
//
//  Created by Noel Hiram Pat Angulo on 6/10/25.
//

import SwiftUI
import UIKit

struct ViewControllerWrapper: UIViewControllerRepresentable {
    let viewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
