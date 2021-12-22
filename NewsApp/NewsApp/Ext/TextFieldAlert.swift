//
//  TextFieldAlert.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 21.12.2021.
//

import Foundation
import SwiftUI
import UIKit

struct TextFieldAlert {

  // MARK: Properties
  let title: String
  let message: String?
  @Binding var text: String?
  var isPresented: Binding<Bool>? = nil
    var action: () -> ()

  // MARK: Modifiers
  func dismissable(_ isPresented: Binding<Bool>) -> TextFieldAlert {
      TextFieldAlert(title: title, message: message, text: $text, isPresented: isPresented, action: action)
  }
}

extension TextFieldAlert: UIViewControllerRepresentable {

  typealias UIViewControllerType = TextFieldAlertViewController

  func makeUIViewController(context: UIViewControllerRepresentableContext<TextFieldAlert>) -> UIViewControllerType {
    TextFieldAlertViewController(title: title, message: message, text: $text, isPresented: isPresented, action: action)
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType,
                              context: UIViewControllerRepresentableContext<TextFieldAlert>) {
    // no update needed
  }
}

struct TextFieldWrapper<PresentingView: View>: View {

  @Binding var isPresented: Bool
  let presentingView: PresentingView
  let content: () -> TextFieldAlert

  var body: some View {
    ZStack {
      if (isPresented) { content().dismissable($isPresented) }
      presentingView
    }
  }
}
