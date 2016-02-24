<%@ taglib uri="/WEB-INF/lib/reports_tld.jar" prefix="rw" %> 
<%@ page language="java" import="java.io.*" errorPage="/rwerror.jsp" session="false" %>
<%@ page contentType="text/html;charset=ISO-8859-1" %>
<!--
<rw:report id="report"> 
<rw:objects id="objects">
<?xml version="1.0" encoding="GBK" ?>
<report name="JOURNAL_9510" DTDVersion="9.0.2.0.10">
  <xmlSettings xmlTag="MODULE2" xmlPrologType="text">
  <![CDATA[<?xml version="1.0" encoding="&Encoding"?>]]>
  </xmlSettings>
  <data>
    <userParameter name="P_NAME_FROM" datatype="character" width="40"
     defaultWidth="0" defaultHeight="0"/>
    <userParameter name="P_NAME_TO" datatype="character" width="40"
     defaultWidth="0" defaultHeight="0"/>
    <systemParameter name="MODE" initialValue="Default"/>
    <systemParameter name="ORIENTATION" initialValue="Default"/>
    <dataSource name="Q_1">
      <select canParse="no">
      <![CDATA[SELECT gjh.batch_name,
       gjh.name,
       gjh.default_effective_date,
       gjh.period_name,
       gjl.je_line_num,
       gjl.description,
       (SELECT gcc.concatenated_segments
          FROM gl_code_combinations_kfv gcc
         WHERE gcc.code_combination_id = gjl.code_combination_id) accounting_flexfield,
       gjl.entered_dr,
       gjl.entered_cr,
       fu.user_name

  FROM gl_je_headers_v gjh,
       gl_je_lines_v   gjl,
       fnd_user        fu

 WHERE gjh.name BETWEEN :p_name_from AND :p_name_to
   AND gjh.period_set_name = 'Accounting13'
   AND gjh.accounted_period_type = 'Month'
   AND (gjh.ledger_id IN (SELECT acc.ledger_id
                            FROM gl_access_set_ledgers acc
                           WHERE acc.access_set_id = 1225))
   AND gjh.created_by = fu.user_id
   AND gjh.je_header_id = gjl.je_header_id
   
 ORDER BY gjh.name,
          gjl.je_line_num]]>
      </select>
      <displayInfo x="1.65002" y="1.00000" width="0.69995" height="0.19995"/>
      <group name="G_BATCH_NAME">
        <displayInfo x="0.71814" y="1.94995" width="2.56384" height="1.51929"
        />
        <dataItem name="BATCH_NAME" datatype="vchar2" columnOrder="13"
         width="100" defaultWidth="200000" defaultHeight="10000"
         columnFlags="33" defaultLabel="批名">
          <dataDescriptor expression="BATCH_NAME"
           descriptiveExpression="BATCH_NAME" order="1" width="100"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="NAME" datatype="vchar2" columnOrder="14" width="100"
         defaultWidth="200000" defaultHeight="10000" columnFlags="33"
         defaultLabel="日记账名">
          <dataDescriptor expression="NAME" descriptiveExpression="NAME"
           order="2" width="100"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="DEFAULT_EFFECTIVE_DATE" datatype="date"
         oracleDatatype="date" columnOrder="15" width="9" defaultWidth="90000"
         defaultHeight="10000" columnFlags="33" defaultLabel="记账日期">
          <dataDescriptor expression="DEFAULT_EFFECTIVE_DATE"
           descriptiveExpression="DEFAULT_EFFECTIVE_DATE" order="3" width="9"
          />
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="PERIOD_NAME" datatype="vchar2" columnOrder="16"
         width="15" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="期间">
          <dataDescriptor expression="PERIOD_NAME"
           descriptiveExpression="PERIOD_NAME" order="4" width="15"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="USER_NAME" datatype="vchar2" columnOrder="22"
         width="100" defaultWidth="40000" defaultHeight="10000"
         columnFlags="33" defaultLabel="制单人">
          <dataDescriptor expression="USER_NAME"
           descriptiveExpression="USER_NAME" order="10" width="100"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <summary name="SumENTERED_DRPerBATCH_NAME" source="ENTERED_DR"
         function="sum" width="22" scale="-127" reset="G_BATCH_NAME"
         compute="report" defaultWidth="20000" defaultHeight="10000"
         columnFlags="552" defaultLabel="总计:">
          <displayInfo x="0.00000" y="0.00000" width="0.00000"
           height="0.00000"/>
        </summary>
        <summary name="SumENTERED_CRPerBATCH_NAME" source="ENTERED_CR"
         function="sum" width="22" scale="-127" reset="G_BATCH_NAME"
         compute="report" defaultWidth="20000" defaultHeight="10000"
         columnFlags="552" defaultLabel="总计:">
          <displayInfo x="0.00000" y="0.00000" width="0.00000"
           height="0.00000"/>
        </summary>
      </group>
      <group name="G_JE_LINE_NUM">
        <displayInfo x="0.93787" y="4.21924" width="2.12439" height="1.15942"
        />
        <dataItem name="JE_LINE_NUM" oracleDatatype="number" columnOrder="17"
         width="22" defaultWidth="40000" defaultHeight="10000"
         columnFlags="33" defaultLabel="行号">
          <dataDescriptor expression="JE_LINE_NUM"
           descriptiveExpression="JE_LINE_NUM" order="5" width="22"
           precision="15"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="DESCRIPTION" datatype="vchar2" columnOrder="18"
         width="240" defaultWidth="120000" defaultHeight="10000"
         columnFlags="33" defaultLabel="说明">
          <dataDescriptor expression="DESCRIPTION"
           descriptiveExpression="DESCRIPTION" order="6" width="240"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="ACCOUNTING_FLEXFIELD" datatype="vchar2"
         columnOrder="19" width="311" defaultWidth="200000"
         defaultHeight="10000" columnFlags="33" defaultLabel="账户">
          <dataDescriptor expression="ACCOUNTING_FLEXFIELD"
           descriptiveExpression="ACCOUNTING_FLEXFIELD" order="7" width="311"
          />
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="ENTERED_DR" oracleDatatype="number" columnOrder="20"
         width="22" defaultWidth="60000" defaultHeight="10000"
         columnFlags="33" defaultLabel="借现">
          <dataDescriptor expression="ENTERED_DR"
           descriptiveExpression="ENTERED_DR" order="8" width="22"
           scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="ENTERED_CR" oracleDatatype="number" columnOrder="21"
         width="22" defaultWidth="60000" defaultHeight="10000"
         columnFlags="33" defaultLabel="贷现">
          <dataDescriptor expression="ENTERED_CR"
           descriptiveExpression="ENTERED_CR" order="9" width="22"
           scale="-127"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
      </group>
    </dataSource>
    <summary name="SumENTERED_CRPerReport" source="ENTERED_CR" function="sum"
     width="22" scale="-127" reset="report" compute="report"
     defaultWidth="20000" defaultHeight="10000" columnFlags="552"
     defaultLabel="总计:">
      <displayInfo x="0.00000" y="0.00000" width="0.00000" height="0.00000"/>
    </summary>
    <summary name="SumENTERED_DRPerReport" source="ENTERED_DR" function="sum"
     width="22" scale="-127" reset="report" compute="report"
     defaultWidth="20000" defaultHeight="10000" columnFlags="552"
     defaultLabel="总计:">
      <displayInfo x="0.00000" y="0.00000" width="0.00000" height="0.00000"/>
    </summary>
  </data>
  <layout>
  <section name="main">
    <body>
      <frame name="M_G_BATCH_NAME_GRPFR">
        <geometryInfo x="0.00000" y="0.00000" width="7.25000" height="0.93750"
        />
        <generalLayout verticalElasticity="variable"/>
        <repeatingFrame name="R_G_BATCH_NAME" source="G_BATCH_NAME"
         printDirection="down" minWidowRecords="1" columnMode="no">
          <geometryInfo x="0.00000" y="0.00000" width="7.25000"
           height="0.75000"/>
          <generalLayout verticalElasticity="variable"/>
          <field name="F_BATCH_NAME" source="BATCH_NAME" minWidowLines="1"
           spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="0.31250" y="0.00000" width="1.56250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <frame name="M_G_JE_LINE_NUM_GRPFR">
            <geometryInfo x="0.00000" y="0.18750" width="3.81250"
             height="0.56250"/>
            <generalLayout verticalElasticity="variable"/>
            <repeatingFrame name="R_G_JE_LINE_NUM" source="G_JE_LINE_NUM"
             printDirection="down" minWidowRecords="1" columnMode="no">
              <geometryInfo x="0.00000" y="0.37500" width="3.81250"
               height="0.18750"/>
              <generalLayout verticalElasticity="expand"/>
              <field name="F_JE_LINE_NUM" source="JE_LINE_NUM"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="0.00000" y="0.37500" width="0.31250"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_DESCRIPTION" source="DESCRIPTION"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="0.31250" y="0.37500" width="0.93750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_ACCOUNTING_FLEXFIELD"
               source="ACCOUNTING_FLEXFIELD" minWidowLines="1" spacing="0"
               alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="1.25000" y="0.37500" width="1.56250"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_ENTERED_DR" source="ENTERED_DR" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="2.81250" y="0.37500" width="0.50000"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_ENTERED_CR" source="ENTERED_CR" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="3.31250" y="0.37500" width="0.50000"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
            </repeatingFrame>
            <frame name="M_G_JE_LINE_NUM_FTR">
              <geometryInfo x="0.00000" y="0.56250" width="3.81250"
               height="0.18750"/>
              <advancedLayout printObjectOnPage="lastPage"
               basePrintingOn="anchoringObject"/>
              <field name="F_SumENTERED_DRPerBATCH_NAME"
               source="SumENTERED_DRPerBATCH_NAME" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="2.81250" y="0.56250" width="0.50000"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_SumENTERED_CRPerBATCH_NAME"
               source="SumENTERED_CRPerBATCH_NAME" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="3.31250" y="0.56250" width="0.50000"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <text name="B_总计" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="0.00000" y="0.56250" width="0.37500"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[总计:]]>
                  </string>
                </textSegment>
              </text>
            </frame>
            <frame name="M_G_JE_LINE_NUM_HDR">
              <geometryInfo x="0.00000" y="0.18750" width="3.81250"
               height="0.18750"/>
              <advancedLayout printObjectOnPage="allPage"
               basePrintingOn="enclosingObject"/>
              <text name="B_JE_LINE_NUM" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="0.00000" y="0.18750" width="0.31250"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[行号]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_DESCRIPTION" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="0.31250" y="0.18750" width="0.93750"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[说明]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_ACCOUNTING_FLEXFIELD" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="1.25000" y="0.18750" width="1.56250"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[账户]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_ENTERED_DR" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="2.81250" y="0.18750" width="0.50000"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[借现]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_ENTERED_CR" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="3.31250" y="0.18750" width="0.50000"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[贷现]]>
                  </string>
                </textSegment>
              </text>
            </frame>
          </frame>
          <text name="B_BATCH_NAME" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="0.00000" y="0.00000" width="0.31250"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[批名]]>
              </string>
            </textSegment>
          </text>
          <field name="F_NAME" source="NAME" minWidowLines="1" spacing="0"
           alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="2.50000" y="0.00000" width="1.56250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <text name="B_NAME" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="1.87500" y="0.00000" width="0.62500"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[日记账名]]>
              </string>
            </textSegment>
          </text>
          <field name="F_DEFAULT_EFFECTIVE_DATE"
           source="DEFAULT_EFFECTIVE_DATE" minWidowLines="1" spacing="0"
           alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="4.68750" y="0.00000" width="0.68750"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <text name="B_DEFAULT_EFFECTIVE_DATE" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="4.06250" y="0.00000" width="0.62500"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[记账日期]]>
              </string>
            </textSegment>
          </text>
          <field name="F_PERIOD_NAME" source="PERIOD_NAME" minWidowLines="1"
           spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="5.68750" y="0.00000" width="0.81250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <text name="B_PERIOD_NAME" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="5.37500" y="0.00000" width="0.31250"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[期间]]>
              </string>
            </textSegment>
          </text>
          <field name="F_USER_NAME" source="USER_NAME" minWidowLines="1"
           spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="6.93750" y="0.00000" width="0.31250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <text name="B_USER_NAME" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="6.50000" y="0.00000" width="0.43750"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[制单人]]>
              </string>
            </textSegment>
          </text>
        </repeatingFrame>
        <frame name="M_G_BATCH_NAME_FTR">
          <geometryInfo x="0.00000" y="0.75000" width="7.25000"
           height="0.18750"/>
          <advancedLayout printObjectOnPage="lastPage"
           basePrintingOn="anchoringObject"/>
          <field name="F_SumENTERED_DRPerReport"
           source="SumENTERED_DRPerReport" minWidowLines="1" spacing="0"
           alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="0.37500" y="0.75000" width="0.18750"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
          </field>
          <text name="B_SumENTERED_DRPerReport" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="0.00000" y="0.75000" width="0.37500"
             height="0.18750"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[总计:]]>
              </string>
            </textSegment>
          </text>
          <field name="F_SumENTERED_CRPerReport"
           source="SumENTERED_CRPerReport" minWidowLines="1" spacing="0"
           alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="0.93750" y="0.75000" width="0.18750"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
          </field>
          <text name="B_SumENTERED_CRPerReport" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="0.56250" y="0.75000" width="0.37500"
             height="0.18750"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[总计:]]>
              </string>
            </textSegment>
          </text>
        </frame>
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
<rw:dataArea id="MGBATCHNAMEGRPFR103">
<rw:foreach id="RGBATCHNAME1031" src="G_BATCH_NAME">
<!-- Start GetGroupHeader/n --> <table>
 <caption>  <br>批名 <rw:field id="F_BATCH_NAME" src="BATCH_NAME" breakLevel="RGBATCHNAME1031" breakValue="&nbsp;"> F_BATCH_NAME </rw:field><br>
日记账名 <rw:field id="F_NAME" src="NAME" breakLevel="RGBATCHNAME1031" breakValue="&nbsp;"> F_NAME </rw:field><br>
记账日期 <rw:field id="F_DEFAULT_EFFECTIVE_DATE" src="DEFAULT_EFFECTIVE_DATE" breakLevel="RGBATCHNAME1031" breakValue="&nbsp;"> F_DEFAULT_EFFECTIVE_DATE </rw:field><br>
期间 <rw:field id="F_PERIOD_NAME" src="PERIOD_NAME" breakLevel="RGBATCHNAME1031" breakValue="&nbsp;"> F_PERIOD_NAME </rw:field><br>
制单人 <rw:field id="F_USER_NAME" src="USER_NAME" breakLevel="RGBATCHNAME1031" breakValue="&nbsp;"> F_USER_NAME </rw:field><br>
 </caption>
<!-- End GetGroupHeader/n -->   <tr>
    <td valign="top">
    <table summary="">
     <!-- Header -->
     <thead>
      <tr>
       <th <rw:id id="HBJELINENUM103" asArray="no"/>> 行号 </th>
       <th <rw:id id="HBDESCRIPTION103" asArray="no"/>> 说明 </th>
       <th <rw:id id="HBACCOUNTINGFLEXFIELD103" asArray="no"/>> 账户 </th>
       <th <rw:id id="HBENTEREDDR103" asArray="no"/>> 借现 </th>
       <th <rw:id id="HBENTEREDCR103" asArray="no"/>> 贷现 </th>
      </tr>
     </thead>
     <!-- Body -->
     <tbody>
      <rw:foreach id="RGJELINENUM1031" src="G_JE_LINE_NUM">
       <tr>
        <td <rw:headers id="HFJELINENUM103" src="HBJELINENUM103"/>><rw:field id="FJELINENUM103" src="JE_LINE_NUM" nullValue="&nbsp;"> F_JE_LINE_NUM </rw:field></td>
        <td <rw:headers id="HFDESCRIPTION103" src="HBDESCRIPTION103"/>><rw:field id="FDESCRIPTION103" src="DESCRIPTION" nullValue="&nbsp;"> F_DESCRIPTION </rw:field></td>
        <td <rw:headers id="HFACCOUNTINGFLEXFIELD103" src="HBACCOUNTINGFLEXFIELD103"/>><rw:field id="FACCOUNTINGFLEXFIELD103" src="ACCOUNTING_FLEXFIELD" nullValue="&nbsp;"> F_ACCOUNTING_FLEXFIELD </rw:field></td>
        <td <rw:headers id="HFENTEREDDR103" src="HBENTEREDDR103"/>><rw:field id="FENTEREDDR103" src="ENTERED_DR" nullValue="&nbsp;"> F_ENTERED_DR </rw:field></td>
        <td <rw:headers id="HFENTEREDCR103" src="HBENTEREDCR103"/>><rw:field id="FENTEREDCR103" src="ENTERED_CR" nullValue="&nbsp;"> F_ENTERED_CR </rw:field></td>
       </tr>
      </rw:foreach>
     </tbody>
     <tr>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <td <rw:headers id="HFSumENTEREDDRPerBATCHNAME103" src="HBENTEREDDR103"/>>总计: <rw:field id="FSumENTEREDDRPerBATCHNAME103" src="SumENTERED_DRPerBATCH_NAME" nullValue="&nbsp;"> F_SumENTERED_DRPerBATCH_NAME </rw:field></td>
      <td <rw:headers id="HFSumENTEREDCRPerBATCHNAME103" src="HBENTEREDCR103"/>>总计: <rw:field id="FSumENTEREDCRPerBATCHNAME103" src="SumENTERED_CRPerBATCH_NAME" nullValue="&nbsp;"> F_SumENTERED_CRPerBATCH_NAME </rw:field></td>
     </tr>
     <tr>
     </tr>
    </table>
   </td>
  </tr>
 </table>
</rw:foreach>
<table summary="">
 <tr>
  <th> 总计: <rw:field id="F_SumENTERED_DRPerReport" src="SumENTERED_DRPerReport" nullValue="&nbsp;"> F_SumENTERED_DRPerReport </rw:field></th>
  <th> 总计: <rw:field id="F_SumENTERED_CRPerReport" src="SumENTERED_CRPerReport" nullValue="&nbsp;"> F_SumENTERED_CRPerReport </rw:field></th>
 </tr>
</table>
</rw:dataArea> <!-- id="MGBATCHNAMEGRPFR103" -->
<!-- End of Data Area Generated by Reports Developer -->




</body>
</html>

<!--
</rw:report> 
-->
