//
//  FloatButton.swift
//  CommonSwiftUI
//
//  Created by James Thang on 02/06/2024.
//

import SwiftUI

/// A customizable floating action button component that arcs around a main button, revealing multiple action buttons.
///
/// `ArcFloatingButton` allows for a radial or semi-circular placement of action buttons that emerge from behind the main button. It supports various alignments and can adapt to custom shapes for each action button.
///
/// - Parameters:
///   - buttonSize: The diameter of each action button.
///   - alignment: The alignment dictates the starting point and direction in which the action buttons will arc (e.g., topLeading, fullmoon).
///   - spacing: The spacing between the expanded action buttons.
///   - shape: The shape of each action button, conforming to the `Shape` protocol.
///   - actions: An array of `FloatingAction` objects defining the actions for the expanded buttons.
///   - label: A view builder that generates the content displayed on the expandable floating button.
///
///
/// ## Example:
/// ```swift
/// ArcFloatingButton(alignment: .fullmoon) {
///     FloatingAction(image: Image(systemName: "tray.full.fill"), tint: .red) {
///         print("Tray")
///     }
///     FloatingAction(image: Image(systemName: "lasso.badge.sparkles"), tint: .orange) {
///         print("Spark")
///     }
///     FloatingAction(image: Image(systemName: "square.and.arrow.up.fill"), tint: .yellow) {
///         print("Share")
///     }
///     FloatingAction(image: Image(systemName: "heart.fill"), tint: .green) {
///         print("Heart")
///     }
///     FloatingAction(image: Image(systemName: "house.fill"), tint: .blue) {
///         print("House")
///     }
///     FloatingAction(image: Image(systemName: "paperplane"), tint: .cyan) {
///         print("Plane")
///     }
/// } label: { isExpanded in
///     Image(systemName: "plus")
///         .font(.title3.bold())
///         .foregroundStyle(.white)
///         .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
///         .scaleEffect(isExpanded ? 0.9 : 1)
///         .background(.black, in: .circle)
/// }
/// ```
/// This component enhances the user interface by seamlessly integrating multiple actions into a single floating action button, providing both aesthetic appeal and functional space-saving benefits.
/// This component is ideal for interfaces that require quick access to multiple actions without cluttering the UI.
/// 
public struct ArcFloatingButton<CustomShape: Shape, Label: View>: View {
    
    public enum Alignment {
        case topLeading, topTrailing, bottomLeading, bottomTrailing, halfmoonTop, halfmoonBottom, halfmoonLeading, halfmoonTrailing, fullmoon
        
        var rotationDegrees: Double {
            switch self {
            case .topLeading, .halfmoonBottom:
                return 180
            case .topTrailing, .halfmoonLeading:
                return -90
            case .bottomLeading, .halfmoonTrailing, .fullmoon:
                return 90
            case .bottomTrailing, .halfmoonTop:
                return 0
            }
        }
        
        var distributionDegrees: Double {
            switch self {
            case .topLeading, .topTrailing, .bottomLeading, .bottomTrailing:
                return 90
            case .halfmoonTop, .halfmoonBottom, .halfmoonLeading, .halfmoonTrailing:
                return 180
            case .fullmoon:
                return 0
            }
        }
    }
    
    // Actions
    private var buttonSize: CGFloat
    private var alignment: ArcFloatingButton.Alignment
    private var actions: [FloatingAction]
    private var shape: CustomShape
    private var label: (Bool) -> Label
    // View Properties
    @State private var isExpanded: Bool = false
    
    public init(buttonSize: CGFloat = 50, alignment: ArcFloatingButton.Alignment = .bottomTrailing, @FloatingActionBuilder actions: @escaping () -> [FloatingAction], shape: CustomShape = Circle(), @ViewBuilder label: @escaping (Bool) -> Label) {
        self.buttonSize = buttonSize
        self.alignment = alignment
        self.actions = actions()
        self.shape = shape
        self.label = label
    }
    
    public init(buttonSize: CGFloat = 50, alignment: ArcFloatingButton.Alignment = .bottomTrailing, actions: [FloatingAction], shape: CustomShape = Circle(), @ViewBuilder label: @escaping (Bool) -> Label) {
        self.buttonSize = buttonSize
        self.alignment = alignment
        self.actions = actions
        self.shape = shape
        self.label = label
    }
    
    public var body: some View {
        Button {
            isExpanded.toggle()
        } label: {
            label(isExpanded)
                .frame(width: buttonSize, height: buttonSize)
                .contentShape(.rect)
        }
        .buttonStyle(NoAnimationButtonStyle())
        .background {
            ZStack {
                ForEach(actions) { action in
                    ActionView(action)
                }
            }
            .frame(width: buttonSize, height: buttonSize)
        }
        .animation(.snappy(duration: 0.4, extraBounce: 0), value: isExpanded)
    }
    
    @ViewBuilder
    private func ActionView(_ action: FloatingAction) -> some View {
        Button(action: {
            action.action()
            isExpanded = false
        }, label: {
            action.image
                .font(action.font)
                .foregroundStyle(action.tint)
                .frame(width: buttonSize, height: buttonSize)
                .background(action.background, in: shape)
                .contentShape(shape)
                .rotationEffect(.init(degrees: progress(action) * -getDistributionDegrees() - alignment.rotationDegrees))
        })
        .offset(x: isExpanded ? -offset / 2 : 0)
        .rotationEffect(.init(degrees: progress(action) * getDistributionDegrees() + alignment.rotationDegrees))
        .buttonStyle(PressableButtonStyle())
        .disabled(!isExpanded)
    }
    
    private var offset: CGFloat {
        let buttonSize = buttonSize + 10
        var adjustment: Double = 1
        switch self.alignment {
        case .topLeading, .topTrailing, .bottomLeading, .bottomTrailing:
            adjustment = 1
        case .halfmoonTop, .halfmoonBottom, .halfmoonLeading, .halfmoonTrailing:
            adjustment = 0.5
        case .fullmoon:
            adjustment = 0.5
        }
        
        return Double(actions.count) * (actions.count == 1 ? buttonSize * 2 : (actions.count == 2 ? buttonSize * 1.25 : buttonSize)) * adjustment
    }
    
    private func progress(_ action: FloatingAction) -> CGFloat {
        let index = CGFloat(actions.firstIndex(where: { $0.id == action.id }) ?? 0)
        return actions.count == 1 ? 1 : (index / CGFloat(actions.count - 1))
    }
    
    private func getDistributionDegrees() -> Double {
        switch self.alignment {
        case .fullmoon:
            return Double(actions.count - 1) / Double(actions.count) * 360
        default:
            return alignment.distributionDegrees
        }
    }
    
}
