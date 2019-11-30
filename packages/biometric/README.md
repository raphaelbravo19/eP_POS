# biometric_plugin

Biometrics plugin is a simple bridge to native iOS and Android keystore management.  It allows you to create public private key pairs that are stored in native keystores and protected by biometric authentication.  Those keys can then be retrieved later, after proper authentication, and used to create a cryptographic signature. Biometric plugin works on iOS 10 and Android 6.0 and above

------------


## Getting started

### Installation
Add following code to pubspec.yaml to import this plugin .
```
biometric_plugin:
    git:
      url: https://github.com/eigitallabs/eP-Point-of-Sale-4.0-Flutter.git
      ref: biometric_plugin
```
:warning: `For iOS add NSFaceIDUsageDescription  to plist in your app`

## Methods

### isSensorAvailable()

Detects what type of biometric sensor is available.  Returns a `Map`

__Example__
```dart
var response = await BiometricPlugin.isSensorAvailable();
      if (response['status'] == 'success') {
        var sensor = response['sensorAvailable'];
      } else {
        var failureReason = response['reason'];
      }
```

### createKeys([title])

Prompts the user for their fingerprint or face id, then generates a public private RSA 2048 key pair that will be stored in the device keystore.

__Arguments__

- `title` - optional string that will be displayed in the fingerprint or face id prompt, if no title is provided, no prompt will be displayed.

__Example__
```dart
var response = await BiometricPlugin.createKeys('Confirm fingerprint');
      if (response['status'] == 'success') {
        var key = response['publicKey'];
      } else {
        var failureReason = response['reason'];
      }
```

### deleteKeys()

Deletes the generated keys from the device keystore.

__Example__
```dart
var response = await BiometricPlugin.deleteKeys();
      if (response['status'] == 'success') {
        var keysDeleted = response['keysDeleted'];
		 if (keysDeleted == 'true') {
          //keys deleted
        } else {
          //no key exists
        }
      } else {
        var failureReason = response['reason'];
      }
```

### createSignature(title, payload)

Prompts the user for their fingerprint or face id in order to retrieve the private key from the keystore, then uses the private key to generate a RSA PKCS#1v1.5 SHA 256 signature.

NOTE: No biometric prompt is displayed in iOS simulators when attempting to retrieve keys for signature generation, it only occurs on actual devices.

__Arguments__

- `title` - string that will be displayed in the fingerprint or face id prompt
- `payload` - string of data to be signed by the RSA signature

__Example__
```dart
var response = await BiometricPlugin.createSignature('Sign in', 'data');
      if (response['status'] == 'success') {
       var signature=response['signedSignature'];
      } else {
        var failureReason = response['reason'];
      }
```



