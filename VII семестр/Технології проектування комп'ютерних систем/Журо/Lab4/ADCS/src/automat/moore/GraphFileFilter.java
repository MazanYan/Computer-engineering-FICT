package automat.moore;

import javax.swing.filechooser.FileFilter;
import java.io.File;

/**
 * Created by IntelliJ IDEA.
 * User: Zak
 * Date: 20.10.2010
 * Time: 2:13:35
 * To change this template use File | Settings | File Templates.
 */
public class GraphFileFilter extends FileFilter {

    public static String GRAPH_EXTENSION = ".graph";

    private static String GRAPH_DESCRIPTION = "Graph File";

    public boolean accept(File pathname) {
        return (pathname.getName().toLowerCase().endsWith(GRAPH_EXTENSION) || pathname.isDirectory());
    }

    public String getDescription() {
        return GRAPH_DESCRIPTION;
    }
    
}
