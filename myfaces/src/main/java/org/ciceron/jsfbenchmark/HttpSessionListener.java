package org.ciceron.jsfbenchmark;

import javax.servlet.ServletContextListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContext;

public class HttpSessionListener implements ServletContextListener {

    @Override
    public void contextInitialized(final ServletContextEvent event) {
        ServletContext ctx = event.getServletContext();

        ctx.setAttribute("contextPath", ctx.getContextPath());
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }
}
