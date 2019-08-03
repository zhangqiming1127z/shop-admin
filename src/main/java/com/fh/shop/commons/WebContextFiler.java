package com.fh.shop.commons;




import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


public class WebContextFiler implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
            WebContext.setThreadLocal((HttpServletRequest) servletRequest);
        try {
            chain.doFilter(servletRequest,servletResponse);
        } finally {
            WebContext.remove();
        }

    }

    @Override
    public void destroy() {

    }
}
