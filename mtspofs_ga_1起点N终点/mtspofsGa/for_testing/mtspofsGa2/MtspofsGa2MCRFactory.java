/*
 * MATLAB Compiler: 6.3 (R2016b)
 * Date: Tue May 26 11:22:58 2020
 * Arguments: "-B" "macro_default" "-W" "java:mtspofsGa2,GaMtsp" "-T" "link:lib" "-d" 
 * "C:\\Users\\dell\\Desktop\\Matlab_mtsp\\mtspofs_ga_1起点N终点\\mtspofsGa\\for_testing" 
 * "class{GaMtsp:C:\\Users\\dell\\Desktop\\Matlab_mtsp\\mtspofs_ga_1起点N终点\\mtspofs_ga.m}" 
 */

package mtspofsGa2;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class MtspofsGa2MCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "mtspofsGa2_FA8FBBFC8AA1298AE90AE6DEE5282E3A";
    
    /** Component name */
    private static final String sComponentName = "mtspofsGa2";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(MtspofsGa2MCRFactory.class)
        );
    
    
    private MtspofsGa2MCRFactory()
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
            MtspofsGa2MCRFactory.class, 
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
