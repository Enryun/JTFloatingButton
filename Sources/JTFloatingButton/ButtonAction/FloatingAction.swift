//
//  FloatingAction.swift
//  CommonSwiftUI
//
//  Created by James Thang on 02/06/2024.
//

import SwiftUI

/// Represents a customizable floating action button with identifiable properties.
///
/// `FloatingAction` configures a button that can be prominently displayed over content, commonly used for actions such as creating new items or triggering specific functions. This struct allows customization of the button's icon, font, colors, and action.
///
/// - Parameters:
///   - id: A unique identifier for the button, useful for distinguishing multiple instances.
///   - image: The SwiftUI `Image` to display on the button.
///   - font: The font style for any textual content inside the button.
///   - tint: The color of the button's content, typically the icon or text.
///   - background: The background color of the button.
///   - action: The closure that executes when the button is tapped.
///
/// ## Example Usage:
/// ```swift
/// FloatingAction(
///     image: Image(systemName: "plus"),
///     action: {
///         print("Floating action tapped")
///     }
/// )
/// ```
///
/// This component enhances the user interface by providing a visually appealing and interactively efficient way to perform tasks.
/// 
public struct FloatingAction: Identifiable {
    
    private(set) public var id: UUID
    private(set) public var image: Image
    private(set) public var font: Font
    private(set) public var tint: Color
    private(set) public var background: Color
    private(set) public var action: () -> ()
    
    public init(id: UUID = .init(), image: Image, font: Font = .title3, tint: Color = .white, background: Color = .black, action: @escaping () -> Void) {
        self.id = id
        self.image = image
        self.font = font
        self.tint = tint
        self.background = background
        self.action = action
    }
    
}

/// A result builder to construct an array of `FloatingAction` items for use in UI layouts.
///
/// `FloatingActionBuilder` simplifies the creation of collections of `FloatingAction` objects. It uses a result builder to encapsulate the construction logic, allowing for a declarative style of defining multiple floating actions in a clean and concise manner.
/// SwiftUI View like Builder to get array of actions using ResultBuilder
@resultBuilder
public struct FloatingActionBuilder {
    public static func buildBlock(_ components: FloatingAction...) -> [FloatingAction] {
        components.compactMap({ $0 })
    }
}
