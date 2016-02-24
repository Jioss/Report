<%@ taglib uri="/WEB-INF/lib/reports_tld.jar" prefix="rw" %> 
<%@ page language="java" import="java.io.*" errorPage="/rwerror.jsp" session="false" %>
<%@ page contentType="text/html;charset=ISO-8859-1" %>
<!--
<rw:report id="report"> 
<rw:objects id="objects">
<?xml version="1.0" encoding="GBK" ?>
<report name="MODULE2" DTDVersion="9.0.2.0.10">
  <xmlSettings xmlTag="MODULE2" xmlPrologType="text">
  <![CDATA[<?xml version="1.0" encoding="&Encoding"?>]]>
  </xmlSettings>
  <data>
    <userParameter name="P_CREATION_DATE_FROM" datatype="character" width="40"
     defaultWidth="0" defaultHeight="0"/>
    <userParameter name="P_CREATION_DATE_TO" datatype="character" width="40"
     defaultWidth="0" defaultHeight="0"/>
    <systemParameter name="MODE" initialValue="Default"/>
    <systemParameter name="ORIENTATION" initialValue="Default"/>
    <dataSource name="Q_1">
      <select>
      <![CDATA[SELECT flt.lookup_type,
       flt.meaning           lookup_type_meaning,
       fav.application_name,
       flt.description,
       flv.lookup_code,
       flv.meaning           lookup_code_meaning,
       flv.description       lookup_code_desc,
       flv.tag,
       flv.start_date_active,
       flv.end_date_active,
       fnd_user.user_id,
       flt.creation_date
  FROM fnd_lookup_types_vl  flt,
       fnd_application_vl   fav,
       fnd_lookup_values_vl flv,
       fnd_user
 WHERE flt.lookup_type = 'CUX_EMPLOYEE_STATUS'
   AND flt.application_id = fav.application_id
   AND flt.lookup_type = flv.lookup_type
   AND flv.view_application_id = 20067
   AND flv.security_group_id = 0
   AND fnd_user.user_id = fnd_global.user_id
   AND trunc(flt.creation_date) BETWEEN to_date(:p_creation_date_from,'YYYY-MM-DD hh24:mi:ss') AND to_date(:p_creation_date_to,'YYYY-MM-DD hh24:mi:ss')]]>
      </select>
      <displayInfo x="1.65002" y="1.00000" width="0.69995" height="0.19995"/>
      <group name="G_lookup_type">
        <displayInfo x="0.97449" y="1.94995" width="2.05115" height="0.97949"
        />
        <dataItem name="lookup_type" datatype="vchar2" columnOrder="13"
         width="30" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Lookup Type">
          <dataDescriptor expression="flt.lookup_type"
           descriptiveExpression="LOOKUP_TYPE" order="1" width="30"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="lookup_type_meaning" datatype="vchar2"
         columnOrder="14" width="80" defaultWidth="100000"
         defaultHeight="10000" columnFlags="33"
         defaultLabel="Lookup Type Meaning">
          <dataDescriptor expression="flt.meaning"
           descriptiveExpression="LOOKUP_TYPE_MEANING" order="2" width="80"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="application_name" datatype="vchar2" columnOrder="15"
         width="240" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Application Name">
          <dataDescriptor expression="fav.application_name"
           descriptiveExpression="APPLICATION_NAME" order="3" width="240"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="description" datatype="vchar2" columnOrder="16"
         width="240" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Description">
          <dataDescriptor expression="flt.description"
           descriptiveExpression="DESCRIPTION" order="4" width="240"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
      </group>
      <group name="G_lookup_code">
        <displayInfo x="0.97449" y="3.67944" width="2.05115" height="1.69922"
        />
        <dataItem name="lookup_code" datatype="vchar2" columnOrder="17"
         width="30" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Lookup Code">
          <dataDescriptor expression="flv.lookup_code"
           descriptiveExpression="LOOKUP_CODE" order="5" width="30"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="lookup_code_meaning" datatype="vchar2"
         columnOrder="18" width="80" defaultWidth="100000"
         defaultHeight="10000" columnFlags="33"
         defaultLabel="Lookup Code Meaning">
          <dataDescriptor expression="flv.meaning"
           descriptiveExpression="LOOKUP_CODE_MEANING" order="6" width="80"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="lookup_code_desc" datatype="vchar2" columnOrder="19"
         width="240" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Lookup Code Desc">
          <dataDescriptor expression="flv.description"
           descriptiveExpression="LOOKUP_CODE_DESC" order="7" width="240"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="tag" datatype="vchar2" columnOrder="20" width="150"
         defaultWidth="100000" defaultHeight="10000" columnFlags="33"
         defaultLabel="Tag">
          <dataDescriptor expression="flv.tag" descriptiveExpression="TAG"
           order="8" width="150"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="start_date_active" datatype="date"
         oracleDatatype="date" columnOrder="21" width="9" defaultWidth="90000"
         defaultHeight="10000" columnFlags="33"
         defaultLabel="Start Date Active">
          <dataDescriptor expression="flv.start_date_active"
           descriptiveExpression="START_DATE_ACTIVE" order="9" width="9"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="end_date_active" datatype="date" oracleDatatype="date"
         columnOrder="22" width="9" defaultWidth="90000" defaultHeight="10000"
         columnFlags="33" defaultLabel="End Date Active">
          <dataDescriptor expression="flv.end_date_active"
           descriptiveExpression="END_DATE_ACTIVE" order="10" width="9"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="user_id" oracleDatatype="number" columnOrder="23"
         width="22" defaultWidth="90000" defaultHeight="10000"
         columnFlags="33" defaultLabel="User Id">
          <dataDescriptor expression="fnd_user.user_id"
           descriptiveExpression="USER_ID" order="11" width="22"
           precision="15"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="creation_date" datatype="date" oracleDatatype="date"
         columnOrder="24" width="9" defaultWidth="90000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Creation Date">
          <dataDescriptor expression="flt.creation_date"
           descriptiveExpression="CREATION_DATE" order="12" width="9"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
      </group>
    </dataSource>
  </data>
  <layout>
  <section name="main">
    <body>
      <frame name="M_G_lookup_type_GRPFR">
        <geometryInfo x="0.00000" y="0.00000" width="7.31250" height="0.81250"
        />
        <generalLayout verticalElasticity="variable"/>
        <repeatingFrame name="R_G_lookup_type" source="G_lookup_type"
         printDirection="down" minWidowRecords="1" columnMode="no">
          <geometryInfo x="0.00000" y="0.00000" width="7.31250"
           height="0.81250"/>
          <generalLayout verticalElasticity="variable"/>
          <field name="F_lookup_type" source="lookup_type" minWidowLines="1"
           spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="0.87500" y="0.00000" width="0.81250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <frame name="M_G_lookup_code_GRPFR">
            <geometryInfo x="0.00000" y="0.31250" width="7.25000"
             height="0.50000"/>
            <generalLayout verticalElasticity="variable"/>
            <repeatingFrame name="R_G_lookup_code" source="G_lookup_code"
             printDirection="down" minWidowRecords="1" columnMode="no">
              <geometryInfo x="0.00000" y="0.62500" width="7.25000"
               height="0.18750"/>
              <generalLayout verticalElasticity="expand"/>
              <field name="F_lookup_code" source="lookup_code"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="0.00000" y="0.62500" width="0.87500"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_lookup_code_meaning" source="lookup_code_meaning"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="0.87500" y="0.62500" width="1.43750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_lookup_code_desc" source="lookup_code_desc"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="2.31250" y="0.62500" width="1.25000"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_tag" source="tag" minWidowLines="1" spacing="0"
               alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="3.56250" y="0.62500" width="0.81250"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_start_date_active" source="start_date_active"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="4.37500" y="0.62500" width="0.81250"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_end_date_active" source="end_date_active"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="5.18750" y="0.62500" width="0.68750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_user_id" source="user_id" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="5.87500" y="0.62500" width="0.68750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_creation_date" source="creation_date"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="6.56250" y="0.62500" width="0.68750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
            </repeatingFrame>
            <frame name="M_G_lookup_code_HDR">
              <geometryInfo x="0.00000" y="0.31250" width="7.25000"
               height="0.31250"/>
              <advancedLayout printObjectOnPage="allPage"
               basePrintingOn="enclosingObject"/>
              <text name="B_lookup_code" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="0.00000" y="0.31250" width="0.87500"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Lookup Code]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_lookup_code_meaning" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="0.87500" y="0.31250" width="1.43750"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Lookup Code Meaning]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_lookup_code_desc" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="2.31250" y="0.31250" width="1.25000"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Lookup Code Desc]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_tag" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="3.56250" y="0.31250" width="0.81250"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Tag]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_start_date_active" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="4.37500" y="0.31250" width="0.81250"
                 height="0.31250"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Start Date
]]>
                  </string>
                </textSegment>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Active]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_end_date_active" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="5.18750" y="0.31250" width="0.68750"
                 height="0.31250"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[End Date
]]>
                  </string>
                </textSegment>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Active]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_user_id" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="5.87500" y="0.31250" width="0.68750"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[User Id]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_creation_date" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="6.56250" y="0.31250" width="0.68750"
                 height="0.31250"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Creation
]]>
                  </string>
                </textSegment>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Date]]>
                  </string>
                </textSegment>
              </text>
            </frame>
          </frame>
          <text name="B_lookup_type" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="0.00000" y="0.00000" width="0.87500"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[Lookup Type]]>
              </string>
            </textSegment>
          </text>
          <field name="F_lookup_type_meaning" source="lookup_type_meaning"
           minWidowLines="1" spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="3.12500" y="0.00000" width="0.81250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <text name="B_lookup_type_meaning" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="1.68750" y="0.00000" width="1.43750"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[Lookup Type Meaning]]>
              </string>
            </textSegment>
          </text>
          <field name="F_application_name" source="application_name"
           minWidowLines="1" spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="4.81250" y="0.00000" width="0.81250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <text name="B_application_name" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="3.93750" y="0.00000" width="0.87500"
             height="0.31250"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[Application
]]>
              </string>
            </textSegment>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[Name]]>
              </string>
            </textSegment>
          </text>
          <field name="F_description" source="description" minWidowLines="1"
           spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="6.50000" y="0.00000" width="0.81250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <text name="B_description" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="5.62500" y="0.00000" width="0.87500"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[Description]]>
              </string>
            </textSegment>
          </text>
        </repeatingFrame>
      </frame>
    </body>
  </section>
  </layout>
  <reportPrivate defaultReportType="masterDetail" versionFlags2="0"
   templateName=""/>
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



</head>


<body>

<!-- Data Area Generated by Reports Developer -->
<rw:dataArea id="MGlookuptypeGRPFR80">
<rw:foreach id="RGlookuptype801" src="G_lookup_type">
<!-- Start GetGroupHeader/n --> <table>
 <caption>  <br>Lookup Type <rw:field id="F_lookup_type" src="lookup_type" breakLevel="RGlookuptype801" breakValue="&nbsp;"> F_lookup_type </rw:field><br>
Lookup Type Meaning <rw:field id="F_lookup_type_meaning" src="lookup_type_meaning" breakLevel="RGlookuptype801" breakValue="&nbsp;"> F_lookup_type_meaning </rw:field><br>
Application
Name <rw:field id="F_application_name" src="application_name" breakLevel="RGlookuptype801" breakValue="&nbsp;"> F_application_name </rw:field><br>
Description <rw:field id="F_description" src="description" breakLevel="RGlookuptype801" breakValue="&nbsp;"> F_description </rw:field><br>
 </caption>
<!-- End GetGroupHeader/n -->   <tr>
    <td valign="top">
    <table summary="">
     <!-- Header -->
     <thead>
      <tr>
       <th <rw:id id="HBlookupcode80" asArray="no"/>> Lookup Code </th>
       <th <rw:id id="HBlookupcodemeaning80" asArray="no"/>> Lookup Code Meaning </th>
       <th <rw:id id="HBlookupcodedesc80" asArray="no"/>> Lookup Code Desc </th>
       <th <rw:id id="HBtag80" asArray="no"/>> Tag </th>
       <th <rw:id id="HBstartdateactive80" asArray="no"/>> Start Date
Active </th>
       <th <rw:id id="HBenddateactive80" asArray="no"/>> End Date
Active </th>
       <th <rw:id id="HBuserid80" asArray="no"/>> User Id </th>
       <th <rw:id id="HBcreationdate80" asArray="no"/>> Creation
Date </th>
      </tr>
     </thead>
     <!-- Body -->
     <tbody>
      <rw:foreach id="RGlookupcode801" src="G_lookup_code">
       <tr>
        <td <rw:headers id="HFlookupcode80" src="HBlookupcode80"/>><rw:field id="Flookupcode80" src="lookup_code" nullValue="&nbsp;"> F_lookup_code </rw:field></td>
        <td <rw:headers id="HFlookupcodemeaning80" src="HBlookupcodemeaning80"/>><rw:field id="Flookupcodemeaning80" src="lookup_code_meaning" nullValue="&nbsp;"> F_lookup_code_meaning </rw:field></td>
        <td <rw:headers id="HFlookupcodedesc80" src="HBlookupcodedesc80"/>><rw:field id="Flookupcodedesc80" src="lookup_code_desc" nullValue="&nbsp;"> F_lookup_code_desc </rw:field></td>
        <td <rw:headers id="HFtag80" src="HBtag80"/>><rw:field id="Ftag80" src="tag" nullValue="&nbsp;"> F_tag </rw:field></td>
        <td <rw:headers id="HFstartdateactive80" src="HBstartdateactive80"/>><rw:field id="Fstartdateactive80" src="start_date_active" nullValue="&nbsp;"> F_start_date_active </rw:field></td>
        <td <rw:headers id="HFenddateactive80" src="HBenddateactive80"/>><rw:field id="Fenddateactive80" src="end_date_active" nullValue="&nbsp;"> F_end_date_active </rw:field></td>
        <td <rw:headers id="HFuserid80" src="HBuserid80"/>><rw:field id="Fuserid80" src="user_id" nullValue="&nbsp;"> F_user_id </rw:field></td>
        <td <rw:headers id="HFcreationdate80" src="HBcreationdate80"/>><rw:field id="Fcreationdate80" src="creation_date" nullValue="&nbsp;"> F_creation_date </rw:field></td>
       </tr>
      </rw:foreach>
     </tbody>
     <tr>
     </tr>
    </table>
   </td>
  </tr>
 </table>
</rw:foreach>
<table summary="">
</table>
</rw:dataArea> <!-- id="MGlookuptypeGRPFR80" -->
<!-- End of Data Area Generated by Reports Developer -->




</body>
</html>

<!--
</rw:report> 
-->
