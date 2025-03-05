//
//  RewardCardView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct RewardCardView: View {
	var reward: Reward
	
    var body: some View {
		HStack {
			Text(reward.message)
				.lineLimit(3)
				.font(.subheadline)
				.multilineTextAlignment(.leading)
			Spacer()
		}
    }
}

#Preview {
	RewardCardView(reward: .example)
}
