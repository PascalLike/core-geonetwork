package org.fao.geonet.api.records;

import java.util.Iterator;

import org.fao.geonet.exceptions.SchematronValidationErrorEx;
import org.fao.geonet.exceptions.XSDValidationErrorEx;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;
import org.json.JSONArray;
import org.json.JSONException;
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
            Element report = (Element) e.getObject();
            XMLOutputter outp = new XMLOutputter();
            xmlJSONObj = XML.toJSONObject(outp.outputString(report));
            JSONArray convertedReport = new JSONArray();
            convertReport(xmlJSONObj, convertedReport);
            String errorList = convertedReport.toString();

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

    /**
     *  Recursive function to convert a report schematron report (in JSON format)
     *  in a format compatible with the GN GUI
     */
    private void convertReport(Object object, JSONArray errorList) throws JSONException {

        // Check if current node is a JsonObject or a JsonArray
        // then apply the correct logic
        if(object instanceof JSONObject) {
            JSONObject json = (JSONObject) object;
            for(Iterator<String> keys=json.keys(); keys.hasNext();) {
                String current_key = keys.next();
                if(current_key.equals("svrl:failed-assert") && json.get(current_key)!=null) {
                    if(json.get(current_key) instanceof JSONArray && json.getJSONArray(current_key).length()>0) {
                        JSONArray subReport = json.getJSONArray(current_key);
                        for(int i=0; i< subReport.length(); i++) {
                            JSONObject current = subReport.getJSONObject(i);
                            JSONObject reportElement = new JSONObject();
                            reportElement.put("xpath", current.get("location"));
                            reportElement.put("message", current.get("svrl:text"));
                            errorList.put(reportElement);
                        }
                    } else {
                        JSONObject current = json.getJSONObject(current_key);
                        JSONObject reportElement = new JSONObject();
                        reportElement.put("xpath", current.get("location"));
                        reportElement.put("message", current.get("svrl:text"));
                        errorList.put(reportElement);
                    }
                } else {
                    if(json.get(current_key)!=null) {
                        convertReport(json.get(current_key), errorList);
                    }
                }
            }
        } if(object instanceof JSONArray) {
            JSONArray json = (JSONArray) object;
            for(int i=0; i< json.length(); i++) {
                if(json.get(i)!=null) {
                    convertReport(json.get(i), errorList);
                }
            }
        }
    }


    @Override
    public String getMessage() {

        return this.message.trim();

    }

}

