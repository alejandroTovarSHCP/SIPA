<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>

<div id="messages">
<fsn:bindErrors path="*.*"><!-- Todos los objetos, todas sus propiedades -->
<c:if test="${!empty resolvedPath}">
  <spring:bind path="${resolvedPath}">
    <c:if test="${status.error}">
      <table width="100%">
        <tr align="center">
          <td>
            <table class="message">
              <tr>
                <td class="error"><img src="<spring:theme code="error.gif"/>" alt="error" width="30" height="30"></td>
                <td>
                  <table border="0" cellpadding="0" cellspacing="0">
                    <c:set var="bindErrors" value="true"/>
                    <c:forEach items="${status.errorMessages}" var="error">
                      <tr><td>
                        <c:out value="${error}"/><br/>
                      </td></tr>
                    </c:forEach>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>    
    </c:if>
  </spring:bind>
</c:if>
</fsn:bindErrors>
<c:if test="${!empty errors}">
  <table width="100%">
    <tr align="center">
      <td>
        <table class="message">
          <tr>
            <td class="error"><img src="<spring:theme code="error.gif"/>" alt="error" width="30" height="30"></td>
            <td>
             <table border="0" cellpadding="0" cellspacing="0">
              <!--<c:forEach items="${errors}" var="errorItem">
                <tr><td>
                  <c:out value="${errorItem}"/></br>
                </td></tr>
              </c:forEach>-->
                Error inesperado, contacte con el administrador.
             </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>    
</c:if>
<c:if test="${empty errors && empty bindErrors}">
  <c:if test="${!empty requestScope['javax.servlet.error.exception']}">
    <table width="100%">
      <tr align="center">
        <td>
          <table class="message">
            <tr>
              <td class="error"><img src="<spring:theme code="error.gif"/>" alt="error" width="30" height="30"></td>
              <td>
               <table border="0" cellpadding="0" cellspacing="0">
                  <tr><td>
                    <!-- <c:out value="${requestScope['javax.servlet.error.exception']}"/>	-->
                    Error inesperado, contacte con el administrador.
                  </td></tr>
               </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </c:if>
  <c:if test="${!empty warnings}">
    <table width="100%">
       <tr align="center">
         <td>
           <table class="message">
             <tr>
               <td class="warn"><img src="<spring:theme code="warn.gif"/>" alt="warn" width="30" height="30"></td>
               <td>
                <table border="0" cellpadding="0" cellspacing="0">
                 <c:forEach items="${warnings}" var="warningItem">
                  <tr><td>
                    <c:out value="${warningItem}"/></br>
                  </td></tr>
                 </c:forEach>
                </table>
               </td>
             </tr>
           </table>
         </td>
       </tr>
    </table>
  </c:if>
  <c:if test="${!empty messages}">
    <table width="100%">
       <tr align="center">
         <td>
           <table class="message">
             <tr>
               <td class="info"><img src="<spring:theme code="info.gif"/>" alt="info" width="30" height="30"></td>
               <td>
                <table border="0" cellpadding="0" cellspacing="0">
                 <c:forEach items="${messages}" var="messageItem">
                  <tr><td>
                    <c:out value="${messageItem}"/></br>
                  </td></tr>
                 </c:forEach>
                </table>
               </td>
             </tr>
           </table>
         </td>
       </tr>
    </table>
  </c:if>
</c:if>

<c:remove var="errors"/>
<c:remove var="javax.servlet.error.exception"/>
<c:remove var="warnings"/>
<c:remove var="messages"/>
</div>
