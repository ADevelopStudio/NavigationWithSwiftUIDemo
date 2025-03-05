//
//  ContentViewWithCoordinator.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct ContentView_V16C: View {
	@StateObject fileprivate var coordinator = Coordinator()

    var body: some View {
		TabView(selection: $coordinator.selectedTab) {
			
			// MARK: Dashboard
			NavigationStack(path: $coordinator.homeNavigationPath) {
				DashboardView_V16C()
					.addNavigationDestinations()
			}
			.tabItem {
				Label(TabbarOption.home.name, systemImage: TabbarOption.home.iconName)
			}
			.tag(TabbarOption.home)
			
			// MARK: Payments
			NavigationStack(path: $coordinator.paymentsNavigationPath) {
				PaymentsView_V16C()
					.addNavigationDestinations()
			}
			.tabItem {
				Label(TabbarOption.payments.name, systemImage: TabbarOption.payments.iconName)
			}
			.tag(TabbarOption.payments)
			
			// MARK: Rewards
			NavigationStack(path: $coordinator.rewardsNavigationPath) {
				RewardsView_V16C()
					.addNavigationDestinations()
			}
			.tabItem {
				Label(TabbarOption.rewards.name, systemImage: TabbarOption.rewards.iconName)
			}
			.tag(TabbarOption.rewards)
			
			// MARK: Settings
			NavigationStack(path: $coordinator.playNavigationPath) {
				PlayView_V16C()
					.addNavigationDestinations()
			}
			.tabItem {
				Label(TabbarOption.play.name, systemImage: TabbarOption.play.iconName)
			}
			.tag(TabbarOption.play)
		}
		.animation(.easeInOut, value: coordinator.selectedTab)
		.environmentObject(coordinator)
		.popoverListener(for: $coordinator.popover)
    }
}

#Preview {
	if #available(iOS 16.0, *) {
		ContentView_V16C()
	}
}
