//
//  Coordinator.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
@MainActor
class Coordinator: NSObject, ObservableObject {
	// For Tabbar
	@Published var selectedTab: TabbarOption = .home
	
	// For NavigationStack
	@Published var homeNavigationPath = NavigationPath()
	@Published var paymentsNavigationPath = NavigationPath()
	@Published var rewardsNavigationPath = NavigationPath()
	@Published var playNavigationPath = NavigationPath()
	
	// For Popovers
	@Published var popover: CoordinatorNavigatorPath?
}

@available(iOS 16.0, *)
extension Coordinator {
	func open(_ path: CoordinatorNavigatorPath, in tab: TabbarOption? = nil, needToOpenTabIfDifferent: Bool = false) {
		if let tab, needToOpenTabIfDifferent, tab != selectedTab {
			selectedTab = tab
		}
		var value: any Hashable {
			switch path {
			case .payment(let payment): return payment
			case .needToLoad(let option): return option
			case .reward(let reward): return reward
			}
		}
		switch (tab ?? selectedTab) {
		case .home: homeNavigationPath.append(value)
		case .payments: paymentsNavigationPath.append(value)
		case .rewards: rewardsNavigationPath.append(value)
		case .play: playNavigationPath.append(value)
		}
	}
	
	func switchTo(_ tab: TabbarOption) {
		self.selectedTab = tab
	}
	
	func openPopover(_ popover: CoordinatorNavigatorPath) {
		self.popover = popover
	}
	
	func dismissPopover() {
		self.popover = nil
	}
	
	func back(for tab: TabbarOption? = nil, needToOpenTabIfDifferent: Bool = false) {
		if let tab, needToOpenTabIfDifferent, tab != selectedTab {
			selectedTab = tab
		}
		switch (tab ?? selectedTab) {
		case .home: homeNavigationPath.removeSafely()
		case .payments: paymentsNavigationPath.removeSafely()
		case .rewards: rewardsNavigationPath.removeSafely()
		case .play: playNavigationPath.removeSafely()
		}
	}
	
	func back(steps: Int, tab: TabbarOption? = nil, needToOpenTabIfDifferent: Bool = false) {
		if let tab, needToOpenTabIfDifferent, tab != selectedTab {
			selectedTab = tab
		}
		switch (tab ?? selectedTab) {
		case .home:  homeNavigationPath.removeSafely(steps)
		case .payments: paymentsNavigationPath.removeSafely(steps)
		case .rewards: rewardsNavigationPath.removeSafely(steps)
		case .play: playNavigationPath.removeSafely(steps)
		}
	}
	
	func popToRoot(tab: TabbarOption? = nil, needToOpenTabIfDifferent: Bool = false) {
		if let tab, needToOpenTabIfDifferent, tab != selectedTab {
			selectedTab = tab
		}
		switch (tab ?? selectedTab) {
		case .home: homeNavigationPath = NavigationPath()
		case .payments: paymentsNavigationPath = NavigationPath()
		case .rewards: rewardsNavigationPath = NavigationPath()
		case .play: playNavigationPath = NavigationPath()
		}
	}
}


@available(iOS 16.0, *)
extension NavigationPath {
	mutating func removeSafely(_ steps: Int = 1) {
		if self.isEmpty { return }
		if self.count < steps {
			self.removeLast(self.count)
		} else {
			self.removeLast(steps)
		}
	}
}
