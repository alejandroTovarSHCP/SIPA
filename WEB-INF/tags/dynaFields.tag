<%@ tag import="java.util.List" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.Iterator" %>
<%@ tag import="java.util.Collection" %>
<%@ tag import="gob.shcp.fsn.model.support.FieldDTO" %>
<%@ tag import="gob.shcp.fsn.model.support.FieldType" %>
<%@ tag import="gob.shcp.fsn.model.support.DynaFieldContainerDTO" %>
<%@ tag import="gob.shcp.fsn.model.support.FilterDTO"%>
<%@ tag import="gob.shcp.fsn.model.support.SelectListDTO" %>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>
<%@ tag import="gob.shcp.fsn.control.binder.ControllerWebBindingInitializer" %> 
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ attribute name="container" %>
<%@ attribute name="columns" %>
<%@ attribute name="filterId" %>

<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    try{
        DynaFieldContainerDTO containerDTO = (DynaFieldContainerDTO)pageContext.getAttribute(container, PageContext.REQUEST_SCOPE);
        String fieldPath = "";
        String fieldID = "";
       
         if (filterId==null || "".equals(filterId) ){
             filterId = DynaContentService.PAGED_LIST_FILTER;
         }


        if(containerDTO != null && containerDTO.getFields().size() > 0 ){
            int cols = columns==null ? 1 : Integer.parseInt(columns);
            int i = 0;
            for(FieldDTO field : containerDTO.getFields()){
                System.out.println("fields[" + i + "]=" + field);
                fieldPath = "fields[" + i + "]";
                fieldID = "field_" + i;
                String readonly = field.getAttribute("readonly");
                String size = field.getAttribute("size");
                String maxlength = field.getAttribute("maxlength");
%>
                <tr>
                    <td align="right" class="label"><c:out value="<%=field.getLabel()%>" /></td>
                    <td align="left">
                        <html:hidden path='<%=fieldPath + ".type" %>'/>
                        <html:hidden path='<%=fieldPath + ".name" %>'/>
                        <html:hidden path='<%=fieldPath + ".label" %>'/>
                        <html:hidden path='<%=fieldPath + ".attributes" %>'/>
<%
                if(field.getType().equals(FieldType.TEXT)){
                    String disabled = field.getAttribute("disabled");
                    String htmlEscape = field.getAttribute("htmlEscape");
                    String title = field.getAttribute("title");
                    String uppercase = field.getAttribute("uppercase");
                    String onblur = field.getAttribute("onblur");
                    String onkeyup = field.getAttribute("onkeyup");
                    String onkeypress = field.getAttribute("onkeypress");                    
                    
                    boolean upperCased = (uppercase != null && !"".equals(uppercase))?Boolean.valueOf(uppercase):true;
                    String cssClass = upperCased ? "uppercase" : "";
                    disabled = Boolean.valueOf(disabled).toString();
                    maxlength = maxlength==null? "" : maxlength;
                    readonly = Boolean.valueOf(readonly).toString();
                    size = size==null ? "" : size;
                    title = title==null ? "" : title;
                    onblur = onblur==null ? "" : onblur;
                    onkeyup = onkeyup==null ? "" : onkeyup;
                    onkeypress = onkeypress==null ? "" : onkeypress;

                    if(upperCased) {
%>
                        <input type="hidden" name='<%=ControllerWebBindingInitializer.UPPER_CASE_PREFIX%><%=fieldPath + ".value"%>' value="true"/>
<%
                    }                    
%>
                    <c:if test="${empty htmlEscape}">
                        <c:set var="htmlEscape" value="false"/>
                    </c:if>
                    <html:input path='<%=fieldPath + ".value"%>' maxlength="<%=maxlength%>" size="<%=size%>" title="<%=title%>" disabled="<%=disabled%>" readonly="<%=readonly%>" cssClass="<%=cssClass%>" onblur="<%=onblur%>" onkeyup="<%=onkeyup%>" onkeypress="<%=onkeypress%>"/>
<%
                }else if(field.getType().equals(FieldType.CALENDAR)){
                    String dateFormat = field.getAttribute("dateFormat");
                    String javaDateFormat = field.getAttribute("javaDateFormat");
                    if(readonly == null || readonly.equals("")){
                        readonly = "true";
                    }
                    if(size == null || size.equals("")){
                        size = "12";
                    }
                    if(dateFormat == null || dateFormat.equals("")){
                        dateFormat = "%d/%m/%Y";
                    }
                    if(maxlength == null || maxlength.equals("")){
                        maxlength = "10";
                    }
%>                        
                    <html:hidden path='<%=fieldPath + ".value" %>' id='<%=fieldID%>'/>
<%
                    if(javaDateFormat != null && !javaDateFormat.equals("")){
%>
                        <input type="hidden" name="<%=ControllerWebBindingInitializer.DATE_FORMAT_PREFIX%><%=fieldID%>" value="<%=javaDateFormat%>"/>
<%
                    }
                    if(Boolean.valueOf(readonly)){
%>
                        <input type="text" maxlength="<%=maxlength%>"  readonly="readonly" name="text_<%=fieldID%>" id="text_<%=fieldID%>" size="<%=size%>" onblur="changeValue_<%=fieldID%>()"/>
<%
                    } else {
%>
                        <input type="text" maxlength="<%=maxlength%>" name="text_<%=fieldID%>" id="text_<%=fieldID%>" size="<%=size%>" onblur="changeValue_<%=fieldID%>()"/>
<%
                    }
%>              
                    <span class="calendar">
                    <a href="javascript:void(0)" id="button_<%=fieldID%>" onblur="changeValue_<%=fieldID%>()">
                        <img src='<spring:theme code="background.gif"/>' alt="calendar" width="20" height="20"/>
                    </a>
                    </span>
                    <script type="text/javascript">
                        Calendar.setup({
                            inputField     :    "text_<%=fieldID%>",      
                            ifFormat       :    "<%=dateFormat%>",                
                            showsTime      :    false,
                            button         :    "button_<%=fieldID%>",   
                            step           :    1        
                        }); 
                        
                        document.getElementById("text_<%=fieldID%>").value = document.getElementById('<%=fieldID%>').value;        
                        
                        function changeValue_<%=fieldID%>(){
                            document.getElementById('<%=fieldID%>').value = document.getElementById("text_<%=fieldID%>").value;        
                        };
                    </script>
                        
<%
                }else if(field.getType().equals(FieldType.SELECT_LIST)){
                    String beanName = field.getAttribute("beanName");
                    if(beanName == null || "".equals(beanName)) {
                        return;
                    }
                    
                    String parentPath = field.getAttribute("parentPath");
                    String progress = field.getAttribute("progress");
                    String multiple = field.getAttribute("multiple");
                    String patternValue = field.getAttribute("patternValue");
                    String uppercase = field.getAttribute("uppercase");
                    String disabled = field.getAttribute("disabled");                    
                    String onchange = field.getAttribute("onchange");                    
                    String style = field.getAttribute("style");                    
                    String filterPaths = field.getAttribute("filterPaths");                    
                    String appendFilters = field.getAttribute("appendFilters");                    
                    
                    boolean dynaQuery = (appendFilters != null && !"".equals(appendFilters))?Boolean.valueOf(appendFilters):true;
                    boolean upperCased = (uppercase != null && !"".equals(uppercase))?Boolean.valueOf(uppercase):true;                    
                    String cssClass = upperCased ? "uppercase" : "";
                    size = size==null ? "" : size;
                    disabled = disabled==null ? "" : disabled;
                    onchange = onchange==null ? "" : onchange;
                    multiple = multiple==null ? "" : multiple;
                    style = style==null ? "" : style;
                    
                    String[] additionalPaths = null;
                    if(filterPaths != null && !"".equals(filterPaths)) {
                        filterPaths = filterPaths.trim();
                        additionalPaths = filterPaths.split(",");
                    }

                    if(patternValue!=null) {
%>
                        <spring:message code="<%=patternValue%>" var="pattern"/>
<%
                    }
                    String pattern = (String)pageContext.getAttribute("pattern");
                    pattern = pattern == null ? "" : pattern;
                    final FilterDTO filters = (FilterDTO)pageContext.getAttribute(filterId, PageContext.REQUEST_SCOPE);
                    List data = new ArrayList();
                    if((parentPath==null || "".equals(parentPath)) && (beanName != null && !"".equals(beanName))) {
                        if(dynaQuery) {
                            data = TagUtils.getService(pageContext, DynaContentService.class).getListElements(beanName, TagUtils.getConditions(filters), null, null, pattern);
                        } else {
                            data = TagUtils.getService(pageContext, DynaContentService.class).getListElements(beanName, TagUtils.getConditions(filters), null, pattern);
                        }    
                    }

                    StringBuffer options = new StringBuffer();
                    //final HashMap addOptions = (HashMap)pageContext.getAttribute(DynaContentService.ADD_OPTIONS, PageContext.REQUEST_SCOPE);
                    final HashMap addOptions = new HashMap();
                    addOptions.put("0","selectList.nonValue");
                    if(upperCased) {
%>
                        <input type="hidden" name='<%=ControllerWebBindingInitializer.UPPER_CASE_PREFIX%><%=fieldPath + ".value"%>' value="true"/>
<%
                    }
                    
                    String path = fieldPath + ".value";
                    if(parentPath!=null && !parentPath.equals("")){
                        int j = 0;
                        for(FieldDTO ff : containerDTO.getFields()){
                            if(ff.getName().equals(parentPath)){
                                parentPath = "fields[" + j + "].value";                                    
                                break;
                            }
                            j++;
                        }
                    }
%>
                    <html:select path="<%=path%>" size="<%=size%>" multiple="<%=Boolean.valueOf(multiple)%>" cssClass="<%=cssClass%>" disabled="<%=disabled%>" onchange="<%=onchange%>" cssStyle="<%=style%>"  >
<%    
                    if(addOptions!=null && !addOptions.isEmpty()) {
                        String key =  null;
                        String text = null;
                        for(Iterator it = addOptions.keySet().iterator(); it.hasNext();) {
                            key =  (String)it.next();
                            text = (String)addOptions.get(key);
                            options.append(key).append("::").append(text).append(";");
%>
                            <html:option value="<%=key%>"><spring:message code="<%=text%>"/></html:option>
<%
                        }
                    }
%>
                        <html:options items="<%=data%>" itemValue="key" itemLabel="value"/>
                    </html:select>
                    <spring:bind path="<%=path%>">
                        <c:set var="requestValue" value="${status.value}"/>
                    </spring:bind>
<%

                    if((parentPath!=null && !parentPath.equals("")) && (beanName != null && !"".equals(beanName))) {
                        //En la siguiente seccion se manipularan via scripts los objetos.
                        //Por lo que, se eliminan los corchetes pues los IDs no los incluyen.
                        path = path.replaceAll("[\\[\\]]","");
                        parentPath = parentPath.replaceAll("[\\[\\]]","");                    
                    
                        StringBuffer filterStr = new StringBuffer();     
                        Object params[] = new Object[]{};
                        if(filters!=null && filters.get() != null) {
                            for(final Iterator iter = filters.get().iterator(); iter.hasNext();) {
                                params = (Object[]) iter.next();            
                                filterStr.append("filter_value_").append(params[0]).append("=").append(params[2]).append(", ");
                                filterStr.append("filter_condition_").append(params[0]).append("=").append(params[1]).append(", ");                                
                            }
                        }
                        String addPathParams = "";
                        if(additionalPaths != null) {            
                            for(String addPath : additionalPaths) {
                                //Es necesario recorrer la lista de campos dinamicos, que es el unico lugar donde puede haber parents.
                                String parent = "";
                                int j = 0;
                                for(FieldDTO ff : containerDTO.getFields()){
                                    if(ff.getName().equals(addPath.trim())){
                                        parent = "fields" + j + ".value";                                    
                                        break;
                                    }
                                    j++;
                                }
                                addPathParams += "padre={" + parent + "}, ";
                            }
                        }
                        
                        String parameters   = "padre={"+parentPath+"}, " + addPathParams + "beanName="+beanName+", "+filterStr.toString()+", patternValue="+pattern+", options="+options.toString()+", dynaQuery="+dynaQuery ;
                        String preFunction  = "initProgress"+fieldID;
                        String postFunction = "resetProgress"+fieldID;        
                        String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/util/getListElements.do";        
                        if(progress!=null && progress.equals("true")) {
%>
                            <span id="progressMsg<%=fieldID%>" style="filter:alpha(opacity=100);display:none;"><img alt="indicator" src="<spring:theme code="indicator.gif"/>" /></span>
<%
                        }
                        
                        Object values = pageContext.getAttribute("requestValue");
                        StringBuffer arrValue = new StringBuffer(",");
                        if(values instanceof Collection) {
                            arrValue.append(",");
                            for(final Iterator itValues = ((Collection) values).iterator(); itValues.hasNext();) {
                                arrValue.append( itValues.next() ).append(",");            
                            }
                        } else if(values instanceof Object[]) {
                            Object[] arrayValue = (Object[])values;
                            for(int idxValue =0; idxValue < arrayValue.length; idxValue++) {
                                arrValue.append( arrayValue[idxValue] ).append(",");
                            }
                        } else {
                            arrValue.append(values).append(",");
                        }
%>                       
                        <script type="text/javascript">
                            
                            function initProgress<%=fieldID%>() {
                                document.getElementById('<%=path%>').options.length = 0;
                                Element.show('progressMsg<%=fieldID%>');
                            }
                            
                            function resetProgress<%=fieldID%>() {
                                setTimeout("delayResetProgress<%=fieldID%>()", 500);
                            }
                    
                            function delayResetProgress<%=fieldID%>() {
                                //Select previous selected option
                                var options<%=fieldID%> = document.getElementById('<%=path%>').getElementsByTagName('option'); 
                                options<%=fieldID%>[0].selected = true;        
                                for(i=0; i< options<%=fieldID%>.length; i++) {
                                    if("<%=arrValue%>".indexOf(","+options<%=fieldID%>[i].value+",")>-1 ) {
                                        options<%=fieldID%>[0].selected = false;
                                        options<%=fieldID%>[i].selected = true;
                                    }
                                }
                                //Execute onchange event
                                var select<%=fieldID%> = document.getElementById('<%=path%>');
                                if(document.all) { // IE Way
                                    select<%=fieldID%>.fireEvent('onchange');
                                } else  { // Firefox Way
                                    var evt<%=fieldID%> = document.createEvent('HTMLEvents');
                                    evt<%=fieldID%>.initEvent('change', true, true);
                                    select<%=fieldID%>.dispatchEvent(evt<%=fieldID%>);
                                }
<%
                            if(Boolean.valueOf(disabled)) {
%>
                                select<%=fieldID%>.disabled="disabled";
<%
                            }
%>
                                Effect.Fade('progressMsg<%=fieldID%>');
                            }
                            //El tag de ajax elimina el atributo onchange del select padre, por lo tanto se obtiene el valor del atributo antes de definir el tag ajax
                            //y se vuelve a setear al finalizar la definicion del tag de ajax.
                            var parentObj = document.getElementById('<%=parentPath%>');
                            var parentOnchange = parentObj.onchange;
                        </script> 

                        <ajax:select
                          baseUrl="<%=baseUrl%>"
                          source="<%=parentPath%>"
                          target="<%=path%>"
                          parameters="<%=parameters%>"
                          preFunction="<%=preFunction%>"
                          postFunction="<%=postFunction%>"          
                          executeOnLoad="true" />
                          
                        <script type="text/javascript">
                            parentObj.onchange = parentOnchange;
                        </script>
<%
                        if(additionalPaths != null && additionalPaths.length>0) {
%>
                            <c:forEach items="<%=additionalPaths%>" var="adittionalSource">                        
                                <ajax:select
                                  baseUrl="<%=baseUrl%>"
                                  source="${adittionalSource}"
                                  target="<%=path%>"
                                  parameters="<%=parameters%>"
                                  preFunction="<%=preFunction%>"
                                  postFunction="<%=postFunction%>" />
                            </c:forEach>
<%          
                        }
                    }

                    if(path != null && Boolean.valueOf(disabled) && !Boolean.valueOf(multiple)) {
%>
                        <html:hidden path="<%=path%>"/>
<%
                    }
                }
%>
                    </td>
                </tr>
<%
                i++;
            }
        }
    }catch(Exception e){
        e.printStackTrace();
    }finally{
        pageContext.removeAttribute(filterId, PageContext.REQUEST_SCOPE);
        pageContext.removeAttribute(DynaContentService.ADD_OPTIONS, PageContext.REQUEST_SCOPE);
    }
%>