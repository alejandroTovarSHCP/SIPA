<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="currentYear" class="java.util.Date" scope="page"/>
<fmt:formatDate var="currentYear" type="date" pattern="yyyy" value="${currentYear}"/>
      <table class="copyright">
      	<tr>
          <td>
            <p>
                <div class="divBase"></div>
                <div class="infoBase"><spring:message code="footer.copyright.text" arguments="${currentYear}"/></div>
                <div class="divBase"></div>
            </p>
          </td>
        </tr>
      </table>
