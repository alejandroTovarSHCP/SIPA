<%@ taglib uri="http://struts-menu.sf.net/tag-el" prefix="menu"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

  <c:catch var="jspException">
    <menu:useMenuDisplayer name="CSSIFrameMenu" id="primary-nav" bundle="menuBundle" permissions="rolesAdapter" repository="repository">
        <c:forEach var="menu" items="${repository.topMenus}">
            <menu:displayMenu name="${menu.name}"/>
        </c:forEach>        
    </menu:useMenuDisplayer>
  </c:catch>
  <c:if test="${jspException != null}">
    <p>
        Ocurrio un error inesperado: <c:out value="${jspException.message}"/>
    </p>
  </c:if>
