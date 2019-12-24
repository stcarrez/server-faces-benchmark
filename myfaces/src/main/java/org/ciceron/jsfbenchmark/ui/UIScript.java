
package org.ciceron.jsfbenchmark.ui;

import org.apache.myfaces.shared.renderkit.RendererUtils;

import javax.faces.component.UIComponentBase;
import javax.faces.context.FacesContext;
import javax.faces.context.ResponseWriter;
import java.io.IOException;

public class UIScript extends UIComponentBase {

    private static final String FAMILY = "org.ciceron.jsfbenchmark";

    private static final String PARAM_TYPE = "type";

    @Override
    public String getFamily() {
        return FAMILY;
    }

    @Override
    public boolean getRendersChildren() {
        return true;
    }

    protected String getType() {
        String type = (String) getAttributes().get(PARAM_TYPE);
        if (type == null) {
            type = "javascript";
        }
        return type;
    }

    @Override
    public void encodeChildren(FacesContext facesContext) throws IOException {
        final ResponseWriter rw = facesContext.getResponseWriter();
        rw.write("<script type='text/javascript'>");
        RendererUtils.renderChildren(facesContext, this);
        rw.write("</script>");
    }

}
