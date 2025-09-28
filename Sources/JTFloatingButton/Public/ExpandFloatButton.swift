//
//  ExpandFloatButton.swift
//  CommonSwiftUI
//
//  Created by James Thang on 26/06/2024.
//

import SwiftUI

/// A SwiftUI view component that displays a floating action button with expandable action buttons.
///
/// `ExpandFloatButton` offers a dynamic way to present multiple action buttons from a main floating button.
/// It supports expansion in specified directions and can adapt the shape of the action buttons.
///
/// - Parameters:
///   - buttonSize: The size of the floating button and each action button.
///   - alignment: The direction in which the action buttons will expand from the main button. (e.g., leading, trailing, top, bottom).
///   - spacing: The space between the expanded action buttons.
///   - shape: The shape of each action button, conforming to the `Shape` protocol.
///   - actions: An array of `FloatingAction` objects defining the actions for the expanded buttons.
///   - label: A view builder that generates the content displayed on the expandable floating button.
///
/// ## Usage:
/// ```swift
/// import CommonSwiftUI
///
/// struct ExpandFloatButtonTest: View {
///     let actions: [FloatingAction] = [
///         FloatingAction(image: Image(systemName: "tray.full.fill"), tint: .red) { print("Tray") },
///         FloatingAction(image: Image(systemName: "lasso.badge.sparkles"), tint: .orange) { print("Spark") },
///         FloatingAction(image: Image(systemName: "square.and.arrow.up.fill"), tint: .yellow) { print("Share") },
///         FloatingAction(image: Image(systemName: "heart.fill"), tint: .green) { print("Heart") },
///         FloatingAction(image: Image(systemName: "paperplane"), tint: .cyan) { print("Plane") }
///     ]
///
///     var body: some View {
///         VStack {
///             ExpandFloatButton(alignment: .leading, actions: actions) { isExpanded in
///                 Image(systemName: "plus")
///                     .font(.title3.bold())
///                     .foregroundStyle(.white)
///                     .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
///                     .frame(maxWidth: .infinity, maxHeight: .infinity)
///                     .background(.black, in: .circle)
///             }
///         }
///         .padding()
///     }
/// }
/// ```
/// This example creates an `ExpandFloatButton` with five action buttons that expand from the main '+' button when tapped.
/// 
/// The ExpandFloatButton efficiently enhances the user interface by integrating multiple action options into a single floating button. This design not only saves valuable screen space but also adds a sophisticated aesthetic element to the user interface.
/// 
/// It is particularly beneficial in applications where quick access to multiple functions is necessary without cluttering the screen, offering an intuitive and streamlined user experience.
///
public struct ExpandFloatButton<CustomShape: Shape, Label: View>: View {
    
    public enum Direction {
        case leading, trailing, top, bottom
        
        var alignment: Alignment {
            switch self {
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            case .top:
                return .top
            case .bottom:
                return .bottom
            }
        }
    }
    
    // Actions
    private var buttonSize: CGFloat
    private var alignment: ExpandFloatButton.Direction
    private var spacing: CGFloat
    private var actions: [FloatingAction]
    private var shape: CustomShape
    private var label: (Bool) -> Label
    // View Properties
    @State private var isExpanded: Bool = false
    @State private var iconMask: Bool = false
    
    private var offsetX: CGFloat {
        let value = (buttonSize + spacing) * CGFloat(actions.count)
        switch alignment {
        case .leading:
            return value
        case .trailing:
            return -value
        case .top, .bottom:
            return 0
        }
    }
    
    private var offsetY: CGFloat {
        let value = (buttonSize + spacing) * CGFloat(actions.count)
        switch alignment {
        case .leading, .trailing:
            return 0
        case .top:
            return value
        case .bottom:
            return -value 
        }
    }
    
    private var maskWidth: CGFloat {
        switch alignment {
        case .leading, .trailing:
            return abs(offsetX) + 8
        case .top, .bottom:
            return buttonSize + 8
        }
    }
    
    private var maskHeight: CGFloat {
        switch alignment {
        case .leading, .trailing:
            return buttonSize + 8
        case .top, .bottom:
            return abs(offsetY) + 8
        }
    }
    
    private var animationTime: Double {
        let value = Double(actions.count) * 0.1
        return value > 0.5 ? value : 0.5
    }
    
    public init(buttonSize: CGFloat = 50, alignment: ExpandFloatButton.Direction = .leading, spacing: CGFloat = 8, @FloatingActionBuilder actions: @escaping () -> [FloatingAction], shape: CustomShape = Circle(), @ViewBuilder label: @escaping (Bool) -> Label) {
        self.buttonSize = buttonSize
        self.alignment = alignment
        self.spacing = spacing
        self.actions = actions()
        self.shape = shape
        self.label = label
    }
    
    public init(buttonSize: CGFloat = 50, alignment: ExpandFloatButton.Direction = .leading, spacing: CGFloat = 8, actions: [FloatingAction], shape: CustomShape = Circle(), @ViewBuilder label: @escaping (Bool) -> Label) {
        self.buttonSize = buttonSize
        self.alignment = alignment
        self.spacing = spacing
        self.actions = actions
        self.shape = shape
        self.label = label
    }
    
    public var body: some View {
        ZStack(alignment: alignment.alignment) {
            switch alignment {
            case .leading, .trailing:
                HStack(spacing: spacing) {
                    ButtonsView
                }
                .mask {
                    Rectangle()
                        .frame(width: iconMask ? maskWidth : 0, height: maskHeight)
                        .frame(maxWidth: .infinity, alignment: alignment.alignment)
                }
                
                LabelView
            case .top, .bottom:
                VStack(spacing: spacing) {
                    ButtonsView
                }
                .mask {
                    Rectangle()
                        .frame(width: maskWidth, height: iconMask ? maskHeight : 0)
                        .frame(maxHeight: .infinity, alignment: alignment.alignment)
                }
                
                LabelView
            }
        }
    }
    
    private var LabelView: some View {
        Button {
            withAnimation(.easeInOut(duration: animationTime)) {
                isExpanded.toggle()
            }
            
            withAnimation(.easeInOut(duration: iconMask ? animationTime + 0.1 : animationTime)) {
                iconMask.toggle()
            }
        } label: {
            label(isExpanded)
                .frame(width: buttonSize, height: buttonSize)
                .contentShape(.rect)
        }
        .frame(width: abs(offsetX) + buttonSize, height: abs(offsetY) + buttonSize, alignment: alignment.alignment)
        .offset(x: isExpanded ? offsetX : 0, y: isExpanded ? offsetY : 0)
        .buttonStyle(NoAnimationButtonStyle())
    }
    
    private var ButtonsView: some View {
        ForEach(0..<actions.count, id: \.self) { index in
            ActionView(actions[index])
                .animation(.spring(response: 0.4, dampingFraction: 0.6).delay(delayAnimationTime(index)), value: isExpanded)
        }
    }
    
    @ViewBuilder
    private func ActionView(_ action: FloatingAction) -> some View {
        Button(action: {
            action.action()
            withAnimation(.easeInOut(duration: animationTime)) {
                isExpanded = false
            }
            
            withAnimation(.easeInOut(duration: iconMask ? animationTime + 0.1 : animationTime)) {
                iconMask = false
            }
        }, label: {
            action.image
                .font(action.font)
                .foregroundStyle(action.tint)
                .frame(width: buttonSize, height: buttonSize)
                .background(action.background, in: shape)
                .contentShape(shape)
        })
        .scaleEffect(isExpanded ? 1 : 0)
        .buttonStyle(PressableButtonStyle())
        .disabled(!isExpanded)
    }
    
    private func delayAnimationTime(_ index: Int) -> Double {
        switch self.alignment {
        case .leading, .top:
            return isExpanded ? Double(index) * 0.1 : Double(actions.count - index - 1) * 0.1
        case .trailing, .bottom:
            return isExpanded ? Double(actions.count - index - 1) * 0.1 : Double(index) * 0.1
        }
    }
    
}
