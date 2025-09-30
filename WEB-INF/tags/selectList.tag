<%@ tag import="java.util.List" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.Iterator" %>
<%@ tag import="java.util.Collection" %>
<%@ tag import="gob.shcp.fsn.model.support.FilterDTO"%>
<%@ tag import="gob.shcp.fsn.model.support.SelectListDTO" %>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>
<%@ tag import="gob.shcp.fsn.service.support.SelectListService" %>
<%@ tag import="gob.shcp.fsn.control.binder.ControllerWebBindingInitializer" %> 
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>
<%@ tag import="org.springframework.util.ClassUtils" %>

<%@ attribute name="beanName"%>
<%@ attribute name="service"%>
<%@ attribute name="items" type="java.util.List"%>
<%@ attribute name="name"%>
<%@ attribute name="path"%>
<%@ attribute name="parentPath"%>
<%@ attribute name="progress"%>
<%@ attribute name="multiple"%>
<%@ attribute name="size"%>
<%@ attribute name="filterPaths"%>
<%@ attribute name="patternValue"%>
<%@ attribute name="uppercase"%>
<%@ attribute name="disabled"%>
<%@ attribute name="preFunction"%>
<%@ attribute name="onchange"%>
<%@ attribute name="appendFilters"%>
<%@ attribute name="style"%>
<%@ attribute name="width"%>
<%@ attribute name="filterId"%>
<%@ attribute name="onload"%>
<%@ attribute name="wrapText"%>
<%@ attribute name="height"%>
<%@ attribute name="cascadeDelay"%>

<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
try {
    if((beanName == null || "".equals(beanName)) && (items == null) && (service == null || "".equals(service))) {
        return;
    }
    if(filterId==null || "".equals(filterId)) {
            filterId = DynaContentService.PAGED_LIST_FILTER;
    }

    boolean dynaQuery = true;
    if(appendFilters != null && !"".equals(appendFilters)) {
        dynaQuery = Boolean.valueOf(appendFilters);
    }

    String[] additionalPaths = null;
    if(filterPaths != null && !"".equals(filterPaths)) {
        filterPaths = filterPaths.trim();
        additionalPaths = filterPaths.split(",");
    }

    boolean upperCased = true;
    if(uppercase != null && !"".equals(uppercase)) {
        upperCased = Boolean.valueOf(uppercase);
    }
    String cssClass = upperCased ? "uppercase" : "";
    size = size==null ? "" : size;
    disabled = disabled==null ? "" : disabled;
    onchange = onchange==null ? "" : onchange;
    String pagePreFunction = preFunction ==null ? "" : preFunction;
    multiple = multiple==null ? "" : multiple;
    style = style==null ? "" : style;
    height = height==null ? "200" : height;
    cascadeDelay = cascadeDelay==null ? "500": cascadeDelay;

    if(width != null) {
      if(style.length() > 0) {
         style = style + "; ";
      }
      style = style + "width: " + width + "px";
    }

    boolean execOnLoad = true;
    if(onload != null && !"".equals(onload)) {
        execOnLoad = Boolean.valueOf(onload);
    }

    boolean wrapedText = false;
    if(wrapText != null && !"".equals(wrapText)) {
        wrapedText = Boolean.valueOf(wrapText);
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
    if(parentPath==null || "".equals(parentPath)){
        if(beanName != null && !"".equals(beanName)){
            if(dynaQuery) {
                data = TagUtils.getService(pageContext, DynaContentService.class).getListElements(beanName, TagUtils.getConditions(filters), null, null, pattern);
            } else {
                data = TagUtils.getService(pageContext, DynaContentService.class).getListElements(beanName, TagUtils.getConditions(filters), null, pattern);
            }
        }else if(service != null && !"".equals(service)){
            data = ((SelectListService)TagUtils.getService(pageContext, (Class)ClassUtils.forName(service))).getListElements(TagUtils.getConditions(filters), null, pattern, dynaQuery);
        }
    }
    if(items != null) {
        data = items;
    }

    StringBuffer options = new StringBuffer();
    final HashMap addOptions = (HashMap)pageContext.getAttribute(DynaContentService.ADD_OPTIONS, PageContext.REQUEST_SCOPE);
    final HashMap addPostOptions = (HashMap)pageContext.getAttribute(DynaContentService.ADD_OPTIONS + "_POST", PageContext.REQUEST_SCOPE);
    if(path != null) {
        if(upperCased) {
%>
            <input type="hidden" name="<%=ControllerWebBindingInitializer.UPPER_CASE_PREFIX%><%=path%>" value="true"/>
<%
        }
%>
        <html:select path="<%=path%>" size="<%=size%>" multiple="<%=Boolean.valueOf(multiple)%>" cssClass="<%=cssClass%>" disabled="<%=Boolean.valueOf(disabled).toString()%>" onchange="<%=onchange%>" cssStyle="<%=style%>" >
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
<%    
            if(addPostOptions!=null && !addPostOptions.isEmpty()) {
                String key =  null;
                String text = null;
                for(Iterator it = addPostOptions.keySet().iterator(); it.hasNext();) {
                    key =  (String)it.next();
                    text = (String)addPostOptions.get(key);
                    options.append(key).append("::").append(text).append(";");
%>
                    <html:option value="<%=key%>"><spring:message code="<%=text%>"/></html:option>
<%
                }
            }
%>
        </html:select>
<%
    } else if(name != null) {
        if(upperCased) {
%>
            <input type="hidden" name="<%=ControllerWebBindingInitializer.UPPER_CASE_PREFIX%><%=name%>" value="true"/>
<%
        }

        String htmlDisabled = Boolean.valueOf(disabled) ? "disabled=\"disabled\"" : "";
        String htmlMultiple = Boolean.valueOf(multiple) ? "multiple=\"multiple\"" : "";
%>
        <select id="<%=name%>" name="<%=name%>" size="<%=size%>" cssClass="<%=cssClass%>" onchange="<%=onchange%>" <%=htmlDisabled%> <%=htmlMultiple%> style="<%=style%>">
<%
            if(addOptions!=null && !addOptions.isEmpty()) {
                String key =  null;
                String text = null;
                for(Iterator it = addOptions.keySet().iterator(); it.hasNext();) {
                    key =  (String)it.next();
                    text = (String)addOptions.get(key);
                    options.append(key).append("::").append(text).append(";");
%>
                    <option value="<%=key%>"><spring:message code="<%=text%>"/></option>
<%
                }
            }
            for(final Iterator iter = data.iterator(); iter.hasNext();) {
                SelectListDTO selectList = (SelectListDTO)iter.next();
%>
                <option value="<%=selectList.getKey()%>"><%=selectList.getValue()%></option>
<%
            }
%>
        </select>
<%
        path = name;
    }
%>
    <script type="text/javascript">
        function handleReadonlySelect<%=path%>(selectId) {
            //console.log("Execute handleReadonlySelect<%=path%>[" + selectId + "]");
            jQuery(selectId).after(function(i) {    //Crea un "hidden" con el valor seleccionado (option selected) para enviarlo en caso de que el select tenga el atributo "readonly"
                var hiddenHtml = "";
                var selectObj = jQuery(this);
                if(jQuery(selectObj).attr("readonly")) {
                    jQuery(selectObj).attr("disabled", "disabled");
                    jQuery(selectObj).find("option:selected").each(function(j, optionObj) {
                        if(jQuery(optionObj).val()) {
                            hiddenHtml = hiddenHtml + "<input type='hidden' id='" + jQuery(selectObj).attr("id") + "' name='" + jQuery(selectObj).attr("name") + "' value='" + jQuery(optionObj).val() + "'>\n";
                        }
                    });
                }
                return hiddenHtml;
            });
        }
        function handleWrapTextOptionSelect<%=path%>(selectId) {
            //console.log("Execute handleWrapTextOptionSelect<%=path%>[" + selectId + "]");
<%
            if(width != null) {
%>
                jQuery(selectId).selectmenu({ width: <%=width%> });
<%
            } else {
%>
                jQuery(selectId).selectmenu();
<%
            }
            if(upperCased) {
%>
                jQuery(selectId).selectmenu("widget").addClass("uppercase");
                jQuery(selectId).selectmenu("menuWidget").addClass("uppercase");
<%
            }
%>
            jQuery(selectId).selectmenu("menuWidget").css("height", "<%=height%>px");
            
            //Se agrega try-catch para corregir el error que se mostraba en los navegadores: no se encuentra la variable 'eq'
            try{ jQuery(selectId).selectmenu("refresh"); } catch(e) {}
        }
        jQuery(document).ready(function() {
            //console.log("Register document.ready[#<%=path%>]");
            handleReadonlySelect<%=path%>("#<%=path%>");
<%
            if(wrapedText) {
%>
                handleWrapTextOptionSelect<%=path%>("#<%=path%>");
                jQuery("#<%=path%>").on("selectmenuchange", function (event, ui) {
                    jQuery("#<%=path%>").change();
                });
<%
            }
%>
        });
    </script>
<%
    if((parentPath!=null && !parentPath.equals("")) && ((beanName != null && !"".equals(beanName)) || (service != null && !"".equals(service)))) {
        StringBuffer filterStr = new StringBuffer();     
        Object params[] = new Object[]{};
        if(filters!=null && filters.get() != null) {
            for(final Iterator iter = filters.get().iterator(); iter.hasNext();) {
                params = (Object[]) iter.next();            
                filterStr.append("filter_value_").append(params[0]).append("=").append(params[2]).append(", ");
                filterStr.append("filter_condition_").append(params[0]).append("=").append(params[1]).append(", "); //TODO EMM - Bug: si se define un filter con condition="=", en el TagUtils.getConditions no se obtiene correctamente el valor del request con la condicion. Se debe definir como condition="eq" 
            }
        }
        String addPathParams = "";
        if(additionalPaths != null) {            
            for(String addPath : additionalPaths) {
                addPathParams += "padre={" + addPath.trim() + "}, ";
            }
        }
        String parameters   = "padre={"+parentPath+"}, " + addPathParams + "beanName="+beanName+", serviceName="+service+ ", " +filterStr.toString()+", patternValue="+pattern+", options="+options.toString()+", dynaQuery="+dynaQuery ;
        String preFunction  = "initProgress"+path;
        String postFunction = "resetProgress"+path;        
        String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/util/getListElements.do";        
        if(progress!=null && progress.equals("true")) {
%>
            <span id="progressMsg<%=path%>" style="display:none;"><img alt="indicator" src="<spring:theme code="indicator.gif"/>" /></span>
<%
        }
%>
        <spring:bind path="${path}">
            <c:set var="requestValue" value="${status.value}"/>
        </spring:bind>
<%
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
            function initProgress<%=path%>() {
                //console.log("initProgress: [<%=path%>]");
                var pagePreFunction = "<%=pagePreFunction%>";
                if(pagePreFunction != "") {
                    var fn = window[pagePreFunction]; // find object
                    if(typeof fn === "function") {    // is object a function?, then execute
                        fn();
                    }
                }
                
                this.cancelExecution=false;
                //console.log('combo: [<%=path%>],parameters: [<%=parameters%>], filterPaths: [<%=filterPaths%>]');
                <%if(parentPath!=null && !parentPath.equals("")) {%>
                      //console.log('parentPath: '+'<%=parentPath%>' +':'+document.getElementById('<%=parentPath%>').value);
                      if(!document.getElementById('<%=parentPath%>').value) {
                          //console.log('cancel ajax request execution.. '+this.preFunction.name);
                          this.cancelExecution=true;
                          return;
                      }
                <%}
                  if(additionalPaths != null && additionalPaths.length>0) {
                      for(String tempPath:additionalPaths) {
                %>
                          //console.log('<%=tempPath%>' +':'+document.getElementById('<%=tempPath%>').value);
                          if(!document.getElementById('<%=tempPath%>').value) {
                              //console.log('cancel ajax request execution.. '+this.preFunction.name);
                              this.cancelExecution=true;
                              return;
                          }
                <%    }
                  }
                %>
                document.getElementById('<%=path%>').options.length = 0;
                Element.show('progressMsg<%=path%>');
            }

            function resetProgress<%=path%>() {
                setTimeout("delayResetProgress<%=path%>()", <%=cascadeDelay%>);
            }

            function delayResetProgress<%=path%>() {
                //console.log("delayResetProgress: [<%=path%>]");
                //Select previous selected option
                var options<%=path%> = document.getElementById('<%=path%>').getElementsByTagName('option');
                for(i=0; i< options<%=path%>.length; i++) {
                    if(i == 0) {
                        options<%=path%>[0].selected = true;            //Por default muestra la opcion 0 seleccionada
                    }
                    if("<%=arrValue%>".indexOf(","+options<%=path%>[i].value+",") >- 1) {
                        options<%=path%>[0].selected = false;           //Una vez que se obtiene la opcion con el valor seleccionado se deselecciona la opcion 0
                        options<%=path%>[i].selected = true;            //y se selecciona la opcion correspondiente
                    }
                }
<%
                if(wrapedText) {
%>
                    handleWrapTextOptionSelect<%=path%>("#<%=path%>");
<%
                }
%>
                //Execute onchange event
                var select<%=path%> = document.getElementById('<%=path%>');
                //console.log('<%=path%> Before on change.. ');
                var evt<%=path%> = document.createEvent('HTMLEvents');
                evt<%=path%>.initEvent('change', true, true);
                select<%=path%>.dispatchEvent(evt<%=path%>);

                handleReadonlySelect<%=path%>("#<%=path%>");
<%
                if(Boolean.valueOf(disabled)) {
%>
                    jQuery("#<%=path%>").attr("disabled", "disabled");
<%
                }
%>
                Element.hide('progressMsg<%=path%>');
            }

            //El tag de ajax elimina el atributo onchange del select padre, por lo tanto se obtiene el valor del atributo antes de definir el tag ajax y se vuelve a setear al finalizar su definicion.
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
          executeOnLoad="<%=Boolean.toString(execOnLoad)%>" />
          
        <script type="text/javascript">
            parentObj.onchange = parentOnchange;
        </script>
<%
        if(additionalPaths != null && additionalPaths.length>0) {
%>
            <c:forEach items="<%=additionalPaths%>" var="adittionalSource">                        
                <script type="text/javascript">
                    //El tag de ajax elimina el atributo onchange del select padre, por lo tanto se obtiene el valor del atributo antes de definir el tag ajax y se vuelve a setear al finalizar su definicion.
                    var parentObj = document.getElementById('<c:out value="${adittionalSource}"/>');
                    var parentOnchange = parentObj.onchange;
                </script> 

                <ajax:select
                  baseUrl="<%=baseUrl%>"
                  source="${adittionalSource}"
                  target="<%=path%>"
                  parameters="<%=parameters%>"
                  preFunction="<%=preFunction%>"
                  postFunction="<%=postFunction%>"
                  executeOnLoad="<%=Boolean.toString(execOnLoad)%>" />

                <script type="text/javascript">
                    parentObj.onchange = parentOnchange;
                </script>
            </c:forEach>
<%          
        }
    }

    if(path != null && Boolean.valueOf(disabled) && !Boolean.valueOf(multiple)) {
%>
        <html:hidden path="<%=path%>"/>
<%
    }
} catch(Exception e) {
    e.printStackTrace();
}finally{
    pageContext.removeAttribute(filterId, PageContext.REQUEST_SCOPE);
    pageContext.removeAttribute(DynaContentService.ADD_OPTIONS, PageContext.REQUEST_SCOPE);
}
%>
