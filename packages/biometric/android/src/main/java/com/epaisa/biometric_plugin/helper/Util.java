package com.epaisa.biometric_plugin.helper;

import java.util.HashMap;
import java.util.Map;

public class Util {
    public static Map<String,String> buildFailureResponse(String failureReason){
        Map<String,String> response=new HashMap<>();
        response.put("status","failure");
        response.put("reason",failureReason);
        return response;
    }
}
