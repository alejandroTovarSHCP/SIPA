<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page contentType="text/html;charset=ISO_8859-1"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>.:iFrame:.</title>
    <META HTTP-EQUIV="X-Frame-Options" CONTENT="sameorigin"/> <!-- Prevents "clickjacking" attack -->
    <META HTTP-EQUIV="X-UA-Compatible" CONTENT="IE=Edge; chrome=1"/>
    <!--META HTTP-EQUIV="X-UA-Compatible" CONTENT="IE=9; chrome=1"/--> <!-- VAADIN compatibillity -->
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=ISO_8859-1"/>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
    <META HTTP-EQUIV="Expires" CONTENT="0"/>
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-store"/>
    <META NAME="use-iframe" CONTENT= "true"/>
    <meta charset="utf-8">
    <tiles:insertAttribute name="javaScript" ignore="true"/>    
    <tiles:insertAttribute name="htmlHeader" ignore="true"/>
  </head>    
  <body>
    <table width="100%" align="center">
        <tr> <!--Header-->
          <td>
            <tiles:insertAttribute name="breadCrumb"/>
            <tiles:insertAttribute name="onLoad" ignore="true"/>
          </td>
        </tr>        
    </table>    
    <table width="100%" align="center">
        <tr> <!--Body-->
          <td align="center">
            <table width="100%" align="center">
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
  </body>
  <tiles:insertAttribute name="onFinishLoad" ignore="true"/>
  <tiles:insertAttribute name="nocache"/>
</html>
