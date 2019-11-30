import ep_errors from '../../api/errors';
import { AsyncStorage } from 'react-native';
import navigation from '../../services/navigation';
import realm from '../../services/realm_service';

export function handleError(message, callback) {
  switch (message) {
    case ep_errors.constants.INVALID_AUTH_KEY:
      return {
        message: ep_errors.messages.INVALID_AUTH_KEY,
        action: logOut,
      };
    case ep_errors.constants.AMOUNT_BELOW_LIMITS:
      return {
        message: ep_errors.messages.AMOUNT_BELOW_LIMITS,
        action: () => null,
      };
    case 'Either Invalid OTP (Expiry or OTP mismatch) or OTP mismatched due to mismatch in order id or transaction amount':
      return {
        message: 'Invalid OTP, verify your OTP code and try again!',
        action: () => {
          if (callback) {
            callback();
          }
        },
      };
    case 'Payment refund completed!':
      return {
        message: 'Payment refund completed!',
        action: callback,
      };
    case 'Network request failed':
      return {
        message: 'Please connect to internet',
        action: () => null,
      };
    default:
      // alert(message)
      return {
        message,
        action: () => null,
      };
  }
}
async function logOut() {
  const user = realm.objectForPrimaryKey('User', 0);
  user.signOut();
  await AsyncStorage.removeItem('user');
  return navigation.navigate('Auth');
}
