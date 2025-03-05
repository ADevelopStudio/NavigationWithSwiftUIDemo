//
//  DashboardView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct DashboardView_V16: View {
	@Binding var selectedTab: TabbarOption

    var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 20) {
				DashboardNotificationsView_V16()
				DashboardPaymentsView_V16(selectedTab: $selectedTab)
				DashboardRewardsView_V16(selectedTab: $selectedTab)
			}
			.padding()
		}
		.navigationTitle("Hi, Tom Cruise!")
    }
}

#Preview {
	if #available(iOS 16.0, *) {
		NavigationStack {
			DashboardView_V16(selectedTab: .constant(.home))
				.addNavigationDestinations()
		}
	}
}
