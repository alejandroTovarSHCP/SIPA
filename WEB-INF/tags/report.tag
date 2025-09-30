<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils"%>
<%@ tag import="java.util.Properties"%>
<%@ tag import="java.util.Iterator"%>
<%@ tag import="java.util.HashMap"%>
<%@ tag import="java.util.Map"%>
<%@ tag import="java.util.ArrayList"%>
<%@ tag import="java.util.List"%>
<%@ tag import="org.springframework.util.StringUtils"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="provider" required="true"%>
<%@ attribute name="viewUri" required="true"%>
<%@ attribute name="imagesUri"%>
<%@ attribute name="beanName"%>
<%@ attribute name="service"%>
<%@ attribute name="baseUrl"%>
<%@ attribute name="parentValues"%>
<%@ attribute name="appendFilters"%>
<%@ attribute name="maxRows"%>
<%@ attribute name="format"%>
<%@ attribute name="fileName"%>
<%@ attribute name="export"%>
<%@ attribute name="width"%>
<%@ attribute name="height"%>

<%
try {
    //Se asignan valores default
    if(!StringUtils.hasText(baseUrl)) {
        baseUrl = "/util/displayReport.do";
    }
    if(!baseUrl.startsWith("/")) {
        baseUrl = "/" + baseUrl;
    }
    if(!baseUrl.endsWith(".do")) {
        baseUrl = baseUrl + ".do";
    }

    final String frameId = viewUri.replaceAll("[^a-zA-Z0-9]", "");
    if(!viewUri.startsWith("/")) {
        viewUri = "/" + viewUri;
    }

    imagesUri = imagesUri == null ? "" : imagesUri;
    if(!imagesUri.equals("") && !imagesUri.startsWith("/")) {
        imagesUri = "/" + imagesUri;
    }

    boolean append = true;
    if(StringUtils.hasText(appendFilters)) {
        append = Boolean.valueOf(appendFilters);
    }

    maxRows = maxRows == null ? "-1"   : maxRows;
    format  = format  == null ? "html" : format;
    width   = width   == null ? "500"  : width;
    height  = height  == null ? "200"  : height;

    //Se construye la url del iframe
    final String contextPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+baseUrl+"?";
    final StringBuffer iframeUrl = new StringBuffer(contextPath);
    String exportDS = "";
    if(StringUtils.hasText(beanName)){
        iframeUrl.append("beanName=" + beanName);
        exportDS = "&beanName=" + beanName;
    } 
    if(StringUtils.hasText(service)){
        iframeUrl.append("&service=" + service);
        exportDS = "&service=" + service;
    } 
    if(StringUtils.hasText(imagesUri)) iframeUrl.append("&imagesUri="+imagesUri);
    if(StringUtils.hasText(parentValues)) iframeUrl.append("&parentValues="+parentValues);
    if(StringUtils.hasText(provider)) iframeUrl.append("&provider="+provider);
    if(StringUtils.hasText(viewUri)) iframeUrl.append("&viewUri="+viewUri);
    iframeUrl.append("&appendFilters="+append);      
    iframeUrl.append("&maxRows="+maxRows);
    iframeUrl.append("&format="+format);
    iframeUrl.append("&"+TagUtils.getInputViewParamName()+"="+provider+":"+viewUri); //View tracking

    if(StringUtils.hasText(fileName)) {
        fileName = "&fileName=" + fileName;        
    } else {
        fileName = "";
    }

    //Se verifican los formatos para exportar
    final Map<String, String> supportedFormats = new HashMap<String, String>();  
    supportedFormats.put("pdf", "pdf");
    supportedFormats.put("csv", "csv");
    supportedFormats.put("xls", "xls");
    supportedFormats.put("xlsx", "xlsx");
    supportedFormats.put("rtf", "rtf");
    supportedFormats.put("xml", "xml");
    supportedFormats.put("docx", "docx");
    supportedFormats.put("pptx", "pptx");
    supportedFormats.put("txt", "txt");

    final List<String> formats = new ArrayList<String>();
    if(StringUtils.hasText(export)) {
        iframeUrl.append("&export="+export);
        final String[] exportFormats = export.split(",");
        for(int i = 0; i < exportFormats.length; i++) {
            if(supportedFormats.get(exportFormats[i].toLowerCase()) != null) {
                formats.add(supportedFormats.get(exportFormats[i].toLowerCase()));
            }
        }
        request.setAttribute("formats", formats);
    }

    //Se concatenan los parametros del reporte
    final StringBuffer exportParams = new StringBuffer();
    if(pageContext.getAttribute(TagUtils.REPORT_PARAMS, PageContext.REQUEST_SCOPE) != null){
        final Properties parameters = (Properties)pageContext.getAttribute(TagUtils.REPORT_PARAMS, PageContext.REQUEST_SCOPE);
        for (Iterator it = parameters.entrySet().iterator(); it.hasNext();) {
            Map.Entry entry = (Map.Entry) it.next();
            iframeUrl.append("&"+(String) entry.getKey()+"="+(String) entry.getValue());
            exportParams.append("&"+(String) entry.getKey()+"="+(String) entry.getValue());
        }
    }         
%>
    <table>
        <tr>
            <td>
                <iframe id="reportIFrame<%=frameId%>" src="<%=iframeUrl.toString()%>" frameborder="0" scrolling="auto" style="width:<%=width%>px; height:<%=height%>px; overflow:auto; padding:5px;"></iframe>
            </td>
        </tr>
        <tr>
            <td>
                <div class="exportlinks">Export:
                    <c:forEach items="${formats}" var="format">
                        <c:if test="${fileName!=null && fileName!=''}">                            
                            <a href="<%=contextPath%>provider=<%=provider%>&viewUri=<%=viewUri%>&imagesUri=<%=imagesUri%>&format=<c:out value='${format}'/><%=exportParams%><%=exportDS%><%=fileName%>">
                                <span class="export <c:out value='${format}'/>"><c:out value='${format}'/></span>
                            </a>
                        </c:if>
                        <c:if test="${fileName==null || fileName==''}">                        
                            <a href="#" onclick="javascript:reloadIFrame<%=frameId%>('<%=contextPath%>provider=<%=provider%>&viewUri=<%=viewUri%>&imagesUri=<%=imagesUri%>&format=<c:out value='${format}'/><%=exportParams%><%=exportDS%>');">
                                <span class="export <c:out value='${format}'/>"><c:out value='${format}'/></span>
                            </a>                            
                        </c:if>
                    </c:forEach>    
                </div>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function reloadIFrame<%=frameId%>(url) {
            document.getElementById("reportIFrame<%=frameId%>").src = url;
        }
    </script>
<%    
} catch(Exception e) {
    e.printStackTrace();
}
%>
