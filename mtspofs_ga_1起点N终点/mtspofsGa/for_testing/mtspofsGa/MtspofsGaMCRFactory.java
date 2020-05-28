/*
 * MATLAB Compiler: 6.3 (R2016b)
 * Date: Tue May 26 11:27:35 2020
 * Arguments: "-B" "macro_default" "-W" "java:mtspofsGa,GaMtsp" "-T" "link:lib" "-d" 
 * "C:\\Users\\dell\\Desktop\\Matlab_mtsp\\mtspofs_ga_1起点N终点\\mtspofsGa\\for_testing" 
 * "class{GaMtsp:C:\\Users\\dell\\Desktop\\Matlab_mtsp\\mtspofs_ga_1起点N终点\\mtspofs_ga.m}" 
 */

package mtspofsGa;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class MtspofsGaMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "mtspofsGa_36A73BFF5317E2B7FD5D90D85AD86043";
    
    /** Component name */
    private static final String sComponentName = "mtspofsGa";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(MtspofsGaMCRFactory.class)
        );
    
    
    private MtspofsGaMCRFactory()
    {
        // Never called.
    }
    
    public static MWMCR newInstance(MWComponentOptions componentOptions) throws MWException
    {
        if (null == componentOptions.getCtfSource()) {
            componentOptions = new MWComponentOptions(componentOptions);
            componentOptions.setCtfSource(sDefaultComponentOptions.getCtfSource());
        }
        return MWMCR.newInstance(
            componentOptions, 
            MtspofsGaMCRFactory.class, 
            sComponentName, 
            sComponentId,
            new int[]{9,1,0}
        );
    }
    
    public static MWMCR newInstance() throws MWException
    {
        return newInstance(sDefaultComponentOptions);
    }
}
