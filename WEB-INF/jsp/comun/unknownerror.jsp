<%@ page isErrorPage="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 
<c:if test="${!empty exceptionStackTrace}">
    <table width="100%">
        <tr align="center">
          <td>
            <table class="unknownerror">
              <tr>
                <td class="error"><img src="<spring:theme code="error.gif"/>" alt="error" width="30" height="30"></td>
                <td>
                  <jsp:useBean id="today" class="java.util.Date" scope="page" />
                  <spring:message code="unknown.error.text" arguments="${today}"/>
                  <spring:message code="unknown.error.system.info"/>
                  <spring:message code="unknown.error.help.desk.info"/>
                </td>
              </tr>
              </table>
            </td>
          </tr>
        <tr>
          <td align="center">&nbsp;</td>
        </tr>
        <tr>
          <td align="center">Esta informacion es solo para desarrollo...</td>
        </tr>
        <tr align="center">
          <td>
	    <input name="addrows" type="button" value="  +  " class="normal" onClick="document.getElementById('stackTrace').rows = (document.getElementById('stackTrace').rows + 5);">
	    <input name="delrows" type="button" value="  -  " class="normal" onClick="document.getElementById('stackTrace').rows = (document.getElementById('stackTrace').rows - 5);">
	    <input name="restorerows" type="button" value="restore" class="normal" onClick="document.getElementById('stackTrace').rows = 40;">
	    <br>
            <br>
            <textarea id="stackTrace" cols="185" rows="40" readonly="readonly" wrap="OFF">
              <c:out value="${exceptionStackTrace}"/>
            </textarea>	  		  
          </td>
        </tr>
      </table>    
</c:if>
 -->
