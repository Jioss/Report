<%@ taglib uri="/WEB-INF/lib/reports_tld.jar" prefix="rw" %> 
<%@ page language="java" import="java.io.*" errorPage="/rwerror.jsp" session="false" %>
<%@ page contentType="text/html;charset=ISO-8859-1" %>
<!--
<rw:report id="report"> 
<rw:objects id="objects">
<?xml version="1.0" encoding="GBK" ?>
<report name="MODULE21" DTDVersion="9.0.2.0.10">
  <xmlSettings xmlTag="MODULE2" xmlPrologType="text">
  <![CDATA[<?xml version="1.0" encoding="&Encoding"?>]]>
  </xmlSettings>
  <data>
    <userParameter name="TEXT_HTTPS" datatype="character"
     pluginClass="oracle.reports.plugin.datasource.textpds.TextDataSourceFactory"
     width="255" defaultWidth="0" defaultHeight="0" display="no"/>
    <userParameter name="P_JDBCPDS" datatype="character"
     pluginClass="oracle.reports.plugin.datasource.jdbcpds.JDBCDataSourceFactory"
     width="255" defaultWidth="0" defaultHeight="0" display="no"/>
    <systemParameter name="MODE" initialValue="Default"/>
    <systemParameter name="ORIENTATION" initialValue="Default"/>
    <summary name="CS_1" function="sum" width="20" precision="10"
     reset="report" compute="report" defaultWidth="0" defaultHeight="0"
     columnFlags="8">
      <displayInfo x="0.84180" y="0.55005" width="0.79993" height="0.20837"/>
    </summary>
    <formula name="CF_1" datatype="number" width="20" precision="10"
     defaultWidth="0" defaultHeight="0" columnFlags="16" breakOrder="none">
      <displayInfo x="0.81665" y="0.87500" width="0.79993" height="0.22498"/>
    </formula>
    <placeholder name="CP_1" datatype="number" width="20" precision="10"
     defaultWidth="0" defaultHeight="0" columnFlags="16">
      <displayInfo x="0.87500" y="1.22510" width="0.95837" height="0.21655"/>
    </placeholder>
  </data>
  <reportPrivate versionFlags2="0" templateName="rwbeige"/>
  <reportWebSettings>
  <![CDATA[]]>
  </reportWebSettings>
</report>
</rw:objects>
-->

<html>

<head>
<meta name="GENERATOR" content="Oracle 9i Reports Developer"/>
<title> Your Title </title>

<rw:style id="yourStyle">
   <!-- Report Wizard inserts style link clause here -->
</rw:style>

</head>


<body>

<rw:dataArea id="yourDataArea">
   <!-- Report Wizard inserts the default jsp here -->
</rw:dataArea>



</body>
</html>

<!--
</rw:report> 
-->
