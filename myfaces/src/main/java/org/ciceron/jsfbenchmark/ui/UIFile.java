
package org.ciceron.jsfbenchmark.ui;

import org.apache.commons.io.IOUtils;

import javax.el.ValueExpression;
import javax.faces.component.UIComponent;
import javax.faces.component.UIComponentBase;
import javax.faces.context.FacesContext;
import javax.faces.context.ResponseWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

public class UIFile extends UIComponentBase {

    private static final String FAMILY = "org.ciceron.jsfbenchmark";

    private String file;
    private Boolean escape = true;

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

    public static Boolean getBooleanValue(final UIComponent component,
                                          final FacesContext context,
                                          final String name) {
        final ValueExpression ve = component.getValueExpression(name);
        final Object value;
        if (ve != null) {
            value = ve.getValue(context.getELContext());
        } else {
            value = component.getAttributes().get(name);
        }
        return (value instanceof Boolean) ? (Boolean) value : false;
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

    public Boolean isEscape() {
        if (escape != null) {
            return escape;
        } else {
            return getBooleanValue(this, getFacesContext(), "escape");
        }
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

        InputStream is = context.getExternalContext().getResourceAsStream(name);
        if (is == null) {
            File f = new File(name);
            if (!f.exists()) {
                rw.startElement("b", this);
                rw.write("File not found: ");
                rw.write(f.getPath());
                rw.endElement("b");
                return;
            }
            is = new FileInputStream(f);
        }

        try {

            final char[] data = IOUtils.toCharArray(is, "UTF-8");

            if (isEscape()) {
                rw.startElement("pre", this);
                rw.writeText(data, 0, data.length);
                rw.endElement("pre");
            } else {
                rw.write(data);
            }

        } catch (IOException ex) {

        } finally {
            try {
                is.close();
            } catch (IOException ex) {

            }
        }
    }

    @Override
    public boolean getRendersChildren() {
        return true;
    }
}
