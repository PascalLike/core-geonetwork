package org.fao.geonet.api.records;

import org.fao.geonet.exceptions.SchematronValidationErrorEx;
import org.fao.geonet.exceptions.XSDValidationErrorEx;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;


/**
 * 
 * This exception wraps a JSON report with validation errors
 * Can be extended to support all possible exceptions and xml formats
 * The JSON format is 
 * [{xpath:"element in error", message:"Error description"},...]
 *
 */
public class ValidationErrorsException extends Exception {

    private String message = "";

    public ValidationErrorsException(XSDValidationErrorEx e) {
        JSONObject xmlJSONObj;
        try {
            xmlJSONObj = XML.toJSONObject(e.getMessage());

            String errorList = null;
            if(xmlJSONObj.get("xsderrors")!=null) {
                if (xmlJSONObj.get("xsderrors") instanceof JSONArray) {
                    JSONArray xsderrors = (JSONArray)xmlJSONObj.get("xsderrors");
                    for (int index = 0; index <  xsderrors.length() ; index++) {
                        JSONObject xsdError = xsderrors.getJSONObject(index);
                        if(((JSONObject) xsdError).get("error")  instanceof JSONArray) {
                            errorList += ((JSONArray)((JSONObject) xsdError).get("error")).toString();
                        } else {
                            errorList += ((JSONObject)((JSONObject) xsdError).get("error")).toString();
                        }
                    }
                } else if (xmlJSONObj.get("xsderrors") instanceof JSONObject) {
                    JSONObject xsderrors = (JSONObject)xmlJSONObj.get("xsderrors");
                    if(((JSONObject) xsderrors).get("error")  instanceof JSONArray) {
                        errorList = ((JSONArray) xsderrors.get("error")).toString();
                    } else {
                        errorList = ((JSONObject) xsderrors.get("error")).toString();
                    }
                } else {
                    errorList = "";
                }
            }

            // JSON structure not supported
            if(errorList.equals("")) {
                this.message = xmlJSONObj.toString();
            } else {
                this.message = errorList;
            }

        } catch (Exception e1) {
            this.message = e.getMessage();            
        } 

    }

    public ValidationErrorsException(SchematronValidationErrorEx e) {
        JSONObject xmlJSONObj;
        try {
            xmlJSONObj = XML.toJSONObject(e.getMessage());

            String errorList = null;
            if(xmlJSONObj.get("xsderrors")!=null) {
                if (xmlJSONObj.get("xsderrors") instanceof JSONArray) {
                    JSONArray xsderrors = (JSONArray)xmlJSONObj.get("xsderrors");
                    for (int index = 0; index <  xsderrors.length() ; index++) {
                        JSONObject xsdError = xsderrors.getJSONObject(index);
                        if(((JSONObject) xsdError).get("error")  instanceof JSONArray) {
                            errorList += ((JSONArray)((JSONObject) xsdError).get("error")).toString();
                        } else {
                            errorList += ((JSONObject)((JSONObject) xsdError).get("error")).toString();
                        }
                    }
                } else if (xmlJSONObj.get("xsderrors") instanceof JSONObject) {
                    JSONObject xsderrors = (JSONObject)xmlJSONObj.get("xsderrors");
                    if(((JSONObject) xsderrors).get("error")  instanceof JSONArray) {
                        errorList = ((JSONArray) xsderrors.get("error")).toString();
                    } else {
                        errorList = ((JSONObject) xsderrors.get("error")).toString();
                    }
                } else {
                    errorList = "";
                }
            }

            // JSON structure not supported
            if(errorList.equals("")) {
                this.message = xmlJSONObj.toString();
            } else {
                this.message = errorList;
            }

        } catch (Exception e1) {
            this.message = e.getMessage();            
        } 

    }

    @Override
    public String getMessage() {

        return this.message.trim();

    }

}

