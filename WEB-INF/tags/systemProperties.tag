<%@ tag import="org.springframework.web.util.ExpressionEvaluationUtils" %>
<%@ tag import="org.springframework.web.util.TagUtils" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.Enumeration" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.Properties" %>
<%@ tag import="java.util.Set" %>
<%@ tag import="java.util.SortedSet" %>
<%@ tag import="java.util.TreeSet" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="propsType" %>

<table class="body" style="width: 100%">
  <tr>
   <th>Par&aacute;metro</th>
   <th>Valor</th>
  </tr>
<%   
   try {
      int i=0;
      SortedSet<String> ss = new TreeSet<String>();
      if(propsType.equalsIgnoreCase("system")) {
         ss.addAll(System.getenv().keySet());
         for(String envName: ss) {
%>
            <tr class="<%=(i%2)==0?"even":"odd" %>">
              <td class="label"><%=envName%></td>
              <td><%=System.getenv(envName)%></td>
            </tr>
<%
            i++;
         }
      } else if(propsType.equalsIgnoreCase("java")) {
         for(Enumeration e = System.getProperties().propertyNames(); e.hasMoreElements();) {
            ss.add((String)e.nextElement());
         }
         for(String envName: ss) {
%>
            <tr class="<%=(i%2)==0?"even":"odd" %>">
              <td class="label"><%=envName%></td>
              <td><%=System.getProperty(envName)%></td>
            </tr>
<%
            i++;
         }
      } else {
         Properties props = new Properties();
         props.load(gob.shcp.fsn.service.Service.class.getClassLoader().getResourceAsStream("/META-INF/environment.properties"));
         List<String> propsList = new ArrayList<String>();
         for(Enumeration e = props.propertyNames(); e.hasMoreElements();) {
            String prop = (String)e.nextElement();
            if(prop.contains("bean")) {
               propsList.add(prop);
               String[] parts = prop.split("\\.");
               for(Enumeration e2 = props.propertyNames(); e2.hasMoreElements();) {
                  String prop2 = (String)e2.nextElement();
                  if(!prop2.equals(prop) && prop2.startsWith(parts[0])) {
                     propsList.add(prop2);
                  }
               }
            }
            ss.add(prop);
         }
         for(String property: ss) {
            if(!propsList.contains(property)) {
               propsList.add(property);
            }
         }
         for(String property: propsList) {
%>
            <tr class="<%=(i%2)==0?"even":"odd" %>">
              <td class="label"><%=property%></td>
<%
            if(System.getProperty(property) != null) {
%>
              <td style="font-weight: bold;"><%=System.getProperty(property)%></td>
<%
            } else {
%>
              <td><%=props.getProperty(property)%></td>
<%
            }
%>
            </tr>
<%
            i++;
         }
      }
   } catch(Exception e) {
      e.printStackTrace();
   }
%>
</table>
