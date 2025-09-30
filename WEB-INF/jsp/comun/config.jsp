<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn"%>

<script type="text/javascript">    
   jQuery(document).ready(function($) {
      $('#paneles').tabs();
   });
</script>

<div id="paneles" style="width: 1025px;">
   <ul>
      <li><a href="#tabulador1">MSSN</a></li>
      <li><a href="#tabulador2">System</a></li>
      <li><a href="#tabulador3">Properties</a></li>
   </ul>
   <div id="tabulador1">
      <fsn:systemProperties propsType="mssn"/>
   </div>
   <div id="tabulador2">
      <fsn:systemProperties propsType="system"/>
   </div>
   <div id="tabulador3">
      <fsn:systemProperties propsType="java"/>
   </div>
</div>
