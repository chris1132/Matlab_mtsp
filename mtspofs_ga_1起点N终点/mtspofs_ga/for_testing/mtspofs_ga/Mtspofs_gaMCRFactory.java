/*
 * MATLAB Compiler: 6.3 (R2016b)
 * Date: Tue Apr 21 16:58:14 2020
 * Arguments: "-B" "macro_default" "-W" "java:mtspofs_ga,GaMtsp" "-T" "link:lib" "-d" 
 * "C:\\Users\\dell\\Desktop\\Matlab_mtsp\\mtspofs_ga\\mtspofs_ga\\for_testing" 
 * "class{GaMtsp:C:\\Users\\dell\\Desktop\\Matlab_mtsp\\mtspofs_ga\\mtspofs_ga.m}" 
 */

package mtspofs_ga;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class Mtspofs_gaMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "mtspofs_ga_160FEB6B94F783A205AA13253BA73643";
    
    /** Component name */
    private static final String sComponentName = "mtspofs_ga";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(Mtspofs_gaMCRFactory.class)
        );
    
    
    private Mtspofs_gaMCRFactory()
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
            Mtspofs_gaMCRFactory.class, 
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
