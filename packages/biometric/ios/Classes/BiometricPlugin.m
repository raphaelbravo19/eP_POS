#import "BiometricPlugin.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <Security/Security.h>

@implementation BiometricPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel *channel =
    [FlutterMethodChannel methodChannelWithName:@"biometric_plugin"
                                binaryMessenger:[registrar messenger]];
    BiometricPlugin *instance = [[BiometricPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"isSensorAvailable" isEqualToString:call.method]) {
        LAContext *context = [[LAContext alloc] init];
        
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL]) {
            NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
             [response setObject:@"success"  forKey:@"status"];
            [response setObject:[self getBiometryType:context] forKey:@"sensorAvailable"];
            result(response);
            
        } else {
             NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
            [response setObject:@"failure"  forKey:@"status"];
            [response setObject:@"Sensor not avialable" forKey:@"reason"];
             result(response);
        }
    } else if ([@"createKeys" isEqualToString:call.method]) {
        [self createKeys:call.arguments[@"title"] result:result];
    }else if ([@"deleteKeys" isEqualToString:call.method]) {
        [self deleteKeys:result];
    }else if ([@"createSignature" isEqualToString:call.method]) {
        [self createSignature:call.arguments[@"title"] payload:call.arguments[@"payload"] result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark Private Methods

-(void) createSignature:(NSString *)promptMessage payload:(NSString *)payload result:(FlutterResult)result{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *biometricKeyTag = [self getBiometricKeyTag];
        NSDictionary *query = @{
                                (id)kSecClass: (id)kSecClassKey,
                                (id)kSecAttrApplicationTag: biometricKeyTag,
                                (id)kSecAttrKeyType: (id)kSecAttrKeyTypeRSA,
                                (id)kSecReturnRef: @YES,
                                (id)kSecUseOperationPrompt: promptMessage
                                };
        SecKeyRef privateKey;
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&privateKey);
        
        if (status == errSecSuccess) {
            NSError *error;
            NSData *dataToSign = [payload dataUsingEncoding:NSUTF8StringEncoding];
            NSData *signature = CFBridgingRelease(SecKeyCreateSignature(privateKey, kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA256, (CFDataRef)dataToSign, (void *)&error));
            
            if (signature != nil) {
                NSString *signatureString = [signature base64EncodedStringWithOptions:0];
                NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
                [response setObject:@"success"  forKey:@"status"];
                [response setObject:signatureString forKey:@"signedSignature"];
                result(response);
            } else {
                NSString *message = [NSString stringWithFormat:@"Signature error: %@", error];
                NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
                [response setObject:@"failure"  forKey:@"status"];
                [response setObject:message forKey:@"reason"];
                result(response);
            }
        }
        else {
            NSString *message = [NSString stringWithFormat:@"Key not found: %@",[self keychainErrorToString:status]];
            NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
            [response setObject:@"failure"  forKey:@"status"];
            [response setObject:message forKey:@"reason"];
            result(response);
        }
    });
}

-(void) deleteKeys:(FlutterResult)result{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL biometricKeyExists = [self biometricKeyExists];
        
        if (biometricKeyExists) {
            OSStatus status = [self deleteBiometricKey];
            
            if (status == noErr) {
                NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
                [response setObject:@"success"  forKey:@"status"];
                [response setObject:@"true" forKey:@"keysDeleted"];
                result(response);
            } else {
                NSString *message = [NSString stringWithFormat:@"Key not found: %@",[self keychainErrorToString:status]];
                NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
                [response setObject:@"failure"  forKey:@"status"];
                [response setObject:message forKey:@"reason"];
                result(response);
            }
        } else {
            NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
            [response setObject:@"failure"  forKey:@"status"];
            [response setObject:@"false" forKey:@"keysDeleted"];
            result(response);
        }
    });
}

-(void) createKeys:(NSString *)promptMessage result:(FlutterResult)result{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (((NSNull *) promptMessage == [NSNull null]) || (promptMessage == nil) || [promptMessage length] == 0) {
            [self createAndStoreKeyPair:result];
        } else {
            LAContext *context = [[LAContext alloc] init];
            context.localizedFallbackTitle = @"";
            
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:promptMessage reply:^(BOOL success, NSError *fingerprintError) {
                if (success) {
                    [self createAndStoreKeyPair:result];
                } else {
                    NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
                    [response setObject:@"failure"  forKey:@"status"];
                    [response setObject:@"Could not confirm fingerprint" forKey:@"reason"];
                    result(response);
                }
            }];
        }
    });
}
- (void) createAndStoreKeyPair:(FlutterResult)result {
    CFErrorRef error = NULL;
    
    SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                                    kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                                    kSecAccessControlTouchIDAny, &error);
    if (sacObject == NULL || error != NULL) {
        NSString *errorString = [NSString stringWithFormat:@"SecItemAdd can't create sacObject: %@", error];
        NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
        [response setObject:@"failure"  forKey:@"status"];
        [response setObject:errorString forKey:@"reason"];
        result(response);
        return;
    }
    
    NSData *biometricKeyTag = [self getBiometricKeyTag];
    NSDictionary *keyAttributes = @{
                                    (id)kSecClass: (id)kSecClassKey,
                                    (id)kSecAttrKeyType: (id)kSecAttrKeyTypeRSA,
                                    (id)kSecAttrKeySizeInBits: @2048,
                                    (id)kSecPrivateKeyAttrs: @{
                                            (id)kSecAttrIsPermanent: @YES,
                                            (id)kSecUseAuthenticationUI: (id)kSecUseAuthenticationUIAllow,
                                            (id)kSecAttrApplicationTag: biometricKeyTag,
                                            (id)kSecAttrAccessControl: (__bridge_transfer id)sacObject
                                            }
                                    };
    
    [self deleteBiometricKey];
    NSError *gen_error = nil;
    id privateKey = CFBridgingRelease(SecKeyCreateRandomKey((__bridge CFDictionaryRef)keyAttributes, (void *)&gen_error));
    
    if(privateKey != nil) {
        id publicKey = CFBridgingRelease(SecKeyCopyPublicKey((SecKeyRef)privateKey));
        CFDataRef publicKeyDataRef = SecKeyCopyExternalRepresentation((SecKeyRef)publicKey, nil);
        NSData *publicKeyData = (__bridge NSData *)publicKeyDataRef;
        NSData *publicKeyDataWithHeader = [self addHeaderPublickey:publicKeyData];
        NSString *publicKeyString = [publicKeyDataWithHeader base64EncodedStringWithOptions:0];
        NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
        [response setObject:@"success"  forKey:@"status"];
        [response setObject:publicKeyString forKey:@"publicKey"];
        result(response);
    } else {
        NSString *message = [NSString stringWithFormat:@"Key generation error: %@", gen_error];
        NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
        [response setObject:@"failure"  forKey:@"status"];
        [response setObject:message forKey:@"reason"];
        result(response);
    }
}

- (NSData *) getBiometricKeyTag {
    NSString *biometricKeyAlias = @"com.biometrics.biometricKey";
    NSData *biometricKeyTag = [biometricKeyAlias dataUsingEncoding:NSUTF8StringEncoding];
    return biometricKeyTag;
}

- (BOOL) biometricKeyExists {
    NSData *biometricKeyTag = [self getBiometricKeyTag];
    NSDictionary *searchQuery = @{
                                  (id)kSecClass: (id)kSecClassKey,
                                  (id)kSecAttrApplicationTag: biometricKeyTag,
                                  (id)kSecAttrKeyType: (id)kSecAttrKeyTypeRSA
                                  };
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, nil);
    return status == errSecSuccess;
}

-(OSStatus) deleteBiometricKey {
    NSData *biometricKeyTag = [self getBiometricKeyTag];
    NSDictionary *deleteQuery = @{
                                  (id)kSecClass: (id)kSecClassKey,
                                  (id)kSecAttrApplicationTag: biometricKeyTag,
                                  (id)kSecAttrKeyType: (id)kSecAttrKeyTypeRSA
                                  };
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)deleteQuery);
    return status;
}

- (NSString *)getBiometryType:(LAContext *)context
{
    if (@available(iOS 11, *)) {
        return (context.biometryType == LABiometryTypeFaceID) ? @"FaceID" : @"TouchID";
    }
    
    return @"TouchID";
}

- (NSString *)keychainErrorToString:(OSStatus)error {
    NSString *message = [NSString stringWithFormat:@"%ld", (long)error];
    
    switch (error) {
        case errSecSuccess:
            message = @"success";
            break;
            
        case errSecDuplicateItem:
            message = @"error item already exists";
            break;
            
        case errSecItemNotFound :
            message = @"error item not found";
            break;
            
        case errSecAuthFailed:
            message = @"error item authentication failed";
            break;
            
        default:
            break;
    }
    
    return message;
}


- (NSData *)addHeaderPublickey:(NSData *)publicKeyData {
    
    unsigned char builder[15];
    NSMutableData * encKey = [[NSMutableData alloc] init];
    unsigned long bitstringEncLength;
    
    static const unsigned char _encodedRSAEncryptionOID[15] = {
        
        /* Sequence of length 0xd made up of OID followed by NULL */
        0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
        0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00
        
    };
    // When we get to the bitstring - how will we encode it?
    if  ([publicKeyData length ] + 1  < 128 )
        bitstringEncLength = 1 ;
    else
        bitstringEncLength = (([publicKeyData length ] +1 ) / 256 ) + 2 ;
    //
    //        // Overall we have a sequence of a certain length
    builder[0] = 0x30;    // ASN.1 encoding representing a SEQUENCE
    //        // Build up overall size made up of -
    //        // size of OID + size of bitstring encoding + size of actual key
    size_t i = sizeof(_encodedRSAEncryptionOID) + 2 + bitstringEncLength + [publicKeyData length];
    size_t j = encodeLength(&builder[1], i);
    [encKey appendBytes:builder length:j +1];
    
    // First part of the sequence is the OID
    [encKey appendBytes:_encodedRSAEncryptionOID
                 length:sizeof(_encodedRSAEncryptionOID)];
    
    // Now add the bitstring
    builder[0] = 0x03;
    j = encodeLength(&builder[1], [publicKeyData length] + 1);
    builder[j+1] = 0x00;
    [encKey appendBytes:builder length:j + 2];
    
    // Now the actual key
    [encKey appendData:publicKeyData];
    
    return encKey;
}

size_t encodeLength(unsigned char * buf, size_t length) {
    
    // encode length in ASN.1 DER format
    if (length < 128) {
        buf[0] = length;
        return 1;
    }
    
    size_t i = (length / 256) + 1;
    buf[0] = i + 0x80;
    for (size_t j = 0 ; j < i; ++j) {
        buf[i - j] = length & 0xFF;
        length = length >> 8;
    }
    
    return i + 1;
}

@end
