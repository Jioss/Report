<%@ taglib uri="/WEB-INF/lib/reports_tld.jar" prefix="rw" %> 
<%@ page language="java" import="java.io.*" errorPage="/rwerror.jsp" session="false" %>
<%@ page contentType="text/html;charset=ISO-8859-1" %>
<!--
<rw:report id="report"> 
<rw:objects id="objects">
<?xml version="1.0" encoding="GBK" ?>
<report name="CUXGLRDP9510" DTDVersion="9.0.2.0.10">
  <xmlSettings xmlTag="MODULE1" xmlPrologType="text">
  <![CDATA[<?xml version="1.0" encoding="&Encoding"?>]]>
  </xmlSettings>
  <data>
    <userParameter name="P_BATCH_NAME" datatype="character" width="40"
     defaultWidth="0" defaultHeight="0"/>
    <systemParameter name="MODE" initialValue="Default"/>
    <systemParameter name="ORIENTATION" initialValue="Default"/>
    <dataSource name="Q_1">
      <select>
      <![CDATA[SELECT jh.NAME JOURNAL_NAME,
jh.currency_code CURRENCY_CODE,
jl.effective_date EFFECTIVE_DATE,
jl.je_line_num LINE_NUM,
gcc.concatenated_segments SEGMENTS,
jl.entered_dr DR_AMOUNT,
jl.entered_cr CR_AMOUNT,
jl.description DESCRIPTION
FROM gl_je_headers jh,
gl_je_lines jl,
gl_code_combinations_kfv gcc
WHERE jh.je_header_id = jl.je_header_id
AND jl.code_combination_id = gcc.code_combination_id
AND jh.name = :P_BATCH_NAME
ORDER BY jl.je_line_num]]>
      </select>
      <displayInfo x="1.65002" y="1.00000" width="0.69995" height="0.19995"/>
      <group name="G_JOURNAL_NAME">
        <displayInfo x="0.68152" y="1.94995" width="2.63708" height="0.97949"
        />
        <dataItem name="JOURNAL_NAME" datatype="vchar2" columnOrder="12"
         width="100" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Journal Name">
          <dataDescriptor expression="jh.NAME"
           descriptiveExpression="JOURNAL_NAME" order="1" width="100"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="CURRENCY_CODE" datatype="vchar2" columnOrder="13"
         width="15" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Currency Code">
          <dataDescriptor expression="jh.currency_code"
           descriptiveExpression="CURRENCY_CODE" order="2" width="15"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <summary name="SumDR_AMOUNTPerJOURNAL_NAME" source="DR_AMOUNT"
         function="sum" width="22" scale="-127" reset="G_JOURNAL_NAME"
         compute="report" defaultWidth="20000" defaultHeight="10000"
         columnFlags="552" defaultLabel="总计:">
          <displayInfo x="0.00000" y="0.00000" width="0.00000"
           height="0.00000"/>
        </summary>
        <summary name="SumCR_AMOUNTPerJOURNAL_NAME" source="CR_AMOUNT"
         function="sum" width="22" scale="-127" reset="G_JOURNAL_NAME"
         compute="report" defaultWidth="20000" defaultHeight="10000"
         columnFlags="552" defaultLabel="总计:">
          <displayInfo x="0.00000" y="0.00000" width="0.00000"
           height="0.00000"/>
        </summary>
      </group>
      <group name="G_EFFECTIVE_DATE">
        <displayInfo x="1.15759" y="3.67944" width="1.68494" height="1.33936"
        />
        <dataItem name="EFFECTIVE_DATE" datatype="date" oracleDatatype="date"
         columnOrder="14" width="9" defaultWidth="90000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Effective Date">
          <dataDescriptor expression="jl.effective_date"
           descriptiveExpression="EFFECTIVE_DATE" order="3" width="9"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="LINE_NUM" oracleDatatype="number" columnOrder="15"
         width="22" defaultWidth="90000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Line Num">
          <dataDescriptor expression="jl.je_line_num"
           descriptiveExpression="LINE_NUM" order="4" width="22"
           precision="15"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="SEGMENTS" datatype="vchar2" columnOrder="16"
         width="311" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Segments">
          <dataDescriptor expression="gcc.concatenated_segments"
           descriptiveExpression="SEGMENTS" order="5" width="311"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="DR_AMOUNT" oracleDatatype="number" columnOrder="17"
         width="22" defaultWidth="20000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Dr Amount">
          <dataDescriptor expression="jl.entered_dr"
           descriptiveExpression="DR_AMOUNT" order="6" width="22" scale="-127"
          />
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="CR_AMOUNT" oracleDatatype="number" columnOrder="18"
         width="22" defaultWidth="20000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Cr Amount">
          <dataDescriptor expression="jl.entered_cr"
           descriptiveExpression="CR_AMOUNT" order="7" width="22" scale="-127"
          />
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
        <dataItem name="DESCRIPTION" datatype="vchar2" columnOrder="19"
         width="240" defaultWidth="100000" defaultHeight="10000"
         columnFlags="33" defaultLabel="Description">
          <dataDescriptor expression="jl.description"
           descriptiveExpression="DESCRIPTION" order="8" width="240"/>
          <dataItemPrivate adtName="" schemaName=""/>
        </dataItem>
      </group>
    </dataSource>
    <summary name="SumCR_AMOUNTPerReport" source="CR_AMOUNT" function="sum"
     width="22" scale="-127" reset="report" compute="report"
     defaultWidth="20000" defaultHeight="10000" columnFlags="552"
     defaultLabel="总计:">
      <displayInfo x="0.00000" y="0.00000" width="0.00000" height="0.00000"/>
    </summary>
    <summary name="SumDR_AMOUNTPerReport" source="DR_AMOUNT" function="sum"
     width="22" scale="-127" reset="report" compute="report"
     defaultWidth="20000" defaultHeight="10000" columnFlags="552"
     defaultLabel="总计:">
      <displayInfo x="0.00000" y="0.00000" width="0.00000" height="0.00000"/>
    </summary>
  </data>
  <layout>
  <section name="main">
    <body>
      <frame name="M_G_JOURNAL_NAME_GRPFR">
        <geometryInfo x="0.00000" y="0.00000" width="4.81250" height="0.93750"
        />
        <generalLayout verticalElasticity="variable"/>
        <repeatingFrame name="R_G_JOURNAL_NAME" source="G_JOURNAL_NAME"
         printDirection="down" minWidowRecords="1" columnMode="no">
          <geometryInfo x="0.00000" y="0.00000" width="4.81250"
           height="0.75000"/>
          <generalLayout verticalElasticity="variable"/>
          <field name="F_JOURNAL_NAME" source="JOURNAL_NAME" minWidowLines="1"
           spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="0.93750" y="0.00000" width="0.81250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <frame name="M_G_EFFECTIVE_DATE_GRPFR">
            <geometryInfo x="0.00000" y="0.18750" width="4.81250"
             height="0.56250"/>
            <generalLayout verticalElasticity="variable"/>
            <repeatingFrame name="R_G_EFFECTIVE_DATE"
             source="G_EFFECTIVE_DATE" printDirection="down"
             minWidowRecords="1" columnMode="no">
              <geometryInfo x="0.00000" y="0.37500" width="4.81250"
               height="0.18750"/>
              <generalLayout verticalElasticity="expand"/>
              <field name="F_EFFECTIVE_DATE" source="EFFECTIVE_DATE"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="0.00000" y="0.37500" width="1.06250"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_LINE_NUM" source="LINE_NUM" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="1.06250" y="0.37500" width="0.68750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_SEGMENTS" source="SEGMENTS" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="1.75000" y="0.37500" width="0.81250"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_DR_AMOUNT" source="DR_AMOUNT" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="2.56250" y="0.37500" width="0.68750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_CR_AMOUNT" source="CR_AMOUNT" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="3.25000" y="0.37500" width="0.68750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_DESCRIPTION" source="DESCRIPTION"
               minWidowLines="1" spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="3.93750" y="0.37500" width="0.87500"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
            </repeatingFrame>
            <frame name="M_G_EFFECTIVE_DATE_FTR">
              <geometryInfo x="0.00000" y="0.56250" width="4.81250"
               height="0.18750"/>
              <advancedLayout printObjectOnPage="lastPage"
               basePrintingOn="anchoringObject"/>
              <field name="F_SumDR_AMOUNTPerJOURNAL_NAME"
               source="SumDR_AMOUNTPerJOURNAL_NAME" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="2.56250" y="0.56250" width="0.68750"
                 height="0.18750"/>
                <generalLayout verticalElasticity="expand"/>
              </field>
              <field name="F_SumCR_AMOUNTPerJOURNAL_NAME"
               source="SumCR_AMOUNTPerJOURNAL_NAME" minWidowLines="1"
               spacing="0" alignment="start">
                <font face="Courier New" size="10"/>
                <geometryInfo x="3.25000" y="0.56250" width="0.68750"
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
            <frame name="M_G_EFFECTIVE_DATE_HDR">
              <geometryInfo x="0.00000" y="0.18750" width="4.81250"
               height="0.18750"/>
              <advancedLayout printObjectOnPage="allPage"
               basePrintingOn="enclosingObject"/>
              <text name="B_EFFECTIVE_DATE" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="0.00000" y="0.18750" width="1.06250"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Effective Date]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_LINE_NUM" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="1.06250" y="0.18750" width="0.68750"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Line Num]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_SEGMENTS" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="1.75000" y="0.18750" width="0.81250"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Segments]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_DR_AMOUNT" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="2.56250" y="0.18750" width="0.68750"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Dr Amount]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_CR_AMOUNT" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="3.25000" y="0.18750" width="0.68750"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Cr Amount]]>
                  </string>
                </textSegment>
              </text>
              <text name="B_DESCRIPTION" minWidowLines="1">
                <textSettings spacing="0"/>
                <geometryInfo x="3.93750" y="0.18750" width="0.87500"
                 height="0.18750"/>
                <textSegment>
                  <font face="Courier New" size="10"/>
                  <string>
                  <![CDATA[Description]]>
                  </string>
                </textSegment>
              </text>
            </frame>
          </frame>
          <text name="B_JOURNAL_NAME" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="0.00000" y="0.00000" width="0.93750"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[Journal Name]]>
              </string>
            </textSegment>
          </text>
          <field name="F_CURRENCY_CODE" source="CURRENCY_CODE"
           minWidowLines="1" spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="2.75000" y="0.00000" width="0.81250"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
          </field>
          <text name="B_CURRENCY_CODE" minWidowLines="1">
            <textSettings spacing="0"/>
            <geometryInfo x="1.75000" y="0.00000" width="1.00000"
             height="0.18750"/>
            <advancedLayout printObjectOnPage="allPage"
             basePrintingOn="enclosingObject"/>
            <textSegment>
              <font face="Courier New" size="10"/>
              <string>
              <![CDATA[Currency Code]]>
              </string>
            </textSegment>
          </text>
        </repeatingFrame>
        <frame name="M_G_JOURNAL_NAME_FTR">
          <geometryInfo x="0.00000" y="0.75000" width="4.81250"
           height="0.18750"/>
          <advancedLayout printObjectOnPage="lastPage"
           basePrintingOn="anchoringObject"/>
          <field name="F_SumDR_AMOUNTPerReport" source="SumDR_AMOUNTPerReport"
           minWidowLines="1" spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="0.37500" y="0.75000" width="0.18750"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
          </field>
          <text name="B_SumDR_AMOUNTPerReport" minWidowLines="1">
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
          <field name="F_SumCR_AMOUNTPerReport" source="SumCR_AMOUNTPerReport"
           minWidowLines="1" spacing="0" alignment="start">
            <font face="Courier New" size="10"/>
            <geometryInfo x="0.93750" y="0.75000" width="0.18750"
             height="0.18750"/>
            <generalLayout verticalElasticity="expand"/>
          </field>
          <text name="B_SumCR_AMOUNTPerReport" minWidowLines="1">
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
<rw:dataArea id="MGJOURNALNAMEGRPFR102">
<rw:foreach id="RGJOURNALNAME1021" src="G_JOURNAL_NAME">
<!-- Start GetGroupHeader/n --> <table>
 <caption>  <br>Journal Name <rw:field id="F_JOURNAL_NAME" src="JOURNAL_NAME" breakLevel="RGJOURNALNAME1021" breakValue="&nbsp;"> F_JOURNAL_NAME </rw:field><br>
Currency Code <rw:field id="F_CURRENCY_CODE" src="CURRENCY_CODE" breakLevel="RGJOURNALNAME1021" breakValue="&nbsp;"> F_CURRENCY_CODE </rw:field><br>
 </caption>
<!-- End GetGroupHeader/n -->   <tr>
    <td valign="top">
    <table summary="">
     <!-- Header -->
     <thead>
      <tr>
       <th <rw:id id="HBEFFECTIVEDATE102" asArray="no"/>> Effective Date </th>
       <th <rw:id id="HBLINENUM102" asArray="no"/>> Line Num </th>
       <th <rw:id id="HBSEGMENTS102" asArray="no"/>> Segments </th>
       <th <rw:id id="HBDRAMOUNT102" asArray="no"/>> Dr Amount </th>
       <th <rw:id id="HBCRAMOUNT102" asArray="no"/>> Cr Amount </th>
       <th <rw:id id="HBDESCRIPTION102" asArray="no"/>> Description </th>
      </tr>
     </thead>
     <!-- Body -->
     <tbody>
      <rw:foreach id="RGEFFECTIVEDATE1021" src="G_EFFECTIVE_DATE">
       <tr>
        <td <rw:headers id="HFEFFECTIVEDATE102" src="HBEFFECTIVEDATE102"/>><rw:field id="FEFFECTIVEDATE102" src="EFFECTIVE_DATE" nullValue="&nbsp;"> F_EFFECTIVE_DATE </rw:field></td>
        <td <rw:headers id="HFLINENUM102" src="HBLINENUM102"/>><rw:field id="FLINENUM102" src="LINE_NUM" nullValue="&nbsp;"> F_LINE_NUM </rw:field></td>
        <td <rw:headers id="HFSEGMENTS102" src="HBSEGMENTS102"/>><rw:field id="FSEGMENTS102" src="SEGMENTS" nullValue="&nbsp;"> F_SEGMENTS </rw:field></td>
        <td <rw:headers id="HFDRAMOUNT102" src="HBDRAMOUNT102"/>><rw:field id="FDRAMOUNT102" src="DR_AMOUNT" nullValue="&nbsp;"> F_DR_AMOUNT </rw:field></td>
        <td <rw:headers id="HFCRAMOUNT102" src="HBCRAMOUNT102"/>><rw:field id="FCRAMOUNT102" src="CR_AMOUNT" nullValue="&nbsp;"> F_CR_AMOUNT </rw:field></td>
        <td <rw:headers id="HFDESCRIPTION102" src="HBDESCRIPTION102"/>><rw:field id="FDESCRIPTION102" src="DESCRIPTION" nullValue="&nbsp;"> F_DESCRIPTION </rw:field></td>
       </tr>
      </rw:foreach>
     </tbody>
     <tr>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <th> &nbsp; </th>
      <td <rw:headers id="HFSumDRAMOUNTPerJOURNALNAME102" src="HBDRAMOUNT102"/>>总计: <rw:field id="FSumDRAMOUNTPerJOURNALNAME102" src="SumDR_AMOUNTPerJOURNAL_NAME" nullValue="&nbsp;"> F_SumDR_AMOUNTPerJOURNAL_NAME </rw:field></td>
      <td <rw:headers id="HFSumCRAMOUNTPerJOURNALNAME102" src="HBCRAMOUNT102"/>>总计: <rw:field id="FSumCRAMOUNTPerJOURNALNAME102" src="SumCR_AMOUNTPerJOURNAL_NAME" nullValue="&nbsp;"> F_SumCR_AMOUNTPerJOURNAL_NAME </rw:field></td>
      <th> &nbsp; </th>
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
  <th> 总计: <rw:field id="F_SumDR_AMOUNTPerReport" src="SumDR_AMOUNTPerReport" nullValue="&nbsp;"> F_SumDR_AMOUNTPerReport </rw:field></th>
  <th> 总计: <rw:field id="F_SumCR_AMOUNTPerReport" src="SumCR_AMOUNTPerReport" nullValue="&nbsp;"> F_SumCR_AMOUNTPerReport </rw:field></th>
 </tr>
</table>
</rw:dataArea> <!-- id="MGJOURNALNAMEGRPFR102" -->
<!-- End of Data Area Generated by Reports Developer -->




</body>
</html>

<!--
</rw:report> 
-->
