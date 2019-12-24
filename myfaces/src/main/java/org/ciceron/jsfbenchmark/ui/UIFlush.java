
package org.ciceron.jsfbenchmark.ui;

import javax.faces.component.UIComponentBase;
import javax.faces.context.FacesContext;
import javax.faces.context.ResponseWriter;
import java.io.IOException;

public class UIFlush extends UIComponentBase {

    private static final String FAMILY = "org.ciceron.jsfbenchmark";

    @Override
    public String getFamily() {
        return FAMILY;
    }

    @Override
    public boolean getRendersChildren() {
        return true;
    }

    @Override
    public void encodeBegin(final FacesContext context) throws IOException {
        final ResponseWriter rw = context.getResponseWriter();

        StringBuilder sb = (StringBuilder) context.getAttributes().get("scriptQueue");
        if (sb != null) {
            rw.write("<script type='text/javascript'>");
            rw.write(sb.toString());
            rw.write("</script>");
            context.getAttributes().remove("scriptQueue");
        }
    }
}
