<!DOCTYPE webpage [
<!ENTITY orgName "Discmark Data Supplies">
]>

<xsl:transform
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 version="1.0"
 xmlns:saxon="http://icl.com/saxon"
 exclude-result-prefixes="saxon"
>
<xsl:template match="/">
<xsl:text disable-output-escaping="yes" >
<![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">]]>
</xsl:text>

<html>
<head>
<xsl:text disable-output-escaping="yes" >
<![CDATA[
<meta name="keywords" content="web design, web hosting, network security, data integrity, bespoke application development, pc repair, pc training">
]]>
</xsl:text>
<title>&orgName;<xsl:value-of select="page/@subtitle" /></title>
<style type="text/css">
BODY { font-family:verdana,helvetica,arial,sans-serif; }
TD { bgcolor:#888888; color:#ffff66; font-size:10pt }
A:link { color:#99ffff;text-decoration:none; }
A:active { color:#99ffff;text-decoration:underline; }
A:hover { color:#ffffff;text-decoration:underline; }
A:visited { color:#cccccc;text-decoration:none; }
P { color:#cccccc; font-size:10pt; margin-top:1pt; margin-bottom:1pt; }
H4 { margin-bottom:3pt; color:yellow; }
H3 { margin-bottom:3pt; color:yellow; }
</style>
<script language="javaScript" type="text/ecmascript">
function setVariables(){
    if (navigator.appName == "Netscape") {
        v=".top=";dS="document.";sD="";y="window.pageYOffset" }
    else {v=".pixelTop=";dS="";sD=".style";y="document.body.scrollTop"}}
    function checkLocation(){
        object="object1";yy=eval(y);eval(dS+object+sD+v+yy);setTimeout("checkLocation()",10)
    }
</script>
</head>

<body bgcolor="#000000">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <!-- top row -->
    <tr>
        <td valign="top" bgcolor="#888888">
            <table border="0" cellspacing="0" cellpadding="0"
            width="15">
                <tr>
                    <td width="15" valign="top"><img
                    src="./topleft.gif" border="0" height="15"
                    width="15" hspace="0" vspace="0" alt="" /></td>
                </tr>
            </table>
        </td>
        <td bgcolor="#888888" width="100%"></td>
        <td valign="top" bgcolor="#888888">
            <table border="0" cellspacing="0" cellpadding="0"
            width="15">
                <tr>
                    <td width="15" valign="top"><img
                    src="./topright.gif" border="0" height="15"
                    width="15" hspace="0" vspace="0" alt="" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- top row -->

    <!-- middle row -->
    <tr>
        <td valign="top" bgcolor="#888888" width="15"></td>
        <td bgcolor="#dddddd" width="100%"><center><img
        src="./discmark_banner.jpg" alt="Discmark Data Supplies Ltd" /></center><p align="right"><font
        size="-1" color="blue">We mean business, do <em>you?</em></font></p></td>
        <td valign="top" bgcolor="#888888" width="15"></td>
    </tr>
    <!-- middle row -->

    <!-- bottom row -->
    <tr>
        <td valign="top" bgcolor="#888888">
            <table border="0" cellspacing="0" cellpadding="0"
            width="15">
                <tr>
                    <td width="15" valign="top"><img
                    src="./bottomleft.gif" border="0" height="15"
                    width="15" hspace="0" vspace="0" alt="" /></td>
                </tr>
            </table>
        </td>
        <td bgcolor="#888888" width="100%"></td>
        <td valign="top" bgcolor="#888888">
            <table border="0" cellspacing="0" cellpadding="0"
            width="15">
                <tr>
                    <td width="15" valign="top"><img
                    src="./bottomright.gif" border="0" height="15"
                    width="15" hspace="0" vspace="0" alt="" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- bottom row -->
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <!-- main body of page -->
    <tr>
        <td valign="top" bgcolor="#000000">
            <!-- table for menu -->
            <table border="0" cellspacing="0" cellpadding="0"
            width="100%">
                <tr>
                    <td width="100" align="center" valign="top">
<div class="P" id="object1" style="position:relative; visibility:show; z-index:2">
<table border="0" width="100">
<tr><td height="30" /></tr>
<!-- this is where we will put the menu options -->
<xsl:for-each select="page/menuoption">
<tr>
<td align="center">
<xsl:element name="a">
<xsl:attribute name="href">
<xsl:value-of select="@href" />
</xsl:attribute>
<xsl:value-of select="@caption" />
</xsl:element>
<hr/>
</td>
</tr>
</xsl:for-each>
<!-- this is where we will put the menu options -->
</table>
</div>
</td>
                    <!-- have a margin between the menu and the body text -->
                    <td width="10"><xsl:text> </xsl:text></td>
                    <!-- have a margin between the menu and the body text -->

                    <td>
                    <layer>
                       <div style="position:relative; z-index:1; top:0;" align="left">
                          <img src="./background_keyboard.jpg" alt="" />
                       </div>
                       <div style="position:relative; z-index:2; top:-400; left:0;">
                          <xsl:for-each select="page/bodytext">
                          <h3><xsl:value-of select="bodytextheading" /></h3>
                          <xsl:for-each select="bodytextpara">
                          <h4><xsl:value-of select="paraheading" /></h4>
                          <xsl:apply-templates select="paratext" />
                          </xsl:for-each>
                          </xsl:for-each>
                       </div>
                    </layer>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- main body of page -->
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <!-- trailer row -->
    <tr>
        <td colspan="3" valign="top" bgcolor="#000000" align="center">
        <br/>
        <hr width="300"/>
        <font size="1" color="lightblue">(c) Discmark Data Supplies Ltd 2002</font>
        </td>
    </tr>
    <!-- trailer row -->
</table>
</body>
</html>
</xsl:template>

<!-- paratext template -->
<xsl:template match="paratext">
<p>
<xsl:apply-templates/>
</p>
</xsl:template>

<!-- default template -->
<xsl:template match="*">
<xsl:copy>
<xsl:copy-of select="@*"/>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>

</xsl:transform>
