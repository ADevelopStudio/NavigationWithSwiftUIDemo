//
//  DashboardView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct DashboardView_V16C: View {
	
    var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 20) {
				DashboardNotificationsView_V16C()
				DashboardPaymentsView_V16C()
				DashboardRewardsView_V16C()
			}
			.padding()
		}
		.navigationTitle("Hi, Tom Cruise!")
    }
}

#Preview {
	if #available(iOS 16.0, *) {
		NavigationView {
			DashboardView_V16C()
		}
	}
}
