
package org.ciceron.jsfbenchmark.ui;

import javax.el.ValueExpression;
import javax.faces.component.UIComponent;
import javax.faces.component.UIComponentBase;
import javax.faces.context.FacesContext;
import javax.faces.context.ResponseWriter;
import java.io.IOException;

public class UIInclude extends UIComponentBase {

    private static final String FAMILY = "org.ciceron.jsfbenchmark";

    private String file;

    public static String getStringValue(final UIComponent component,
                                    final FacesContext context,
                                    final String name) {
        final ValueExpression ve = component.getValueExpression(name);
        final Object value;
        if (ve != null) {
            value = ve.getValue(context.getELContext());
        } else {
            value = component.getAttributes().get(name);
        }

        return String.valueOf(value);
    }

    public String getFile() {
        if (file != null) {
            return file;
        } else {
            return getStringValue(this, getFacesContext(), "src");
        }
    }

    public void setFile(String file) {
        this.file = file;
    }

    @Override
    public String getFamily() {
        return FAMILY;
    }

    @Override
    public void encodeBegin(final FacesContext context) throws IOException {
        final ResponseWriter rw = context.getResponseWriter();
        final String name = getFile();
        if (name == null || name.length() == 0) {
            return;
        }

        StringBuilder sb = (StringBuilder) context.getAttributes().get("scriptQueue");
        if (sb == null) {
            sb = new StringBuilder();
            context.getAttributes().put("scriptQueue", sb);
        }
        String id = this.getClientId();
        rw.startElement("div", this);
        rw.writeAttribute("id", id, "");
        sb.append("ASF.Update(null, '");
        sb.append(context.getApplication().getViewHandler().getActionURL(context, name));
        sb.append("', '#" + id);
        sb.append("');");
        rw.endElement("div");
    }

    @Override
    public boolean getRendersChildren() {
        return true;
    }
}
