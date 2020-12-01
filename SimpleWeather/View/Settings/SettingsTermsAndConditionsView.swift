//
//  SettingsTermsAndConditionsView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI

struct SettingsTermsAndConditionsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var settingsStore: SettingsStore
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading) {
                headerSectionView
                thridPartySectionView
                changeTermsAndConditionSectionView
                contactUsSectionView
            }
            .padding()
        }
        .onAppear {
            settingsStore.dispatch(action: .settingsViewDidAppear(type: .termsAndConditions))
        }
        .navigationTitle("terms_and_conditions")
    }
    
}

//swiftlint:disable line_length
extension SettingsTermsAndConditionsView {
    
    private var headerSectionView: some View {
        Section {
            Text("By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages, or make derivative versions. The app itself, and all the trade marks, copyright, database rights and other intellectual property rights related to it, still belong to Maxime Maheo.")
            Text("Maxime Maheo is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.")
            Text("The Simple Weather app stores and processes personal data that you have provided to us, in order to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Simple Weather app won’t work properly or at all.")
            Text("The app does use third party services that declare their own Terms and Conditions.")
        }
    }
    
    private var thridPartySectionView: some View {
        Section {
            Text("Link to Terms and Conditions of third party service providers used by the app")
            URL(string: "https://firebase.google.com/policies/analytics").map {
                Link(destination: $0,
                     label: { Text("• Google Analytics for Firebase") })
            }
            URL(string: "https://firebase.google.com/support/privacy/").map {
                Link(destination: $0,
                     label: { Text("• Firebase Crashlytics") })
            }
            Text("You should be aware that there are certain things that Maxime Maheo will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, or provided by your mobile network provider, but Maxime Maheo cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.")
            Text("If you’re using the app outside of an area with Wi-Fi, you should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.")
            Text("Along the same lines, Maxime Maheo cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Maxime Maheo cannot accept responsibility.")
            Text("With respect to Maxime Maheo’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavour to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Maxime Maheo accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.")
            Text("At some point, we may wish to update the app. The app is currently available on iOS – the requirements for system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Maxime Maheo does not promise that it will always update the app so that it is relevant to you and/or works with the iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.")
        }
    }
    
    private var changeTermsAndConditionSectionView: some View {
        Section {
            Text("Changes to This Terms and Conditions")
                .font(.title)
                .padding(.top)
            Text("I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.")
            Text("These terms and conditions are effective as of 2020-11-29")
        }
    }
    
    private var contactUsSectionView: some View {
        Section {
            Text("Contact Us")
                .font(.title)
                .padding(.top)
            Text("If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at imaxame@gmail.com.")
            Text("This privacy policy page was created at privacypolicytemplate.net and modified/generated by")
            URL(string: "https://app-privacy-policy-generator.nisrulz.com/").map {
                Link(destination: $0,
                     label: { Text("• App Privacy Policy Generator") })
            }
        }
    }
    
}
//swiftlint:enable line_length

#if DEBUG

struct SettingsTermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsTermsAndConditionsView()
            
            SettingsTermsAndConditionsView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .environmentObject(settingsStorePreview)
    }
}

#endif
