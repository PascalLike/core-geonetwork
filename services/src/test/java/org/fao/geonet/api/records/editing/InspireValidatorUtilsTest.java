package org.fao.geonet.api.records.editing;

import static org.junit.Assert.assertEquals;

import org.fao.geonet.ApplicationContextHolder;
import org.fao.geonet.utils.GeonetHttpRequestFactory;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import org.springframework.context.ConfigurableApplicationContext;

import javassist.NotFoundException;

public class InspireValidatorUtilsTest {

    private static String URL = "http://inspire-sandbox.jrc.ec.europa.eu/etf-webapp/";

    @Before
    public void setUp() throws Exception {
        ConfigurableApplicationContext applicationContext = Mockito.mock(ConfigurableApplicationContext.class);
        ApplicationContextHolder.set(applicationContext);
        Mockito.when(applicationContext.getBean(GeonetHttpRequestFactory.class)).thenReturn(new GeonetHttpRequestFactory());
    }

    @Test
    public void testGetReportUrl() {

        String reportUrl = InspireValidatorUtils.getReportUrl(URL, "123");

        assertEquals(URL + "/v2/TestRuns/123.html", reportUrl);
    }

    @Test
    public void testGetReportUrlJSON() {

        String reportUrl = InspireValidatorUtils.getReportUrlJSON(URL, "123");

        assertEquals(URL + "/v2/TestRuns/123.json", reportUrl);
    }

    @Test
    public void testLifeCycle() {

        // assertEquals(InspireValidatorUtils.checkServiceStatus("http://wrong.url.eu"), false);

        // FIRST TEST IF OFFICIAL ETF IS AVAILABLE
        // Needed to avoid GN errors when ETF is not available
        if (InspireValidatorUtils.checkServiceStatus(URL)) {

            try {
                // No file
                InspireValidatorUtils.submitFile(URL, null, "GN UNIT TEST ");
            } catch (IllegalArgumentException e) {
                // RIGHT EXCEPTION
            } catch (Exception e) {
                assertEquals("Wrong exception.", "IllegalArgumentException", "Exception");
            }

            try {
                // Valid but not found test ID
                InspireValidatorUtils.isReady(URL, "IED123456789012345678901234567890123");
                assertEquals("No exception!", "NotFoundException", "No Exception");
            } catch (NotFoundException e) {
                // RIGHT EXCEPTION
            } catch (Exception e) {
                assertEquals("Wrong exception.", "NotFoundException", "Exception");
            }

            try {
                // Test ID in wrong format
                assertEquals(InspireValidatorUtils.isPassed(URL, "1"), null);
            } catch (Exception e) {
                assertEquals("Unexpected exception.", "Exception", "No Exception");
            }

        } else {
            assertEquals("The official ETF endpoint is not available. Can't run further tests.", URL, URL);
        }

    }

}
