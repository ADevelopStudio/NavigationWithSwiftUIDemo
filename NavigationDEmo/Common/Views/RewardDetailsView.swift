//
//  RewardDetailsView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct RewardDetailsView: View {
	var reward: Reward
	
    var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 20) {
				if #available(iOS 18.0, *) {
					icon
						.symbolEffect(.wiggle, options: .repeat(.continuous).speed(0.75))
				} else
				if #available(iOS 17.0, *) {
					icon
						.symbolEffect(.pulse, isActive: true)
				} else {
					icon
				}
				Text(reward.message)
					.font(.headline)
					.multilineTextAlignment(.leading)
			}
		}
    }
	
	private var icon: some View {
		Image(systemName: TabbarOption.rewards.iconName)
			.resizable()
			.frame(width: 150, height: 150)
			.aspectRatio(contentMode: .fit)
			.foregroundStyle(.red, .blue)
	}
}

#Preview {
	RewardDetailsView(reward: .example)
}
