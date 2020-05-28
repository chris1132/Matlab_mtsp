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
import java.util.*;

/**
 * The <code>GaMtsp</code> class provides a Java interface to the M-functions
 * from the files:
 * <pre>
 *  C:\\Users\\dell\\Desktop\\Matlab_mtsp\\mtspofs_ga\\mtspofs_ga.m
 * </pre>
 * The {@link #dispose} method <b>must</b> be called on a <code>GaMtsp</code> instance 
 * when it is no longer needed to ensure that native resources allocated by this class 
 * are properly freed.
 * @version 0.0
 */
public class GaMtsp extends MWComponentInstance<GaMtsp>
{
    /**
     * Tracks all instances of this class to ensure their dispose method is
     * called on shutdown.
     */
    private static final Set<Disposable> sInstances = new HashSet<Disposable>();

    /**
     * Maintains information used in calling the <code>mtspofs_ga</code> M-function.
     */
    private static final MWFunctionSignature sMtspofs_gaSignature =
        new MWFunctionSignature(/* max outputs = */ 1,
                                /* has varargout = */ true,
                                /* function name = */ "mtspofs_ga",
                                /* max inputs = */ 9,
                                /* has varargin = */ false);

    /**
     * Shared initialization implementation - private
     */
    private GaMtsp (final MWMCR mcr) throws MWException
    {
        super(mcr);
        // add this to sInstances
        synchronized(GaMtsp.class) {
            sInstances.add(this);
        }
    }

    /**
     * Constructs a new instance of the <code>GaMtsp</code> class.
     */
    public GaMtsp() throws MWException
    {
        this(Mtspofs_gaMCRFactory.newInstance());
    }
    
    private static MWComponentOptions getPathToComponentOptions(String path)
    {
        MWComponentOptions options = new MWComponentOptions(new MWCtfExtractLocation(path),
                                                            new MWCtfDirectorySource(path));
        return options;
    }
    
    /**
     * @deprecated Please use the constructor {@link #GaMtsp(MWComponentOptions componentOptions)}.
     * The <code>com.mathworks.toolbox.javabuilder.MWComponentOptions</code> class provides API to set the
     * path to the component.
     * @param pathToComponent Path to component directory.
     */
    public GaMtsp(String pathToComponent) throws MWException
    {
        this(Mtspofs_gaMCRFactory.newInstance(getPathToComponentOptions(pathToComponent)));
    }
    
    /**
     * Constructs a new instance of the <code>GaMtsp</code> class. Use this constructor 
     * to specify the options required to instantiate this component.  The options will 
     * be specific to the instance of this component being created.
     * @param componentOptions Options specific to the component.
     */
    public GaMtsp(MWComponentOptions componentOptions) throws MWException
    {
        this(Mtspofs_gaMCRFactory.newInstance(componentOptions));
    }
    
    /** Frees native resources associated with this object */
    public void dispose()
    {
        try {
            super.dispose();
        } finally {
            synchronized(GaMtsp.class) {
                sInstances.remove(this);
            }
        }
    }
  
    /**
     * Invokes the first m-function specified by MCC, with any arguments given on
     * the command line, and prints the result.
     */
    public static void main (String[] args)
    {
        try {
            MWMCR mcr = Mtspofs_gaMCRFactory.newInstance();
            mcr.runMain( sMtspofs_gaSignature, args);
            mcr.dispose();
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }
    
    /**
     * Calls dispose method for each outstanding instance of this class.
     */
    public static void disposeAllInstances()
    {
        synchronized(GaMtsp.class) {
            for (Disposable i : sInstances) i.dispose();
            sInstances.clear();
        }
    }

    /**
     * Provides the interface for calling the <code>mtspofs_ga</code> M-function 
     * where the first input, an instance of List, receives the output of the M-function and
     * the second input, also an instance of List, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %xy = 10*rand(65,2);
     * </pre>
     * </p>
     * @param lhs List in which to return outputs. Number of outputs (nargout) is
     * determined by allocated size of this List. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs List containing inputs. Number of inputs (nargin) is determined
     * by the allocated size of this List. Input arguments may be passed as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or
     * as arrays of any supported Java type. Arguments passed as Java types are
     * converted to MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void mtspofs_ga(List lhs, List rhs) throws MWException
    {
        fMCR.invoke(lhs, rhs, sMtspofs_gaSignature);
    }

    /**
     * Provides the interface for calling the <code>mtspofs_ga</code> M-function 
     * where the first input, an Object array, receives the output of the M-function and
     * the second input, also an Object array, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %xy = 10*rand(65,2);
     * </pre>
     * </p>
     * @param lhs array in which to return outputs. Number of outputs (nargout)
     * is determined by allocated size of this array. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs array containing inputs. Number of inputs (nargin) is
     * determined by the allocated size of this array. Input arguments may be
     * passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void mtspofs_ga(Object[] lhs, Object[] rhs) throws MWException
    {
        fMCR.invoke(Arrays.asList(lhs), Arrays.asList(rhs), sMtspofs_gaSignature);
    }

    /**
     * Provides the standard interface for calling the <code>mtspofs_ga</code>
     * M-function with 9 input arguments.
     * Input arguments may be passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     *
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %xy = 10*rand(65,2);
     * </pre>
     * </p>
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     * @return Array of length nargout containing the function outputs. Outputs
     * are returned as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>. Each output array
     * should be freed by calling its <code>dispose()</code> method.
     * @throws MWException An error has occurred during the function call.
     */
    public Object[] mtspofs_ga(int nargout, Object... rhs) throws MWException
    {
        Object[] lhs = new Object[nargout];
        fMCR.invoke(Arrays.asList(lhs), 
                    MWMCR.getRhsCompat(rhs, sMtspofs_gaSignature), 
                    sMtspofs_gaSignature);
        return lhs;
    }
}
