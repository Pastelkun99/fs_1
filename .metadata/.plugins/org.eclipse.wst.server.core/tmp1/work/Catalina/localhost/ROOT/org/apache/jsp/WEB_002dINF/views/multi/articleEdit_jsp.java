/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.27
 * Generated at: 2019-12-17 05:30:40 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.multi;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class articleEdit_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(4);
    _jspx_dependants.put("jar:file:/C:/Users/admin/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/Fusion_1/WEB-INF/lib/spring-webmvc-4.2.4.RELEASE.jar!/META-INF/spring-form.tld", Long.valueOf(1450280850000L));
    _jspx_dependants.put("jar:file:/C:/Users/admin/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/Fusion_1/WEB-INF/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1573435374027L));
    _jspx_dependants.put("/WEB-INF/lib/spring-webmvc-4.2.4.RELEASE.jar", Long.valueOf(1573435477950L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<link rel=\"stylesheet\"\n");
      out.write("\thref=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\"\n");
      out.write("\tintegrity=\"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\"\n");
      out.write("\tcrossorigin=\"anonymous\">\n");
      out.write("<script\n");
      out.write("\tsrc=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js\"\n");
      out.write("\tintegrity=\"sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM\"\n");
      out.write("\tcrossorigin=\"anonymous\"></script>\n");
      out.write("\n");
      out.write("<!-- include libraries(jQuery, bootstrap) -->\n");
      out.write("<link href=\"http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css\" rel=\"stylesheet\">\n");
      out.write("<script src=\"http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js\"></script> \n");
      out.write("<script src=\"http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js\"></script> \n");
      out.write("\n");
      out.write("<!-- include summernote css/js -->\n");
      out.write("<link href=\"http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css\" rel=\"stylesheet\">\n");
      out.write("<script src=\"http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js\"></script>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<title>WebBoard - 게시글 수정하기</title>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\t</br>\n");
      out.write("\t</br>\n");
      out.write("\t<div class=\"row\">\n");
      out.write("\t\t<div class=\"col-xs-2 col-md-2\"></div>\n");
      out.write("\t\t<div class=\"col-xs-8 col-md-8\">\n");
      out.write("\t\t\t<h2 class=\"text-center\">게시글 수정</h2>\n");
      out.write("\t\t\t<p>&nbsp;</p>\n");
      out.write("\t\t\t<div class=\"table table-responsive\">\n");
      out.write("\t\t\t<form action=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/multi/articleEdit.do\" id=\"articleUpdate\" method=\"post\">\n");
      out.write("\t\t\t\t<table class=\"table\">\n");
      out.write("\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t<th class=\"table-success\">글번호</th>\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.article_no }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</td>\n");
      out.write("\t\t\t\t\t\t\t<th class=\"table-success\">조회수</th>\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.article_hit }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</td>\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t<th class=\"table-success\">작성자</th>\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.article_writer }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</td>\n");
      out.write("\t\t\t\t\t\t\t<th class=\"table-success\">작성일</th>\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.article_date }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</td>\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t<th class=\"table-success\">제목</th>\n");
      out.write("\t\t\t\t\t\t\t<td colspan=\"3\"><input type=\"text\" name=\"article_title\" id=\"article_title\" class=\"form-control\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.article_title }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("\"/></td>\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t<th class=\"table-success\">글 내용</th>\n");
      out.write("\t\t\t\t\t\t\t<td colspan=\"3\"><textarea class=\"summernote\" name=\"article_content\" id=\"article_content\" rows=\"10\" height=\"500px\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.article_content }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</textarea></td>\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t</table>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"article_no\" id=\"article_no\" value=");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.article_no }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write(">\n");
      out.write("\t\t\t\t<button type=\"button\" class=\"btn btn-primary\" onclick=\"articleUpdate();\">수정 완료</button>\n");
      out.write("\t\t\t\t<button type=\"button\" class=\"btn btn-danger\" onclick=\"history.back();\">돌아가기</button>\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"article_userid\" id=\"article_userid\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.article_userid }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("\"/>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</div>\n");
      out.write("\t\t</form>\n");
      out.write("\t\t<script type=\"text/javascript\">\n");
      out.write("\t\t\tfunction articleUpdate() {\n");
      out.write("\t\t\t\tvar article_no = document.getElementById('article_no').value;\n");
      out.write("\t\t\t\tvar article_title = document.getElementById('article_title').value;\n");
      out.write("\t\t\t\tvar article_content = document.getElementById('article_content').value;\n");
      out.write("\t\t\t\tvar article_userid = document.getElementById('article_userid').value;\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t$.ajax({\n");
      out.write("\t\t\t\t\t    type : \"POST\",\n");
      out.write("\t\t\t\t        url : \"/multi/articleEdit.do\",\n");
      out.write("\t\t\t\t        data : {\"article_no\" : article_no,\n");
      out.write("\t\t\t\t\t\t\t\t\"article_title\" : article_title,\n");
      out.write("\t\t\t\t\t\t\t\t\"article_content\" : article_content,\n");
      out.write("\t\t\t\t\t\t\t\t\"article_userid\" : article_userid\n");
      out.write("\t\t\t\t        \t\t},\n");
      out.write("\t\t\t\t        dataType : \"json\",\n");
      out.write("\t\t\t\t        success: function(result){\n");
      out.write("\t\t\t\t        \talert('수정이 완료되었습니다.');\n");
      out.write("\t\t\t\t        \topener.location.reload();\n");
      out.write("\t\t\t\t        \tself.close();\n");
      out.write("\t\t\t\t        },\n");
      out.write("\t\t\t\t        error: function(error) {\n");
      out.write("\t\t\t\t        \talert('수정에 실패했습니다.');\n");
      out.write("\t\t\t\t            alert(error);\n");
      out.write("\t\t\t\t            self.close();\n");
      out.write("\t\t\t\t        }  \n");
      out.write("\t\t\t\t});\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t$(document).ready(function() {\n");
      out.write("\t\t\t\t$('#article_content').summernote({\n");
      out.write("\t\t\t\t\theight:400\n");
      out.write("\t\t\t\t});\n");
      out.write("\t\t\t});\n");
      out.write("\t\t</script>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
