//
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct ContentView_V15: View {
	@State var selectedTab: TabbarOption = .home
	@State var popover: CoordinatorNavigatorPath?
	
	var body: some View {
		TabView(selection: $selectedTab) {
			ForEach(TabbarOption.allCases) { tab in
				NavigationView {
					self.makeView(for: tab)
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
			case .home: DashboardView_V15(selectedTab: $selectedTab)
			case .payments: PaymentsView_V15()
			case .rewards: RewardsView_V15()
			case .play: PlayView_V15(selectedTab: $selectedTab, popover: $popover)
			}
		}
	}
}

#Preview {
	ContentView_V15()
}
