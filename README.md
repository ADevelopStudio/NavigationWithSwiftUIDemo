
# NavigationWithSwiftUIDemo

A demo project written in pure SwiftUI (iOS 15+) showcasing different navigation approaches, including:

-   **NavigationLinks**  (iOS 15+)
-   **NavigationStack**  (iOS 16+)
-   **NavigationStack with Coordinator pattern**  (iOS 16+)

The idea behind this project is to demonstrate various techniques the I employ when building SwiftUI apps, focusing on navigation handling, architectural decisions, testing, and more.

## Table of Contents

-   [Overview](#overview)
-   [Features](#features)
-   [Requirements](#requirements)
-   [Getting Started](#getting-started)
-   [Demonstration of Techniques](#demonstration-of-techniques)
-   [Testing](#testing)
-   [Contributing](#contributing)
-   [License](#license)

----------

## Overview

`NavigationWithSwiftUIDemo`  is designed to show different ways to handle navigation in SwiftUI across multiple iOS versions. It highlights best practices with SwiftUI, MVVM patterns, protocol-oriented programming, and modern concurrency (async/await).

You’ll find three separate “flows”:

1.  **iOS 15**  approach using  `NavigationLink`.
2.  **iOS 16**  approach using  `NavigationStack`.
3.  **iOS 16+**  advanced approach using  `NavigationStack`  with the Coordinator pattern.

By showcasing these flows in one codebase, the repository demonstrates:

-   How to manage navigation under varying deployment targets.
-   How to organie code for clarity, scalability, and testability.

----------

## Features

-   **SwiftUI Navigation**  for both iOS 15 and iOS 16+ (using  `NavigationLink`  vs.  `NavigationStack`).
-   **Coordinator Pattern**  to handle navigation in a centralised manner for more complex flows.
-   **MVVM Architecture**  to keep your view layer clean and separate from business logic.
-   **Repository as an Actor**  leveraging Swift’s concurrency model (`async/await`) for thread-safe data handling.
-   **Custom ViewModifiers**  and SwiftUI extensions to showcase reusability and better code organisation.
-   **Protocol-Oriented Design**  to facilitate easier testing and mocking.
-   **Logging with OSLog**  for effective in-app logging and troubleshooting.
-   **No Third-Party Libraries**  to keep dependencies minimal and showcase pure Swift solutions.
-   **New Swift Testing Framework**  (as opposed to XCTest) to demonstrate modern testing approaches in Swift.

----------

## Requirements

-   **iOS 15.0 or later**
-   **Xcode 14+**  (for Swift Concurrency and Swift 5.5 or later). Preferable **Xcode 16+**
-   A basic understanding of SwiftUI, MVVM, and Swift Concurrency is helpful.

----------

## Getting Started

1.  **Clone the repository**:
    ```
    git clone https://github.com/ADevelopStudio/NavigationWithSwiftUIDemo.git
    ```    
2.  **Open in Xcode**:  
    Double-click  `NavigationWithSwiftUIDemo.xcodeproj`  or open it via Xcode’s “Open” dialog.
3.  **Run the project**:  
    Select the  `NavigationWithSwiftUIDemo`  scheme and choose a simulator (or a real device) with iOS 15+ installed.

----------

## Demonstration of Techniques

1.  **iOS 15 Approach (NavigationLink)**
    
    -   Shows how to handle navigation using  `NavigationLink`  and programmatic navigation.
    -   Useful if your project still has the restriction to support iOS 15.
2.  **iOS 16 Approach (NavigationStack)**
    
    -   Leverages the newer SwiftUI  `NavigationStack`  and  `NavigationPath`.
    -   Demonstrates a more declarative style of navigation introduced in iOS 16.
3.  **Coordinator Pattern**
    
    -   An advanced example that combines  `NavigationStack`  with a Coordinator.
    -   Perfect for handling more complex navigation flows (multi-screen, modal, etc.) while keeping your code organised.

----------

## Testing

The project showcases the usage of the  **new Swift Testing Framework**  to replace or complement traditional XCTest. Tests are organised in the  `Tests`  folder, covering:

-   **Unit Tests**  for ViewModels.
-   **Integration Tests**  for Repository layer with Swift Concurrency.

To run tests, open Xcode and press  **Cmd + U**  or go to  **Product > Test**.

----------

## Contributing

Contributions are welcome! If you see any ways to improve this demo or add more navigation scenarios, feel free to open an issue or submit a pull request.

1.  Fork the repo
2.  Create a new branch (`git checkout -b feature-improvement`)
3.  Commit your changes (`git commit -m 'Add some improvement'`)
4.  Push to the branch (`git push origin feature-improvement`)
5.  Create a new pull request

----------

## License

This project is licensed under the MIT License. See the  LICENSE  file for details.

----------

**Happy Navigating!**  
If this project helps you understand SwiftUI navigation patterns or demonstrates useful techniques, give it a ⭐ on  [GitHub](https://github.com/ADevelopStudio/NavigationWithSwiftUIDemo).
