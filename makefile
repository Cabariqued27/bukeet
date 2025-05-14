buildAppIcons:
	fvm flutter pub get
	fvm flutter pub run flutter_launcher_icons:main -f flutter_icons.yaml

buildAppSplash:
	fvm flutter pub get
	fvm flutter pub run flutter_native_splash:create --path=flutter_splash.yaml




buildDevAndroid:
	fvm flutter pub get
	fvm flutter pub global run rename setAppName --targets android,ios,web --value "Bukeet"
	fvm flutter pub global run rename setBundleId --targets android --value com.bukeetsas.bukeet
	fvm flutter pub global run rename setBundleId --targets ios --value com.bukeetsas.bukeet
	fvm flutter build apk --debug --dart-define=ENV=DEV --obfuscate --split-debug-info=build/app/outputs/symbols


buildBetaAndroid:
	fvm flutter pub get	
	fvm flutter pub global run rename setAppName --targets android,ios,web --value "Breethly BETA"
	fvm flutter pub global run rename setBundleId --targets android --value com.breethly.breathguide.guide.beta
	fvm flutter pub global run rename setBundleId --targets ios --value com.breethly.app.beta
	cp -R custom_settings/beta/google-services.json android/app/google-services.json
	cp -R custom_settings/beta/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
	fvm flutter build apk --debug --dart-define=ENV=BETA --obfuscate --split-debug-info=build/app/outputs/symbols
