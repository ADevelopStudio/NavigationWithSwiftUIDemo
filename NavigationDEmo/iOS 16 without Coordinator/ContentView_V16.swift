//
//  ContentView_V3.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct ContentView_V16: View {
	@State var selectedTab: TabbarOption = .home
	@State var popover: CoordinatorNavigatorPath?
	
    var body: some View {
		TabView(selection: $selectedTab) {
			ForEach(TabbarOption.allCases) { tab in
				NavigationStack {
					self.makeView(for: tab)
						.addNavigationDestinations()
				}
				.tabItem {
					Label(tab.name, systemImage: tab.iconName)
				}
				.tag(tab)
			}
		}
		.popoverListener(for: $popover)
    }
	
	private func makeView(for tab: TabbarOption) -> some View {
		VStack {
			switch tab {
			case .home: DashboardView_V16(selectedTab: $selectedTab)
			case .payments: PaymentsView_V16()
			case .rewards: RewardsView_V16()
			case .play: PlayView_V16(selectedTab: $selectedTab, popover: $popover)
			}
		}
	}
}

#Preview {
	if #available(iOS 16.0, *) {
		ContentView_V16()
	}
}
