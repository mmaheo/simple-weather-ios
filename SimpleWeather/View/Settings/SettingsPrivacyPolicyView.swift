//
//  SettingsPrivacyPolicyView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI

struct SettingsPrivacyPolicyView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var settingsStore: SettingsStore
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading) {
                headerSectionView
                collectionAndUseSectionView
                logDataSectionView
                serviceProvidersSectionView
                securitySectionView
                linksToOtherSitesSectionView
                changePrivacyPolicySectionView
                contactUsSectionView
            }
            .padding()
        }
        .navigationTitle("privacy_policy")
    }
    
}

// swiftlint:disable line_length
extension SettingsPrivacyPolicyView {
    
    private var headerSectionView: some View {
        Section {
            Text("Maxime Maheo built the Simple Weather app as a Freemium app. This SERVICE is provided by Maxime Maheo at no cost and is intended for use as is.")
            Text("This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.")
            Text("If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.")
            Text("The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Simple Weather unless otherwise defined in this Privacy Policy.")
        }
    }
    
    private var collectionAndUseSectionView: some View {
        Section {
            Text("Information Collection and Use")
                .font(.title)
                .padding(.top)
            Text("For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.")
            Text("The app does use third party services that may collect information used to identify you.")
            Text("Link to privacy policy of third party service providers used by the app")
        }
    }
    
    private var logDataSectionView: some View {
        Section {
            Text("Log Data")
                .font(.title)
                .padding(.top)
            Text("I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.")
        }
    }
    
    private var serviceProvidersSectionView: some View {
        Section {
            Text("Service Providers")
                .font(.title)
                .padding(.top)
            Text("I may employ third-party companies and individuals due to the following reasons:")
            Text("• To facilitate our Service;")
            Text("• To provide the Service on our behalf;")
            Text("• To perform Service-related services; or")
            Text("• To assist us in analyzing how our Service is used.")
            Text("I want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.")
        }
    }
    
    private var securitySectionView: some View {
        Section {
            Text("Security")
                .font(.title)
                .padding(.top)
            Text("I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.")
        }
    }
    
    private var linksToOtherSitesSectionView: some View {
        Section {
            Text("Links to Other Sites")
                .font(.title)
                .padding(.top)
            Text("This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.")
        }
    }
    
    private var changePrivacyPolicySectionView: some View {
        Section {
            Text("Changes to This Privacy Policy")
                .font(.title)
                .padding(.top)
            Text("I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.")
            Text("This policy is effective as of 2020-11-29")
        }
    }
    
    private var contactUsSectionView: some View {
        Section {
            Text("Contact Us")
                .font(.title)
                .padding(.top)
            Text("If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at imaxame@gmail.com.")
            Text("This privacy policy page was created at privacypolicytemplate.net and modified/generated by")
            URL(string: "https://app-privacy-policy-generator.nisrulz.com/").map {
                Link(destination: $0,
                     label: { Text("• App Privacy Policy Generator") })
            }
        }
    }
    
}
// swiftlint:enable line_length

#if DEBUG

struct SettingsPrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsPrivacyPolicyView()
            
            SettingsPrivacyPolicyView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .environmentObject(settingsStorePreview)
    }
}

#endif
