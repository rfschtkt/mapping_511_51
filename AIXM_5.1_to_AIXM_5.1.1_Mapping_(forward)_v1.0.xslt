<?xml version="1.0" encoding="UTF-8"?>
<!--====================================================================-->
<!--AIXM 5.1.1-->
<!--www.aixm.aero-->
<!--Released:  June 2015-->
<!--Author: Andrei Ghencea (Trainee EUROCONTROL)-->
<!--====================================================================-->
<!--
		Copyright (c) 2015, EUROCONTROL
		=====================================
		All rights reserved.
		Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
			* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
			* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
			* Neither the names of EUROCONTROL or FAA nor the names of their contributors may be used to endorse or promote products derived from this specification without specific prior written permission.

		THIS SPECIFICATION IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
		==========================================
		Editorial note: this license is an instance of the BSD license template as
		provided by the Open Source Initiative:
		http://www.opensource.org/licenses/bsd-license.php
		==========================================
		Technical note: the scripts have been tested using Saxon Home Edition 9.6.0.5. The transition from Xalan to Saxon was a prerequisite for using a new function implemented with XSLT 2.0 (i.e fn:matches)
		needed for the implementation of the change proposals. For more details and download links please use the following link: http://saxon.sourceforge.net/ .
		==========================================
	-->
<!-- Component: XSLT scripts: forward mapping (AIXM 5.1 to AIXM 5.1.1) -->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:src_aixm="http://www.aixm.aero/schema/5.1"
                xmlns:src_message="http://www.aixm.aero/schema/5.1/message"
                xmlns:aixm="http://www.aixm.aero/schema/5.1.1"
                xmlns:message="http://www.aixm.aero/schema/5.1.1/message">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<!--identity transformation to copy the unchanged nodes-->
<xsl:template match="@*|node()">
	<xsl:copy copy-namespaces="no">
		<xsl:apply-templates select="@*|node()"/>
	</xsl:copy>
</xsl:template>

	<!-- transform aixm namespace URI, attempting to (re)use prefix 'aixm' -->
<xsl:template match="src_aixm:*">
	<xsl:element name="aixm:{local-name()}">
		<xsl:apply-templates select="@*|node()"/>
	</xsl:element>
</xsl:template>

	<!-- transform message namespace URI, attempting to (re)use prefix 'message' -->
<xsl:template match="src_message:*">
	<xsl:element name="message:{local-name()}">
		<xsl:if test="not(ancestor::*)">
			<xsl:copy-of select="namespace::*[not(local-name()=('aixm','message'))]"/>
			<xsl:namespace name="aixm" select="'http://www.aixm.aero/schema/5.1.1'"/>
			<xsl:namespace name="message" select="'http://www.aixm.aero/schema/5.1.1/message'"/>
		</xsl:if>
		<xsl:apply-templates select="@*|node()"/>
	</xsl:element>
</xsl:template>

	<!-- script implementing change proposal AIXM-139 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-139 )-->
<xsl:template match="src_aixm:RulesProcedures//src_aixm:title[text()='HOLDING_ APPROACH_DEPARTURE_PROCEDURES']">
	<xsl:element name="aixm:{local-name()}">
		<xsl:text>HOLDING_APPROACH_DEPARTURE_PROCEDURES</xsl:text>
	</xsl:element>
</xsl:template>

<xsl:template match="
		src_aixm:AircraftStand        //src_aixm:visualDockingSystem[text()=('AGNIS ','AGNIS_STOP ')]|
		src_aixm:VerticalStructurePart/ src_aixm:constructionStatus [text()= 'IN_DEMOLITION '       ]">
	<xsl:element name="aixm:{local-name()}">
		<xsl:value-of select="translate(text(),' ','')"/>
	</xsl:element>
</xsl:template>

	<!--script implementing change proposal AIXM-143 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-143 )-->
	<!--script implementing change proposal AIXM-147 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-147 )-->
	<!--script implementing change proposal AIXM-150 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-150 )-->
<xsl:template match="
		src_aixm:TerminalSegmentPoint  //src_aixm:role             [text()= 'OTHER:LTP'                            ]|
		src_aixm:Navaid                //src_aixm:signalPerformance[text()=('OTHER:IIIA','OTHER:IIIB','OTHER:IIIC')]|
		src_aixm:AircraftCharacteristic//src_aixm:engine           [text()= 'OTHER:ELECTRIC'                       ]">
	<xsl:element name="aixm:{local-name()}">
		<xsl:value-of select="substring-after(text(),'OTHER:')"/>
	</xsl:element>
</xsl:template>

	<!--script implementing change proposal AIXM-158 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-158 )-->
<xsl:template match="src_aixm:StandardLevelTable//src_aixm:name[text()='VFR_RVMS']">
	<xsl:element name="aixm:{local-name()}">
		<xsl:text>VFR_RVSM</xsl:text>
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
