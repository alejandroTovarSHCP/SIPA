<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page contentType="text/html;charset=ISO_8859-1"%>
<%@ page errorPage="/unknownError.do" autoFlush="true"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>

<fmt:setLocale value="es-MX" scope="session"/>

<spring:message var="msgFullNameApp" code="main.header.system.full.name"/>
<fsn:parameter var="fullNameApp" name="MAIN_HEADER_SYSTEM_FULL_NAME" type="string" defaultValue="${msgFullNameApp}"/>

<spring:message var="msgNameApp" code="main.header.application.name"/>
<fsn:parameter var="nameApp" name="MAIN_HEADER_APPLICATION_NAME" type="string" defaultValue="${msgNameApp}"/>

<fsn:exception>
  <!DOCTYPE html>
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>.:<c:out value="${fullNameApp}"/>&nbsp;<c:out value="${nameApp}"/>:.</title>
      <META HTTP-EQUIV="X-Frame-Options" CONTENT="deny"/> <!-- Prevents "clickjacking" attack -->
      <META HTTP-EQUIV="X-UA-Compatible" CONTENT="IE=Edge; chrome=1"/>
      <!--META HTTP-EQUIV="X-UA-Compatible" CONTENT="IE=9; chrome=1"/--> <!-- VAADIN compatibillity -->
      <META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=ISO_8859-1"/>
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
      <META HTTP-EQUIV="Expires" CONTENT="0"/>
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-store"/>
      <base target="_self"/>
      <tiles:insertAttribute name="javaScript" ignore="true"/>
      <tiles:insertAttribute name="htmlHeader" ignore="true"/>
      <style> body {display : none;} </style> <!-- Prevents "clickjacking" attack -->
    </head>
    <body>
      <table width="100%" align="center">
        <tr> <!--Header-->
          <td>
            <tiles:insertAttribute name="header"/>
          </td>
        </tr>        
      </table>
      <table width="100%" align="center">
        <tr> <!--Body-->
          <td align="center">
            <table class="body">
              <tr>
                <td>
                  <tiles:insertAttribute name="message"/>
                  <tiles:insertAttribute name="body"/>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="100%" align="center">
        <tr> <!--Footer-->
          <td align="center">
            <tiles:insertAttribute name="footer"/>
          </td>
        </tr>
      </table>
    </body>
    <tiles:insertAttribute name="nocache"/>
  </html>
</fsn:exception>
