/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.27
 * Generated at: 2019-11-29 00:46:20 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class infoAppend_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<link rel=\"stylesheet\"\r\n");
      out.write("\thref=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\"\r\n");
      out.write("\tintegrity=\"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\"\r\n");
      out.write("\tcrossorigin=\"anonymous\">\r\n");
      out.write("<script\r\n");
      out.write("\tsrc=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js\"\r\n");
      out.write("\tintegrity=\"sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM\"\r\n");
      out.write("\tcrossorigin=\"anonymous\"></script>\r\n");
      out.write("<script src=\"https://code.jquery.com/jquery-3.4.1.min.js\"></script>\r\n");
      out.write("<script src=\"https://code.jquery.com/ui/1.12.1/jquery-ui.js\"></script>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<link rel=\"shortcut icon\" href=\"data:image/x-icon;,\" type=\"image/x-icon\">\r\n");
      out.write("<title>설문 등록</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t<div class=\"card\" style=\"width: 100%;\">\r\n");
      out.write("\t\t<div class=\"card-header\"><strong>설문 등록</strong></div>\r\n");
      out.write("\t\t<input type=\"hidden\" id=\"a_no\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${count + 1}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("\">\r\n");
      out.write("\t\t<ul class=\"list-group list-group-flush\">\r\n");
      out.write("\t\t\t<li class=\"list-group-item\">\r\n");
      out.write("\t\t\t\t설문 이름 : <input type=\"text\" class=\"form-control\" name=\"a_name\" id=\"a_name\">\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li class=\"list-group-item\">\r\n");
      out.write("\t\t\t\t주최자 : <input type=\"text\" class=\"form-control\" name=\"a_collector\" id=\"a_collector\">\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li class=\"list-group-item\">\r\n");
      out.write("\t\t\t\t대상자 : <input type=\"text\" class=\"form-control\" name=\"a_submitter\" id=\"a_submitter\">\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li class=\"list-group-item\">\r\n");
      out.write("\t\t\t\t시작 날짜 : <input class=\"form-control\" id=\"a_fromdate\" name=\"a_fromdate\" placeholder=\"날짜를 선택하세요!\" readonly=\"readonly\">\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li class=\"list-group-item\">\r\n");
      out.write("\t\t\t\t마감 날짜 : <input class=\"form-control\" id=\"a_todate\" name=\"a_todate\" placeholder=\"날짜를 선택하세요!\" readonly=\"readonly\">\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li class=\"list-group-item\">\r\n");
      out.write("\t\t\t\t당첨일 발표 : <input class=\"form-control\" id=\"a_deploydate\" name=\"a_deploydate\" placeholder=\"날짜를 선택하세요!\" readonly=\"readonly\">\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li class=\"list-group-item\" style=\"text-align: right;\">\r\n");
      out.write("\t\t\t\t활성화 여부 : \r\n");
      out.write("\t\t\t\t<select name=\"a_aval\" id=\"a_aval\">\r\n");
      out.write("\t\t\t\t\t<option value=\"1\">활성화</option>\r\n");
      out.write("\t\t\t\t\t<option value=\"0\">비활성화</option> \r\n");
      out.write("\t\t\t\t</select>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li class=\"list-group-item\">\r\n");
      out.write("\t\t\t\t<button type=\"button\" class=\"btn btn-danger\" style=\"width:150px;\" onClick=\"closeWindow();\">취소</button>\r\n");
      out.write("\t\t\t\t<button type=\"button\" class=\"btn btn-primary\" style=\"width:150px;\" onClick=\"infoAppend();\">등록</button>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t</ul>\r\n");
      out.write("\t</div>\r\n");
      out.write("</body>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("$('#a_fromdate').datepicker({\r\n");
      out.write("\tdateFormat: 'yy-mm-dd',\r\n");
      out.write("\tchangeYear: true,\r\n");
      out.write("\tchangeMonth: true,\r\n");
      out.write("\tmonthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("$('#a_todate').datepicker({\r\n");
      out.write("\tdateFormat: 'yy-mm-dd',\r\n");
      out.write("\tchangeYear: true,\r\n");
      out.write("\tchangeMonth: true,\r\n");
      out.write("\tmonthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("$('#a_deploydate').datepicker({\r\n");
      out.write("\tdateFormat: 'yy-mm-dd',\r\n");
      out.write("\tchangeYear: true,\r\n");
      out.write("\tchangeMonth: true,\r\n");
      out.write("\tmonthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("\tfunction closeWindow() {\r\n");
      out.write("\t\tself.close();\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction infoAppend() {\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar falseCount = 0;\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$('.form-control').each(function() {\r\n");
      out.write("\t\t\tif($(this).val().length == 0) {\r\n");
      out.write("\t\t\t\tfalseCount = 1;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t})\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif(falseCount == 1) {\r\n");
      out.write("\t\t\talert('입력되지 않은 항목이 하나 이상 존재합니다.');\r\n");
      out.write("\t\t\treturn false;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar a_no = $('#a_no').val();\r\n");
      out.write("\t\tvar a_name = $('#a_name').val();\r\n");
      out.write("\t\tvar a_collector = $('#a_collector').val();\r\n");
      out.write("\t\tvar a_submitter = $('#a_submitter').val();\r\n");
      out.write("\t\tvar a_fromdate = $('#a_fromdate').val();\r\n");
      out.write("\t\tvar a_todate = $('#a_todate').val();\r\n");
      out.write("\t\tvar a_deploydate = $('#a_deploydate').val();\r\n");
      out.write("\t\tvar a_aval = $('#a_aval').val();\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$.ajax({\r\n");
      out.write("\t\t\ttype : \"post\",\r\n");
      out.write("\t\t\turl : \"/mng/infoAppend.do\",\r\n");
      out.write("\t\t\tdata : {\"a_no\" : a_no,\r\n");
      out.write("\t\t\t\t\t\"a_name\" : a_name,\r\n");
      out.write("\t\t\t\t\t\"a_collector\" : a_collector,\r\n");
      out.write("\t\t\t\t\t\"a_submitter\" : a_submitter,\r\n");
      out.write("\t\t\t\t\t\"a_fromdate\" : a_fromdate,\r\n");
      out.write("\t\t\t\t\t\"a_todate\" : a_todate,\r\n");
      out.write("\t\t\t\t\t\"a_deploydate\" : a_deploydate,\r\n");
      out.write("\t\t\t\t\t\"a_aval\" : a_aval},\r\n");
      out.write("\t\t\tdataType : \"json\",\r\n");
      out.write("\t\t\tsuccess : function(result) {\r\n");
      out.write("\t\t\t\talert('등록 성공');\r\n");
      out.write("\t\t\t\topener.location.reload();\r\n");
      out.write("\t\t\t\tself.close();\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\terror : function(error) {\r\n");
      out.write("\t\t\t\talert('등록 실패');\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("</html>\r\n");
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
