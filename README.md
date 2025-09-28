# JTFloatingButton

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://mit-license.org)

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Requirements](#requirements)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Author](#author)

## Overview

## Features

## Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS      | 15.0            |
| macOS    | 14.0            |
| tvOS     | 17.0            |
| watchOS  | 10.0            |
| visionOS |  1.0            |

## Installation

### Swift Package Manager

1. Open your project in Xcode.
2. Navigate to `File` > `Swift Packages` > `Add Package Dependency`.
3. Paste the repository URL: `https://github.com/Enryun/JTFloatingButton`
4. Follow the prompts to add the package to your project.

For more details on using Swift Package Manager, visit [Apple's Swift Package Manager documentation](https://swift.org/package-manager/).

## Usage

#### FloatingAction

Represents a customizable floating action button with identifiable properties. Used for `ArcFloatingButton` and `ExpandFloatingButton`.

```swift
FloatingAction(image: Image(systemName: "house.fill"), tint: .blue) {
    print("Heart")
}
```

Parameters:
- `id`: A unique identifier for the button, useful for distinguishing multiple instances.
- `image`: The SwiftUI `Image` to display on the button.
- `font`: The font style for any textual content inside the button.
- `tint`: The color of the button's content, typically the icon or text.
- `background`: The background color of the button.
- `action`: The closure that executes when the button is tapped.

`FloatingAction` configures a button that can be prominently displayed over content, commonly used for actions such as creating new items or triggering specific functions. This struct allows customization of the button's icon, font, colors, and action.

Define actions data using [FloatingAction](#floatingaction):

```swift
private let actions = [
    FloatingAction(image: Image(systemName: "tray.full.fill"), tint: .red, background: .white) {
        print("Tray")
    },
    FloatingAction(image: Image(systemName: "lasso.badge.sparkles"), tint: .red, background: .white) {
        print("Spark")
    },
    FloatingAction(image: Image(systemName: "square.and.arrow.up.fill"), tint: .red, background: .white) {
        print("Share")
    }
]
```

### ArcFloatingButton

A customizable floating action button component that arcs around a main button, revealing multiple action buttons.

```swift
ArcFloatingButton(alignment: .halfmoonTop) {
    
} label: { isExpanded in
    
}
```

Parameters:
- `buttonSize`: The diameter of each action button.
- `alignment`: The alignment dictates the starting point and direction in which the action buttons will arc (e.g., topLeading, fullmoon).
- `spacing`: The spacing between the expanded action buttons.
- `shape`: The shape of each action button, conforming to the `Shape` protocol.
- `actions`: An array of [FloatingAction](#floatingaction) objects defining the actions for the expanded buttons.
- `label`: A view builder that generates the content displayed on the expandable floating button.

`ArcFloatingButton` allows for a radial or semi-circular placement of action buttons that emerge from behind the main button. It supports various alignments and can adapt to custom shapes for each action button.

**Top Leading**:

```swift
ScrollView(.vertical) { ... }
.overlay(alignment: .topLeading) {
    ArcFloatingButton(alignment: .topLeading, actions: actions) { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .scaleEffect(1.02)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
            // Scaling Effect when expanded
            .scaleEffect(isExpanded ? 0.9 : 1)
    }
    .padding()
}
```

https://github.com/user-attachments/assets/c8b47675-14ac-4c84-9354-dfa937919bcc

**Top Trailing**:

```swift
ScrollView(.vertical) { ... }
.overlay(alignment: .topTrailing) {
    ArcFloatingButton(alignment: .topTrailing, actions: actions) { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .scaleEffect(1.02)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
            // Scaling Effect when expanded
            .scaleEffect(isExpanded ? 0.9 : 1)
    }
    .padding()
}
```

https://github.com/user-attachments/assets/43e79578-d942-4d12-a34f-962539e648b8

**Bottom Leading**:

```swift
ScrollView(.vertical) { ... }
.overlay(alignment: .bottomLeading) {
    ArcFloatingButton(alignment: .bottomLeading, actions: actions) { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .scaleEffect(1.02)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
            // Scaling Effect when expanded
            .scaleEffect(isExpanded ? 0.9 : 1)
    }
    .padding()
}
```

https://github.com/user-attachments/assets/d1fbddf2-007d-452a-bd59-c39bc8208beb

**Bottom Trailing**:

```swift
ScrollView(.vertical) { ... }
.overlay(alignment: .bottomTrailing) {
    ArcFloatingButton(alignment: .bottomTrailing, actions: actions) { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .scaleEffect(1.02)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
            // Scaling Effect when expanded
            .scaleEffect(isExpanded ? 0.9 : 1)
    }
    .padding()
}
```

https://github.com/user-attachments/assets/27fe45f8-1bdf-461d-83de-c9abcbc626ca

Alternatively, [FloatingAction](#floatingaction) actions can be listed orderly inside the `action closure`.

**Halfmoon Top**:

```swift
.overlay(alignment: .center) {
    VStack {
        ArcFloatingButton(alignment: .halfmoonTop) {
            FloatingAction(image: Image(systemName: "tray.full.fill"), tint: .teal) {
                print("Tray")
            }
            
            FloatingAction(image: Image(systemName: "lasso.badge.sparkles"), tint: .teal) {
                print("Spark")
            }
            
            FloatingAction(image: Image(systemName: "square.and.arrow.up.fill"), tint: .teal) {
                print("Share")
            }
            
            FloatingAction(image: Image(systemName: "heart.fill"), tint: .teal) {
                print("Heart")
            }
            
            FloatingAction(image: Image(systemName: "house.fill"), tint: .teal) {
                print("Heart")
            }
        } label: { isExpanded in
            Image(systemName: "plus")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
                .scaleEffect(1.02)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black, in: .circle)
            // Scaling Effect when expanded
                .scaleEffect(isExpanded ? 0.9 : 1)
        }
    }
}
```

https://github.com/user-attachments/assets/b1397d03-83a0-4c3f-9b74-f4742c156145

**Halfmoon Bottom**:

```swift
.overlay(alignment: .center) {
    VStack {
        ArcFloatingButton(alignment: .halfmoonBottom) {
            FloatingAction(image: Image(systemName: "tray.full.fill"), tint: .orange) {
                print("Tray")
            }
            
            FloatingAction(image: Image(systemName: "lasso.badge.sparkles"), tint: .orange) {
                print("Spark")
            }
            
            FloatingAction(image: Image(systemName: "square.and.arrow.up.fill"), tint: .orange) {
                print("Share")
            }
            
            FloatingAction(image: Image(systemName: "heart.fill"), tint: .orange) {
                print("Heart")
            }
            
            FloatingAction(image: Image(systemName: "house.fill"), tint: .orange) {
                print("Heart")
            }
        } label: { isExpanded in
            Image(systemName: "plus")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
                .scaleEffect(1.02)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black, in: .circle)
                // Scaling Effect when expanded
                .scaleEffect(isExpanded ? 0.9 : 1)
        }
    }
}
```

https://github.com/user-attachments/assets/89260d78-8e96-47fb-ac52-7dc2ee190ad7

**Halfmoon Leading**:

```swift
.overlay(alignment: .center) {
    ArcFloatingButton(alignment: .halfmoonLeading) {
        FloatingAction(image: Image(systemName: "tray.full.fill"), tint: .yellow) {
            print("Tray")
        }
        
        FloatingAction(image: Image(systemName: "lasso.badge.sparkles"), tint: .yellow) {
            print("Spark")
        }
        
        FloatingAction(image: Image(systemName: "square.and.arrow.up.fill"), tint: .yellow) {
            print("Share")
        }
        
        FloatingAction(image: Image(systemName: "heart.fill"), tint: .yellow) {
            print("Heart")
        }
        
        FloatingAction(image: Image(systemName: "house.fill"), tint: .yellow) {
            print("Heart")
        }
    } label: { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .scaleEffect(1.02)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
            // Scaling Effect when expanded
            .scaleEffect(isExpanded ? 0.9 : 1)
    }
}
```

https://github.com/user-attachments/assets/64c47986-40a3-466b-9b54-079fc67d0e65

**Halfmoon Trailing**:

```swift
.overlay(alignment: .center) {
    ArcFloatingButton(alignment: .halfmoonTrailing) {
        FloatingAction(image: Image(systemName: "tray.full.fill"), tint: .green) {
            print("Tray")
        }
        
        FloatingAction(image: Image(systemName: "lasso.badge.sparkles"), tint: .green) {
            print("Spark")
        }
        
        FloatingAction(image: Image(systemName: "square.and.arrow.up.fill"), tint: .green) {
            print("Share")
        }
        
        FloatingAction(image: Image(systemName: "heart.fill"), tint: .green) {
            print("Heart")
        }
        
        FloatingAction(image: Image(systemName: "house.fill"), tint: .green) {
            print("Heart")
        }
    } label: { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .scaleEffect(1.02)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
            // Scaling Effect when expanded
            .scaleEffect(isExpanded ? 0.9 : 1)
    }
}
```

https://github.com/user-attachments/assets/311239dd-8353-48cb-87b1-5b9fe6f17056

**FullMoon**:

```swift
.overlay(alignment: .center) {
    ArcFloatingButton(alignment: .fullmoon) {
        FloatingAction(image: Image(systemName: "tray.full.fill"), tint: .red) {
            print("Tray")
        }
        
        FloatingAction(image: Image(systemName: "lasso.badge.sparkles"), tint: .orange) {
            print("Spark")
        }
        
        FloatingAction(image: Image(systemName: "square.and.arrow.up.fill"), tint: .yellow) {
            print("Share")
        }
        
        FloatingAction(image: Image(systemName: "heart.fill"), tint: .green) {
            print("Heart")
        }
        
        FloatingAction(image: Image(systemName: "house.fill"), tint: .blue) {
            print("Heart")
        }
        
        FloatingAction(image: Image(systemName: "paperplane"), tint: .cyan) {
            print("Heart")
        }
    } label: { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .scaleEffect(1.02)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
            // Scaling Effect when expanded
            .scaleEffect(isExpanded ? 0.9 : 1)
    }
}
```

https://github.com/user-attachments/assets/a5c087e0-80f0-4b6e-a382-bcb0adf2919d

This component enhances the user interface by seamlessly integrating multiple actions into a single floating action button, providing both aesthetic appeal and functional space-saving benefits.

This component is ideal for interfaces that require quick access to multiple actions without cluttering the UI.

## ExpandFloatButton

A SwiftUI view component that displays a floating action button with expandable action buttons.

```swift
ExpandFloatButton(alignment: .leading) {
    
} label: { isExpanded in
    
}
```

Parameters:
- `buttonSize`: The size of the floating button and each action button.
- `alignment`: The direction in which the action buttons will expand from the main button. (e.g., leading, trailing, top, bottom).
- `spacing`: The space between the expanded action buttons.
- `shape`: The shape of each action button, conforming to the `Shape` protocol.
- `actions`: An array of [FloatingAction](#floatingaction) objects defining the actions for the expanded buttons.
- `label`: A view builder that generates the content displayed on the expandable floating button.

`ExpandFloatButton` offers a dynamic way to present multiple action buttons from a main floating button. It supports expansion in specified directions and can adapt the shape of the action buttons.

Define actions data using [FloatingAction](#floatingaction):

```swift
private let actions: [FloatingAction] = [
    FloatingAction(image: Image(systemName: "tray.full.fill"), tint: .red) {
        print("Tray")
    },
    FloatingAction(image: Image(systemName: "lasso.badge.sparkles"), tint: .orange) {
        print("Spark")
    },
    FloatingAction(image: Image(systemName: "square.and.arrow.up.fill"), tint: .yellow) {
        print("Share")
    },
    FloatingAction(image: Image(systemName: "heart.fill"), tint: .green) {
        print("Heart")
    },
    FloatingAction(image: Image(systemName: "paperplane"), tint: .cyan) {
        print("Plane")
    }
]
```

**Leading**:

```swift
ScrollView(.vertical) { ... }
.overlay(alignment: .bottomLeading) {
    ExpandFloatButton(alignment: .leading, actions: actions, shape: .rect(cornerRadius: 8)) { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .rect(cornerRadius: 8))
    }
    .padding()
}
```

https://github.com/user-attachments/assets/27aac4f9-f219-4732-bf0b-848ae4ebf562

**Trailing**:

```swift
ScrollView(.vertical) { ... }
.overlay(alignment: .bottomTrailing) {
    ExpandFloatButton(alignment: .trailing, actions: actions) { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
    }
    .padding()
}
```

https://github.com/user-attachments/assets/9e723ab3-eeed-4da1-8e2d-6b7f16bb483f

**Top**:

```swift
ScrollView(.vertical) { ... }
.overlay(alignment: .topTrailing) {
    ExpandFloatButton(alignment: .top, actions: actions) { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
    }
    .padding()
}
```

https://github.com/user-attachments/assets/5b53e2e9-5d0a-4f34-b79a-b2e8907dd335

**Bottom**:

```swift
ScrollView(.vertical) { ... }
.overlay(alignment: .bottomTrailing) {
    ExpandFloatButton(alignment: .bottom, actions: actions) { isExpanded in
        Image(systemName: "plus")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
    }
    .padding()
}
```

https://github.com/user-attachments/assets/ddd4a195-e9a6-48e4-aebe-e4b2be86d593

The `ExpandFloatButton` efficiently enhances the user interface by integrating multiple action options into a single floating button. This design not only saves valuable screen space but also adds a sophisticated aesthetic element to the user interface. 

It is particularly beneficial in applications where quick access to multiple functions is necessary without cluttering the screen, offering an intuitive and streamlined user experience.


## Author

James Thang, find me on [LinkedIn](https://www.linkedin.com/in/jamesthang/)

Learn more about SwiftUI, check out my book :books: on [Amazon](https://www.amazon.com/Ultimate-SwiftUI-Handbook-iOS-Developers-ebook/dp/B0CKBVY7V6/ref=tmm_kin_swatch_0?_encoding=UTF8&qid=1696776124&sr=8-1)
