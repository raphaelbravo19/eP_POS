import { epaisaRequest } from '../../services/epaisa_service';
import { AsyncStorage } from 'react-native';
import navigation from '../../services/navigation';

export async function transactionRequest(request, extra) {
  try {
    const res = await epaisaRequest(request, '/savedtransactions/hold', 'POST');
    if (res.success === 0) {
      throw new Error(res.message);
    }
    if (extra || false) {
      return {
        success: true,
        response: res,
      };
    } else {
      return {
        success: true,
        response: res.response,
      };
    }
  } catch (error) {
    return error;
  }
}
