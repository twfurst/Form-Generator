<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE stylesheet [
<!ENTITY ohm  "&#x2126;" ><!-- small n, tilde -->
]>
<xsl:stylesheet version="2.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="rootDir"/>
	<xsl:include href="descriptTom_TEST.xsl"/>
	<xsl:include href="procedTom.xsl"/>
	<!--<xsl:include href="ipdTom.xsl"/>-->
	<xsl:key name="mainProced" match="content/procedure/mainProcedure" use="generate-id(.)"/>
	<xsl:key name="isoSteps" match="isolationStep | isolationProcedureEnd" use="@id"/>
	<xsl:key name="procSteps" match="proceduralStep" use="@id"/>
	<xsl:key name="refsDmRef" match="//content//dmRef/dmRefIdent/dmCode"
		use="concat(@modelIdentCode,'-',@systemDiffCode, '-', @systemCode, '-',@subSystemCode,@subSubSystemCode,'-',@assyCode,'-',@disassyCode,@disassyCodeVariant,'-',@infoCode,@infoCodeVariant,'-',@itemLocationCode)"/>
	<xsl:key name="refsExtPubref" match="//content//externalPubRef/externalPubRefIdent" use="concat(externalPubCode, ';', externalPubTitle)"/>
	<xsl:template match="/">
		<fo:root font-family="Helvetica" hyphenate="true" language="en"><!--hyphenate="true" language="en"-->
			<!-- -->
			<fo:layout-master-set>
				<!-- Page master for all except last page -->
				<fo:simple-page-master page-height="279.4mm" page-width="215.9mm" master-name="page"
					margin-top="11mm" margin-bottom="12mm" margin-right="15mm" margin-left="25mm">
					<fo:region-body region-name="xsl-region-body" margin-top="15mm"
						margin-bottom="22mm" margin-left="0mm" margin-right="0mm"/>
					<fo:region-before region-name="xsl-region-before" extent="17mm"/>
					<fo:region-after region-name="xsl-region-after" extent="17mm"/>
				</fo:simple-page-master>

				<!-- Page master for last pages -->
				<fo:simple-page-master page-height="279.4mm" page-width="215.9mm"
					master-name="page-last" margin-top="11mm" margin-bottom="12mm"
					margin-right="15mm" margin-left="25mm">
					<fo:region-body region-name="xsl-region-body" margin-top="15mm"
						margin-bottom="22mm" margin-left="0mm" margin-right="0mm"/>

					<fo:region-before region-name="xsl-region-before" extent="17mm"/>
					<fo:region-after region-name="xsl-region-after-last" extent="17mm"/>
				</fo:simple-page-master>

				<fo:page-sequence-master master-name="pages">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference master-reference="page"
							page-position="first"/>
						<fo:conditional-page-master-reference master-reference="page"
							page-position="rest"/>
						<fo:conditional-page-master-reference master-reference="page-last"
							page-position="last"/>
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>

			</fo:layout-master-set>
			<!--bookmark tree begins here-->
			<fo:bookmark-tree>
				<fo:bookmark internal-destination="docTitle">
					<fo:bookmark-title>
						<xsl:value-of select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/dmTitle/techName"/>
					</fo:bookmark-title>
					<fo:bookmark internal-destination="TOC">
						<fo:bookmark-title>Table of Contents</fo:bookmark-title>
					</fo:bookmark>
					<fo:bookmark internal-destination="listOfTabs">
						<fo:bookmark-title>List of Tables</fo:bookmark-title>
					</fo:bookmark>
					<fo:bookmark internal-destination="listOfFigs">
						<fo:bookmark-title>List of Figures</fo:bookmark-title>
					</fo:bookmark>
					<xsl:for-each select="//content/description/levelledPara">
						<xsl:variable name="bmID" select="@id"/>
						<fo:bookmark internal-destination="{$bmID}">
							<fo:bookmark-title>
								<xsl:value-of select="./title"/>
							</fo:bookmark-title>
							<xsl:if test="./levelledPara">
								<xsl:for-each select="./levelledPara">
									<xsl:variable name="PId2" select="@id"/>
									<fo:bookmark internal-destination="{$PId2}">
										<fo:bookmark-title>
											<xsl:value-of select="./title"/>
										</fo:bookmark-title>
										<xsl:if test="./levelledPara">
											<xsl:for-each select="./levelledPara">
												<xsl:variable name="PId3" select="@id"/>
												<fo:bookmark internal-destination="{$PId3}">
													<fo:bookmark-title>
														<xsl:value-of select="./title"/>
													</fo:bookmark-title>
													<xsl:if test="./levelledPara">
														<xsl:for-each select="./levelledPara">
															<xsl:variable name="PId4" select="@id"/>
															<fo:bookmark internal-destination="{$PId4}">
																<fo:bookmark-title>
																	<xsl:value-of select="./title"/>
																</fo:bookmark-title>
															</fo:bookmark>
														</xsl:for-each>
													</xsl:if>
												</fo:bookmark>
											</xsl:for-each>
										</xsl:if>
									</fo:bookmark>
								</xsl:for-each>
							</xsl:if>
						</fo:bookmark>
					</xsl:for-each>
				</fo:bookmark>
			</fo:bookmark-tree>


			<!-- Page sequences -->
			<fo:page-sequence master-reference="pages">
				<!--Left margin area-->
				<!--Header content, add L85 Logo here, store image as resource in app with XSL, and push to temp when needed-->
				<fo:static-content flow-name="xsl-region-before">
					<fo:block>
						<fo:table table-layout="fixed" width="100%">
							<fo:table-column column-number="1" column-width="33%"/>
							<fo:table-column column-number="2" column-width="34%"/>
							<fo:table-column column-number="3" column-width="33%"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell>
										<fo:block>
											<fo:external-graphic src="logo2.jpg"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-size="9pt" font-weight="bold"
											text-align="center">
											<xsl:choose>
												<xsl:when
												test="dmodule/identAndStatusSection/dmStatus/security/@securityClassification = '01'"
												> UNCLASSIFIED </xsl:when>
											</xsl:choose>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell text-align="end">
										<fo:block display-align="after">
											<!-- <fo:external-graphic display-align="after" height="25mm" src="url('Image/smallogo.gif')"/> -->
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
					<fo:block>
						<fo:leader leader-length="100%" leader-pattern="rule" rule-style="solid"
							color="black"/>
						<!--rule-thickness=".2mm"-->
					</fo:block>
				</fo:static-content>
				<!--Footer content, will include DMC, and issue date when pulling from full data module, not snippet-->
				<fo:static-content flow-name="xsl-region-after">
					<fo:block space-before="2mm">
						<fo:leader leader-length="100%" leader-pattern="rule" rule-style="solid"
							color="black"/>
					</fo:block>
					<fo:block>
						<fo:table table-layout="fixed" width="100%">
							<fo:table-column column-number="1" column-width="33%"/>
							<fo:table-column column-number="2" column-width="34%"/>
							<fo:table-column column-number="3" column-width="33%"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="bold" font-size="9pt"
											text-align="left">
											<xsl:value-of
												select="concat('Applicable to: ', dmodule/identAndStatusSection/dmStatus/applic/displayText/simplePara)"
											/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold" font-size="9pt"
											text-align="right">
											<xsl:value-of
												select="concat(dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@systemCode,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@subSystemCode,dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@subSubSystemCode,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@assyCode,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@disassyCode,dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@disassyCodeVariant,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@infoCode,dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@infoCodeVariant,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@itemLocationCode)"
											/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
									<fo:table-cell>
										<xsl:choose>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '01'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Jan <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '02'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Feb <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '03'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Mar <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '04'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Apr <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '05'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">May <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '06'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Jun <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '07'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Jul <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '08'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Aug <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '09'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Sep <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '10'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Oct <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '11'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Nov <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:otherwise>
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Dec <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:otherwise>
										</xsl:choose>
										<!--<fo:block font-size="8pt" text-align="right">Page <fo:page-number/></fo:block>-->
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</fo:static-content>

				<fo:static-content flow-name="xsl-region-after-last">
					<fo:block space-before="2mm">
						<fo:leader leader-length="100%" leader-pattern="rule" rule-style="solid"
							color="black"/>
					</fo:block>
					<fo:block>
						<fo:table table-layout="fixed" width="100%">
							<fo:table-column column-number="1" column-width="33%"/>
							<fo:table-column column-number="2" column-width="34%"/>
							<fo:table-column column-number="3" column-width="33%"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="bold" font-size="9pt"
											text-align="left">
											<xsl:value-of
												select="concat('Applicable to: ', dmodule/identAndStatusSection/dmStatus/applic/assert)"
											/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold" font-size="9pt"
											text-align="right">
											<xsl:value-of
												select="concat(dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@systemCode,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@subSystemCode,dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@subSubSystemCode,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@assyCode,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@disassyCode,dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@disassyCodeVariant,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@infoCode,dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@infoCodeVariant,'-',dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@itemLocationCode)"
											/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-size="9pt" font-weight="bold"
											text-align="center">End of data module</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<xsl:choose>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '01'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Jan <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '02'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Feb <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '03'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Mar <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '04'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Apr <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '05'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">May <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '06'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Jun <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '07'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Jul <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '08'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Aug <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '09'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Sep <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '10'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Oct <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:when
												test="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@month = '11'">
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Nov <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:when>
											<xsl:otherwise>
												<fo:block font-weight="bold" font-size="9pt"
												text-align="right">Dec <xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@day"
												/>/<xsl:value-of
												select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/issueDate/@year"
												/> Page <fo:page-number/>
												</fo:block>
											</xsl:otherwise>
										</xsl:choose>
										<!--<fo:block font-size="8pt" text-align="right">Page <fo:page-number/></fo:block>-->
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</fo:static-content>

				<fo:flow flow-name="xsl-region-body">
					<!--</fo:block>-->
					<fo:block space-before="8mm" space-after="2mm" text-align="center" font-size="14pt" font-weight="bold" font-style="italic" id="docTitle">
						<xsl:value-of select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/dmTitle/techName"/>
					</fo:block>
					<fo:block space-after="4mm" text-align="center" font-size="10pt" font-weight="bold" font-style="italic" id="docIname">
						<xsl:value-of select="dmodule/identAndStatusSection/dmAddress/dmAddressItems/dmTitle/infoName"/>
					</fo:block>
					<xsl:if test="not(dmodule/identAndStatusSection/dmAddress/dmIdent/dmCode/@infoCode = '941')">
						<fo:block space-before="4mm" space-after="4mm" id="TOC">
							<xsl:call-template name="buildTOC2"/>
						</fo:block>
						<!--<xsl:if test="//content/faultReporting">
							<fo:block space-before="4mm" space-after="4mm">
							<xsl:call-template name="listOfTables"/>
							</fo:block>
							</xsl:if>-->
						<xsl:if test="//content//table">
							<fo:block>
								<xsl:call-template name="listOfTables"/>
							</fo:block>
						</xsl:if>
						<xsl:if test="//content//figure">
							<fo:block>
								<xsl:call-template name="listFigs"/>
							</fo:block>
						</xsl:if>
						<xsl:if test="//content//dmRef or(//content//externalPubRef)">
							<fo:block>
								<xsl:call-template name="buildRefs"/>
							</fo:block>
						</xsl:if>
					</xsl:if>
					
					<fo:block>
						<xsl:apply-templates/>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	
	<xsl:template match="content/description">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="mainProcedure">
		<fo:block id="{generate-id(.)}" keep-with-next="always" text-align="center" font-size="14pt" font-weight="bold" font-style="italic" padding-bottom="8pt">Procedure</fo:block>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="refs"></xsl:template>
	
	<xsl:template name="listFigs">
		<fo:block id="listOfFigs" font-size="12pt" font-weight="bold" text-align="left"
			space-before="5mm" space-after="2mm" keep-with-next="always">List of Figures</fo:block>
		<fo:table table-layout="fixed" width="100%">
			<fo:table-column column-width="5%"/>
			<fo:table-column column-width="85%"/>
			<fo:table-column column-width="10%"/>
			<fo:table-header>
				<!-- <fo:table-row>
					<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid"
						border-top-color="black" border-bottom-style="solid"
						border-bottom-color="black" border-collapse="collapse">
						<fo:block font-size="11pt">No.</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid"
						border-top-color="black" border-bottom-style="solid"
						border-bottom-color="black" border-collapse="collapse">
						<fo:block font-size="11pt">Figure title</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid"
						border-top-color="black" border-bottom-style="solid"
						border-bottom-color="black" border-collapse="collapse">
						<fo:block font-size="11pt" text-align="right">Page</fo:block>
					</fo:table-cell>
				</fo:table-row> -->
				<fo:table-row>
					<fo:table-cell padding-top="1pt">
						<fo:block font-weight="bold" font-size="10pt">No.</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="1pt">
						<fo:block font-weight="bold"  font-size="10pt">Figure title</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="1pt">
						<fo:block font-weight="bold"  font-size="10pt" text-align="right">Page</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<fo:table-footer>
				<!-- <fo:table-row>
					<fo:table-cell border-top-style="solid" border-top-color="black"
						border-collapse="collapse">
						<fo:block/>
					</fo:table-cell>
					<fo:table-cell border-top-style="solid" border-top-color="black"
						border-collapse="collapse">
						<fo:block/>
					</fo:table-cell>
					<fo:table-cell border-top-style="solid" border-top-color="black"
						border-collapse="collapse">
						<fo:block/>
					</fo:table-cell>
				</fo:table-row> -->
				<fo:table-row>
					<fo:table-cell>
						<fo:block/>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block/>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block/>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-footer>
			<fo:table-body>
				<xsl:for-each select="//content//figure">
				<xsl:variable name="figCount" >
					<xsl:number count="figure" level="any" format="1"/>
				</xsl:variable>
				<xsl:variable name="figC" select="@id"/>
				<xsl:variable name="fCount" select="concat('F', $figCount)"/>
					<fo:table-row>
						<fo:table-cell padding-top="4pt" padding-bottom="2pt">
							<fo:block text-align="left" font-size="10pt">
								<!-- <xsl:choose> -->
									<!-- F0001 -->
									<!-- 12345 -->
									<!-- <xsl:when
										test="substring(@id,3,1) = '0' and substring(@id,4,1) = '0'">
										<xsl:value-of select="substring(@id,5)"/>
									</xsl:when>
									<xsl:when
										test="substring(@id,2,1) = '0' and substring(@id,3,1) = '0' and substring(@id,4,1) &gt; '0'">
										<xsl:value-of select="substring(@id,4)"/>
									</xsl:when>
									<xsl:when
										test="substring(@id,2,1) = '0' and substring(@id,3,1) &gt; '0'">
										<xsl:value-of select="substring(@id,3)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="substring(@id,2)"/>
									</xsl:otherwise>
								</xsl:choose> -->
								<xsl:value-of select="$figCount"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="4pt" padding-bottom="2pt"
							number-columns-spanned="2">
							<fo:block text-align-last="justify" font-size="10pt">
								<fo:basic-link internal-destination="{$figC}">
									<xsl:value-of select="./title"/>
									<fo:leader leader-pattern="dots"/>
									<fo:page-number-citation ref-id="{@id}"/>
								</fo:basic-link>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:for-each>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<xsl:template name="listOfTables">
		<fo:block id="listOfTabs" font-size="12pt" font-weight="bold" text-align="left"
			space-before="5mm" space-after="2mm" keep-with-next="always">List of Tables</fo:block>
		<fo:table table-layout="fixed" width="100%">
			<fo:table-column column-width="5%"/>
			<fo:table-column column-width="85%"/>
			<fo:table-column column-width="10%"/>
			<fo:table-header>
				<fo:table-row>
					<fo:table-cell padding-top="1pt" padding-bottom="1pt">
						<fo:block font-weight="bold" font-size="10pt">No.</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="1pt" padding-bottom="1pt">
						<fo:block font-weight="bold" font-size="10pt">Table title</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="1pt" padding-bottom="1pt">
						<fo:block font-weight="bold" font-size="10pt" text-align="right">Page</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<fo:table-footer>
				<fo:table-row>
					<fo:table-cell>
						<fo:block/>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block/>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block/>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-footer>
			<fo:table-body>
				<xsl:for-each select="//content//table">
				<xsl:variable name="tabCount" >
					<xsl:number count="table" level="any" format="1"/>
				</xsl:variable>
				<xsl:variable name="tabC" select="@id"/>
				<xsl:variable name="tCount" select="concat('T', $tabCount)"/>
					<fo:table-row>
						<fo:table-cell padding-top="4pt" padding-bottom="2pt">
							<fo:block text-align="left" font-size="10pt">
								<xsl:value-of select="$tabCount"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="4pt" padding-bottom="2pt"
							number-columns-spanned="2">
							<fo:block text-align-last="justify" font-size="10pt">
								<fo:basic-link internal-destination="{$tabC}">
									<xsl:value-of select="./title"/>
									<fo:leader leader-pattern="dots"/>
									<fo:page-number-citation ref-id="{@id}"/>
								</fo:basic-link>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:for-each>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<xsl:template match="figure">
		<xsl:variable name="figCount" >
			<xsl:number count="figure" level="any" format="1"/>
		</xsl:variable>
		<fo:block id="{@id}">
			<xsl:for-each select="./graphic">
				<xsl:variable name="grph" select="concat('file:/',$rootDir,unparsed-entity-uri(@infoEntityIdent))"/>
				<xsl:choose>
					<xsl:when test="name(../..) = 'levelledPara' or name(../..) = 'proceduralStep'">
						<fo:block>
							<fo:external-graphic display-align="center" content-height="scale-to-fit" content-width="150mm" src="url('{$grph}')"/>
						</fo:block>
						<xsl:if test="count(../graphic) &gt; 1">
							<fo:block text-align="center" keep-with-previous="always" space-after="2pt">
								<fo:inline font-style="italic">Figure <xsl:value-of select="$figCount"/>
									<xsl:value-of select="concat(' - ', ../title)"/>
									<xsl:text> (Sheet </xsl:text>
									<xsl:number level="single" count="." format="1"/>
									<xsl:text> of </xsl:text>
									<xsl:value-of select="count(../graphic)"/>
									<xsl:text>)</xsl:text>
								</fo:inline>
							</fo:block>
						</xsl:if>
						<xsl:if test="not(count(../graphic) &gt; 1)">
							<fo:block text-align="center" keep-with-previous="always" space-after="2pt">
								<fo:inline font-style="italic">Figure <xsl:value-of select="$figCount"/>
									<xsl:value-of select="concat(' - ', ../title)"/>
								</fo:inline>
							</fo:block>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<fo:block>
							<fo:external-graphic display-align="center" content-height="scale-to-fit" content-width="170mm" src="url('{$grph}')"/>
						</fo:block>
						<xsl:if test="count(../graphic) &gt; 1">
							<fo:block text-align="center" keep-with-previous="always" space-after="2pt">
								<fo:inline font-style="italic">Figure <xsl:value-of select="$figCount"/>
									<xsl:value-of select="concat(' - ', ../title)"/>
									<xsl:text> (Sheet </xsl:text>
									<xsl:number level="single" count="." format="1"/>
									<xsl:text> of </xsl:text>
									<xsl:value-of select="count(../graphic)"/>
									<xsl:text>)</xsl:text>
								</fo:inline>
							</fo:block>
						</xsl:if>
						<xsl:if test="not(count(../graphic) &gt; 1)">
							<fo:block text-align="center" keep-with-previous="always" space-after="2pt">
								<fo:inline font-style="italic">Figure <xsl:value-of select="$figCount"/>
									<xsl:value-of select="concat(' - ', ../title)"/>
								</fo:inline>
							</fo:block>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:for-each select="./legend">
				<fo:block text-align="center" display-align="center">
					<!--<fo:block keep-with-next="always" text-align="center">
						Legend
					</fo:block>-->
					<fo:table table-layout="fixed" width="100%">
						<fo:table-column column-width="proportional-column-width(1)"/>
						<fo:table-column column-width="100mm"/>
						<fo:table-column column-width="proportional-column-width(1)"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell column-number="2">
									<fo:block>
										<fo:block keep-with-next="always" text-align="center">
											Legend
										</fo:block>
										<fo:table display-align="center" width="100%">
											<fo:table-header>
												<fo:table-row>
													<fo:table-cell border-top-style="solid" border-bottom-style="solid"
														border-left-style="solid" border-right-style="solid" padding-top="1pt"
														padding-bottom="1pt" padding-left="1pt"><fo:block text-align="center" font-weight="bold">Item</fo:block></fo:table-cell>
													<fo:table-cell border-top-style="solid" border-bottom-style="solid"
														border-left-style="solid" border-right-style="solid" padding-top="1pt"
														padding-bottom="1pt" padding-left="1pt"><fo:block text-align="center" font-weight="bold">Description</fo:block></fo:table-cell>
												</fo:table-row>
											</fo:table-header>
											<fo:table-footer>
												<fo:table-row>
													<fo:table-cell><fo:block/></fo:table-cell>
												</fo:table-row>
											</fo:table-footer>
											<fo:table-body>
												<xsl:for-each select="./definitionList/definitionListItem">
													<fo:table-row>
														<xsl:for-each select="./listItemTerm">
															<fo:table-cell border-top-style="solid" border-bottom-style="solid"
																border-left-style="solid" border-right-style="solid" padding-top="1pt"
																padding-bottom="1pt" padding-left="1pt">
																<fo:block text-align="left">
																	<xsl:value-of select="."/>
																</fo:block>
															</fo:table-cell>
														</xsl:for-each>
														<xsl:for-each select="./listItemDefinition">
															<fo:table-cell border-top-style="solid" border-bottom-style="solid"
																border-left-style="solid" border-right-style="solid" padding-top="1pt"
																padding-bottom="1pt" padding-left="1pt">
																<fo:block text-align="left">
																	<xsl:value-of select="."/>
																</fo:block>
															</fo:table-cell>
														</xsl:for-each>
													</fo:table-row>
												</xsl:for-each>
											</fo:table-body>
										</fo:table>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					
				</fo:block>
			</xsl:for-each>
		</fo:block>
		<!--<fo:block id="{@id}" keep-with-next="always" text-align="center" space-before="2pt">
			<xsl:apply-templates select="graphic"/>
		</fo:block>
		<fo:block text-align="center" keep-with-previous="always" space-after="2pt">
			<fo:inline font-style="italic">Figure <xsl:value-of select="$figCount"/><xsl:value-of select="concat(' - ', ./title)"/></fo:inline>
		</fo:block>-->
		
		<!-- <fo:block text-align="center" keep-with-previous="always">
			<xsl:apply-templates select="title"/> -->
			<!-- <xsl:choose>
				<xsl:when test="substring(@id,3,1) = '0' and substring(@id,4,1) = '0'">
					<xsl:value-of select="concat('Figure ',substring(@id,5),' - ',./title)"/>
				</xsl:when>
				<xsl:when
					test="substring(@id,2,1) = '0' and substring(@id,3,1) = '0' and substring(@id,4,1) &gt; '0'">
					<xsl:value-of select="concat('Figure ',substring(@id,4), ' - ',./title)"/>
				</xsl:when>
				<xsl:when test="substring(@id,2,1) = '0' and substring(@id,3,1) &gt; '0'">
					<xsl:value-of select="concat('Figure ',substring(@id,3), ' - ',./title)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('Figure ',substring(@id,2), ' - ',./title)"/>
				</xsl:otherwise>
			</xsl:choose> -->
		<!-- </fo:block> -->
	</xsl:template>

	<xsl:template match="graphic">
		<xsl:variable name="grph" select="unparsed-entity-uri(@infoEntityIdent)"/>
		<fo:block>
			<fo:external-graphic display-align="center" content-height="210mm" content-width="scale-to-fit" src="url('{$grph}')"/>
		</fo:block><!--content-width="scale-to-fit" content-height="scale-to-fit"-->
	</xsl:template>

	<xsl:template match="commonInfoDescrPara/table">
		<fo:block id="{@id}" keep-with-next="always" space-after="2mm">
			<fo:block font-weight="bold" font-size="11pt" text-align="left" space-after="2mm">
				<xsl:choose>
					<xsl:when test="substring(@id,2,1) = '0' and substring(@id,3,1) = '0'">
						<xsl:value-of select="concat('Table ',substring(@id,4),' - ',./title)"/>
					</xsl:when>
					<xsl:when test="substring(@id,2,1) = '0' and substring(@id,3,1) &gt; '0'">
						<xsl:value-of select="concat('Table ',substring(@id,3), ' - ',./title)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('Table ',substring(@id,2), ' - ',./title)"/>
					</xsl:otherwise>
				</xsl:choose>
			</fo:block>
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="50%"/>
				<fo:table-column column-width="50%"/>
				<xsl:for-each select="tgroup/tbody">
					<fo:table-body>
						<xsl:for-each select="row">
							<fo:table-row>
								<!-- <xsl:for-each select="entry"> -->
								<xsl:apply-templates/>
								<!-- </xsl:for-each> -->
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</xsl:for-each>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template match="entry[emphasis/captionGroup]">
		<xsl:choose>
			<xsl:when test="//captionBody/captionRow/captionEntry/caption/@color = 'co02'">
				<fo:table-cell color="orange" background-color="black" font-weight="bold"
					border-top-style="solid" border-bottom-style="solid" border-left-style="solid"
					border-right-style="solid" padding-top="1pt" padding-bottom="1pt"
					padding-left="1pt">
					<fo:block color="orange">
						<xsl:value-of
							select="//captionBody/captionRow/captionEntry/caption/captionLine"/>
					</fo:block>
				</fo:table-cell>
			</xsl:when>
			<xsl:when test="//captionBody/captionRow/captionEntry/caption/@color = 'co07'">
				<fo:table-cell color="white" background-color="black" font-weight="bold"
					border-top-style="solid" border-bottom-style="solid" border-left-style="solid"
					border-right-style="solid" padding-top="1pt" padding-bottom="1pt"
					padding-left="1pt">
					<fo:block color="white">
						<xsl:value-of
							select="//captionBody/captionRow/captionEntry/caption/captionLine"/>
					</fo:block>
				</fo:table-cell>
			</xsl:when>
			<xsl:when test="//captionBody/captionRow/captionEntry/caption/@color = 'co51'">
				<fo:table-cell color="cyan" background-color="black" font-weight="bold"
					border-top-style="solid" border-bottom-style="solid" border-left-style="solid"
					border-right-style="solid" padding-top="1pt" padding-bottom="1pt"
					padding-left="1pt">
					<fo:block color="cyan">
						<xsl:value-of
							select="//captionBody/captionRow/captionEntry/caption/captionLine"/>
					</fo:block>
				</fo:table-cell>
			</xsl:when>
			<xsl:when test="//captionBody/captionRow/captionEntry/caption/@color = 'co04'">
				<fo:table-cell background-color="black" font-weight="bold" border-top-style="solid"
					border-bottom-style="solid" border-left-style="solid" border-right-style="solid"
					padding-top="1pt" padding-bottom="1pt" padding-left="1pt">
					<fo:block color="red">
						<xsl:value-of
							select="//captionBody/captionRow/captionEntry/caption/captionLine"/>
					</fo:block>
				</fo:table-cell>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--<xsl:template match="entry">
		<fo:table-cell border-top-style="solid" border-bottom-style="solid"
			border-left-style="solid" border-right-style="solid" padding-top="1pt"
			padding-bottom="1pt" padding-left="1pt">
			<fo:block>
				<xsl:apply-templates/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>-->

	<xsl:template match="emphasis[@emphasisType='em51']">
		<fo:inline font-weight="bold" font-style="italic">
			<!--<xsl:value-of select="."/>-->
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="emphasis">
		<fo:inline font-weight="bold">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>

	<xsl:template name="buildRefs">
		<fo:block space-before="3mm">&#x20;</fo:block>
		<fo:table table-layout="fixed" width="100%">
			<fo:table-column column-width="proportional-column-width(1)"/>
			<fo:table-header>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-size="12pt" font-weight="bold" text-align="left"
							space-before="5mm" space-after="2mm" keep-with-next="always">References
							<fo:retrieve-table-marker retrieve-class-name="toc-cont" 
								retrieve-position-within-table="first-starting" retrieve-boundary-within-table="table"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:marker marker-class-name="toc-cont"/>
						<fo:block/>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell>
						<fo:marker marker-class-name="toc-cont"> - (Continued)</fo:marker>
						<fo:block>
							<fo:marker marker-class-name="toc-cont"> - (Continued)</fo:marker>
							<fo:table table-layout="fixed" width="100%">
								<fo:table-column column-width="50%"/>
								<fo:table-column column-width="50%"/>
								<fo:table-header>
									<fo:table-row><!--border-top-style="solid" border-top-color="black"
										border-bottom-style="solid" border-bottom-color="black"
										border-collapse="collapse"-->
										<fo:table-cell padding-top="1pt" padding-bottom="1pt">
											<fo:block font-weight="bold" font-size="10pt">Data module/Technical publication</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-top="1pt" padding-bottom="1pt">
											<fo:block font-weight="bold" font-size="10pt" text-align="left">Title</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-header>
								<fo:table-footer>
									<fo:table-row>
										<fo:table-cell>
											<fo:block/>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block/>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-footer>
								<fo:table-body>
									<xsl:apply-templates select="//content/refs/dmRef/dmRefIdent/dmCode" mode="list"/>
									<!--<xsl:apply-templates select="//content//dmRef/dmRefIdent/dmCode" mode="refsList"/>-->
									<xsl:apply-templates select="//content//externalPubRef/externalPubRefIdent" mode="refsList"/>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		<fo:block space-after="5mm" break-after="page">
			
		</fo:block>
	</xsl:template>
	
	<xsl:template match="//content/refs/dmRef/dmRefIdent/dmCode" mode="list">
		<xsl:variable name="dmc"
			select="concat(@modelIdentCode,'-',@systemDiffCode, '-', @systemCode, '-',@subSystemCode,@subSubSystemCode,'-',@assyCode,'-',@disassyCode,@disassyCodeVariant,'-',@infoCode,@infoCodeVariant,'-',@itemLocationCode)"/>
		<fo:table-row>
			<fo:table-cell padding-top="2pt" padding-bottom="2pt">
				<fo:block font-size="10pt" color="blue">
					<xsl:value-of select="$dmc"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell padding-top="2pt" padding-bottom="2pt">
				<fo:block font-size="10pt" color="blue">
					<xsl:value-of select="concat(../../dmRefAddressItems/dmTitle/techName,' - ', ../../dmRefAddressItems/dmTitle/infoName)"/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<xsl:template match="//content//dmRef/dmRefIdent/dmCode" mode="refsList">
		<xsl:variable name="dmc"
			select="concat(@modelIdentCode,'-',@systemDiffCode, '-', @systemCode, '-',@subSystemCode,@subSubSystemCode,'-',@assyCode,'-',@disassyCode,@disassyCodeVariant,'-',@infoCode,@infoCodeVariant,'-',@itemLocationCode)"/>
		<xsl:if test="generate-id() = generate-id(key('refsDmRef', $dmc)[1])">
			<fo:table-row>
				<fo:table-cell padding-top="2pt" padding-bottom="2pt">
					<fo:block font-size="10pt" color="blue">
						<xsl:value-of select="$dmc"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell padding-top="2pt" padding-bottom="2pt">
					<fo:block font-size="10pt" color="blue">
						<xsl:value-of select="concat(../../dmRefAddressItems/dmTitle/techName,' - ', ../../dmRefAddressItems/dmTitle/infoName)"/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="externalPubRef">
		<fo:inline color="blue"><xsl:value-of select="externalPubRefIdent/externalPubCode"/> - <xsl:value-of select="externalPubRefIdent/externalPubTitle"/></fo:inline>
	</xsl:template>
	
	<xsl:template match="//content//externalPubRef/externalPubRefIdent" mode="refsList">
		<xsl:variable name="extPubC"
			select="concat(externalPubCode, ';', externalPubTitle)"/>
		<xsl:if test="generate-id() = generate-id(key('refsExtPubref', $extPubC)[1])">
			<fo:table-row>
				<fo:table-cell padding-top="2pt" padding-bottom="2pt">
					<fo:block font-size="10pt" color="blue">
						<xsl:value-of select="substring-before($extPubC, ';')"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell padding-top="2pt" padding-bottom="2pt">
					<fo:block font-size="10pt" color="blue">
						<xsl:value-of select="substring-after($extPubC, ';')"/>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="buildTOC2">
		<fo:table table-layout="fixed" width="100%">
			<fo:table-column column-width="proportional-column-width(1)"/>
			<fo:table-header>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-size="12pt" font-weight="bold" text-align="left"
							space-before="5mm" space-after="2mm" keep-with-next="always">Table of Contents
						<fo:retrieve-table-marker retrieve-class-name="toc-cont" 
							retrieve-position-within-table="first-starting" retrieve-boundary-within-table="table"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:marker marker-class-name="toc-cont"/>
						<fo:block/>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell>
						<fo:marker marker-class-name="toc-cont"> - (Continued)</fo:marker>
						<fo:block>
							<fo:marker marker-class-name="toc-cont"> - (Continued)</fo:marker>
							<fo:table table-layout="fixed" width="100%">
								<fo:table-column column-width="90%"/>
								<fo:table-column column-width="10%"/>
								<fo:table-header>
									<fo:table-row>
										<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-collapse="collapse"><!--border-top-style="solid"
											border-top-color="black" border-bottom-style="solid" border-bottom-color="black"-->
											<fo:block font-size="10pt" font-weight="bold">Paragraph / Topic</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-collapse="collapse"><!--border-top-style="solid"
											border-top-color="black" border-bottom-style="solid" border-bottom-color="black"-->
											<fo:block font-size="10pt" text-align="right" font-weight="bold">Page</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-header>
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
											<fo:block text-align-last="justify" font-size="10pt">
												&#x20;
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:if test="//content/description">
										<xsl:for-each select="//content/description/levelledPara">
											<xsl:variable name="PId" select="@id"/>
											<fo:table-row>
												<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
													<fo:block text-align-last="justify" font-size="10pt">
														<fo:basic-link internal-destination="{$PId}">
															<xsl:number level="multiple" count="description/levelledPara" format="1"/>
															<xsl:value-of select="concat('&#x9;',./title, '&#x20;')"/>
															<fo:leader leader-pattern="dots"/>
															<!-- <fo:page-number-citation ref-id="{$PId}"/> -->
															<fo:page-number-citation ref-id="{$PId}"/>
														</fo:basic-link>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
											<xsl:if test="./levelledPara">
												<xsl:for-each select="./levelledPara">
													<xsl:variable name="PId2" select="@id"/>
													<fo:table-row>
														<fo:table-cell padding-top="2pt" padding-bottom="2pt"
															number-columns-spanned="2">
															<fo:block text-align-last="justify" font-size="10pt" margin-left="5mm">
																<fo:basic-link internal-destination="{$PId2}">
																	<xsl:number level="multiple" count="description/levelledPara | levelledPara" format="1.1"/>
																	<xsl:value-of select="concat('&#x9;',./title, '&#x20;')"/>
																	<fo:leader leader-pattern="dots"/>
																	<fo:page-number-citation ref-id="{$PId2}"/>
																</fo:basic-link>
															</fo:block>
														</fo:table-cell>
													</fo:table-row>
													<xsl:if test="./levelledPara">
														<xsl:for-each select="./levelledPara">
															<xsl:variable name="PId3" select="@id"/>
															<fo:table-row>
																<fo:table-cell padding-top="2pt" padding-bottom="2pt"
																	number-columns-spanned="2">
																	<fo:block text-align-last="justify" font-size="10pt" margin-left="12mm">
																		<fo:basic-link internal-destination="{$PId3}">
																			<xsl:number level="multiple" count="description/levelledPara/levelledPara | levelledPara" format="1.1.1"/>
																			<xsl:value-of select="concat('&#x9;',./title, '&#x20;')"/>
																			<fo:leader leader-pattern="dots"/>
																			<fo:page-number-citation ref-id="{$PId3}"/>
																		</fo:basic-link>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
															<xsl:if test="./levelledPara">
																<xsl:for-each select="./levelledPara">
																	<xsl:variable name="PId4" select="@id"/>
																	<fo:table-row>
																		<fo:table-cell padding-top="2pt" padding-bottom="2pt"
																			number-columns-spanned="2">
																			<fo:block text-align-last="justify" font-size="10pt" margin-left="21mm">
																				<fo:basic-link internal-destination="{$PId4}">
																					<xsl:number level="multiple" count="description/levelledPara/levelledPara/levelledPara | levelledPara" format="1.1.1.1"/>
																					<xsl:value-of select="concat('&#x9;',./title, '&#x20;')"/>
																					<fo:leader leader-pattern="dots"/>
																					<fo:page-number-citation ref-id="{$PId4}"/>
																				</fo:basic-link>
																			</fo:block>
																		</fo:table-cell>
																	</fo:table-row>
																</xsl:for-each>
															</xsl:if>
														</xsl:for-each>
													</xsl:if>
												</xsl:for-each>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test="//content/procedure">
										<xsl:for-each select="//content/procedure/preliminaryRqmts">
											<fo:table-row>
												<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
													<fo:block text-align-last="justify" font-size="10pt">
														<fo:basic-link internal-destination="prelreq-01">
															<!--<xsl:number level="multiple" count="faultIsolation/faultIsolationProcedure" format="1"/>-->
															<xsl:value-of select="concat('&#x9;&#x9;','Preliminary Requirements', '&#x20;')"/>
															<fo:leader leader-pattern="dots"/>
															<!-- <fo:page-number-citation ref-id="{$PId}"/> -->
															<fo:page-number-citation ref-id="prelreq-01"/>
														</fo:basic-link>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:for-each>
										<xsl:for-each select="//content/procedure/mainProcedure">
											<fo:table-row>
												<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
													<fo:block text-align-last="justify" font-size="10pt">
														<fo:basic-link internal-destination="{generate-id(.)}">
															<!--<xsl:number level="multiple" count="faultIsolation/faultIsolationProcedure" format="1"/>-->
															<xsl:value-of select="concat('&#x9;&#x9;','Procedure', '&#x20;')"/>
															<fo:leader leader-pattern="dots"/>
															<!-- <fo:page-number-citation ref-id="{$PId}"/> -->
															<fo:page-number-citation ref-id="{generate-id(.)}"/>
														</fo:basic-link>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:for-each>
										<xsl:for-each select="//content/procedure/closeRqmts">
											<fo:table-row>
												<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
													<fo:block text-align-last="justify" font-size="10pt">
														<fo:basic-link internal-destination="closereq-01">
															<!--<xsl:number level="multiple" count="faultIsolation/faultIsolationProcedure" format="1"/>-->
															<xsl:value-of select="concat('&#x9;&#x9;','Closing Requirements', '&#x20;')"/>
															<fo:leader leader-pattern="dots"/>
															<!-- <fo:page-number-citation ref-id="{$PId}"/> -->
															<fo:page-number-citation ref-id="closereq-01"/>
														</fo:basic-link>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test="//content/faultIsolation">
										<xsl:for-each select="//content/faultIsolation/faultIsolationProcedure">
											<xsl:variable name="FaultId" select="@id"/>
											<fo:table-row>
												<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
													<fo:block text-align-last="justify" font-size="10pt">
														<fo:basic-link internal-destination="{$FaultId}">
															<!--<xsl:number level="multiple" count="faultIsolation/faultIsolationProcedure" format="1"/>-->
															<xsl:value-of select="concat('&#x9;&#x9;',./faultDescr/descr, '&#x20;')"/>
															<fo:leader leader-pattern="dots"/>
															<!-- <fo:page-number-citation ref-id="{$PId}"/> -->
															<fo:page-number-citation ref-id="{$FaultId}"/>
														</fo:basic-link>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:for-each>
									</xsl:if>
									<fo:table-row>
										<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
											<fo:block text-align-last="justify" font-size="10pt">
												&#x20;
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<xsl:template name="buildTOC">
		<!-- <fo:block font-weight="bold" font-size="14pt" text-align="center">Table of Contents</fo:block> -->
		<fo:block font-size="12pt" font-weight="bold" text-align="left"
			space-before="5mm" space-after="2mm" keep-with-next="always">Table of Contents</fo:block>
		<fo:table table-layout="fixed" width="100%">
			<fo:table-column column-width="90%"/>
			<fo:table-column column-width="10%"/>
			<fo:table-header>
				<fo:table-row>
					<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-collapse="collapse"><!--border-top-style="solid"
						border-top-color="black" border-bottom-style="solid" border-bottom-color="black"-->
						<fo:block font-size="10pt" font-weight="bold">Paragraph / Topic</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-collapse="collapse"><!--border-top-style="solid"
						border-top-color="black" border-bottom-style="solid" border-bottom-color="black"-->
						<fo:block font-size="10pt" text-align="right" font-weight="bold">Page</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<!-- <fo:table-footer>
				<fo:table-row>
					<fo:table-cell border-top-style="solid" border-top-color="black"
						border-collapse="collapse">
						<fo:block/>
					</fo:table-cell>
					<fo:table-cell border-top-style="solid" border-top-color="black"
						border-collapse="collapse">
						<fo:block/>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-footer> -->
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
						<fo:block text-align-last="justify" font-size="10pt">
							&#x20;
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<xsl:if test="//content/description">
					<xsl:for-each select="//content/description/levelledPara">
						<xsl:variable name="PId" select="@id"/>
						<fo:table-row>
							<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
								<fo:block text-align-last="justify" font-size="10pt">
									<fo:basic-link internal-destination="{$PId}">
										<xsl:number level="multiple" count="description/levelledPara" format="1"/>
										<xsl:value-of select="concat('&#x9;',./title, '&#x20;')"/>
										<fo:leader leader-pattern="dots"/>
											<!-- <fo:page-number-citation ref-id="{$PId}"/> -->
										<fo:page-number-citation ref-id="{$PId}"/>
									</fo:basic-link>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<xsl:if test="./levelledPara">
							<xsl:for-each select="./levelledPara">
								<xsl:variable name="PId2" select="@id"/>
								<fo:table-row>
									<fo:table-cell padding-top="2pt" padding-bottom="2pt"
										number-columns-spanned="2">
										<fo:block text-align-last="justify" font-size="10pt" margin-left="5mm">
											<fo:basic-link internal-destination="{$PId2}">
												<xsl:number level="multiple" count="description/levelledPara | levelledPara" format="1.1"/>
												<xsl:value-of select="concat('&#x9;',./title, '&#x20;')"/>
												<fo:leader leader-pattern="dots"/>
												<fo:page-number-citation ref-id="{$PId2}"/>
											</fo:basic-link>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:if test="./levelledPara">
									<xsl:for-each select="./levelledPara">
										<xsl:variable name="PId3" select="@id"/>
										<fo:table-row>
											<fo:table-cell padding-top="2pt" padding-bottom="2pt"
												number-columns-spanned="2">
												<fo:block text-align-last="justify" font-size="10pt" margin-left="12mm">
													<fo:basic-link internal-destination="{$PId3}">
														<xsl:number level="multiple" count="description/levelledPara/levelledPara | levelledPara" format="1.1.1"/>
														<xsl:value-of select="concat('&#x9;',./title, '&#x20;')"/>
														<fo:leader leader-pattern="dots"/>
														<fo:page-number-citation ref-id="{$PId3}"/>
													</fo:basic-link>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<xsl:if test="./levelledPara">
											<xsl:for-each select="./levelledPara">
												<xsl:variable name="PId4" select="@id"/>
												<fo:table-row>
													<fo:table-cell padding-top="2pt" padding-bottom="2pt"
														number-columns-spanned="2">
														<fo:block text-align-last="justify" font-size="10pt" margin-left="21mm">
															<fo:basic-link internal-destination="{$PId4}">
																<xsl:number level="multiple" count="description/levelledPara/levelledPara/levelledPara | levelledPara" format="1.1.1.1"/>
																<xsl:value-of select="concat('&#x9;',./title, '&#x20;')"/>
																<fo:leader leader-pattern="dots"/>
																<fo:page-number-citation ref-id="{$PId4}"/>
															</fo:basic-link>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</xsl:for-each>
										</xsl:if>
									</xsl:for-each>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<fo:table-row>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" number-columns-spanned="2">
						<fo:block text-align-last="justify" font-size="10pt">
							&#x20;
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		<!-- need a page break here -->
	</xsl:template>

	<xsl:template match="identAndStatusSection"> </xsl:template>

	<xsl:template match="dmStatus"> </xsl:template>

	<xsl:template match="content">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="faultIsolation">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="faultReporting">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="isolatedFault">
		<fo:block keep-with-next="always">
			<fo:leader leader-length="100%" leader-pattern="rule" rule-style="solid" color="black"/>
		</fo:block>
		<fo:block font-size="10pt" keep-with-next="always" font-weight="bold" space-before="1.5mm">
			<xsl:value-of select="concat('Fault code:', @faultCode)"/>
		</fo:block>
		<fo:table table-layout="fixed" width="100%">
			<fo:table-column width="33%"/>
			<fo:table-column width="34%"/>
			<fo:table-column width="33%"/>
			<fo:table-header>
				<fo:table-row>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid" border-left-style="solid">
						<fo:block font-size="10pt" font-weight="bold">Description</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid">
						<fo:block font-size="10pt" font-weight="bold">LRU for Repair/Replacement</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid" border-right-style="solid">
						<fo:block font-size="10pt" font-weight="bold">Data Module Reference</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid" border-left-style="solid">
						<fo:block font-size="10pt">
							<xsl:value-of select="faultDescr/descr"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid">
						<fo:block font-size="10pt">
							<xsl:value-of select="normalize-space(locateAndRepair/locateAndRepairLruItem/lru/name)"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid" border-right-style="solid">
						<fo:block font-size="10pt">
							<xsl:apply-templates select="locateAndRepair/locateAndRepairLruItem/repair/refs/dmRef"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		<!--<xsl:for-each select="faultDescr/refs">
			<fo:block keep-with-previous="always" space-before="1.5mm" font-size="10pt"
				font-weight="bold"> References: </fo:block>
			<xsl:for-each select="dmRef">
				<fo:block font-size="10pt" font-weight="bold" text-decoration="underline"
					color="blue">
					<xsl:value-of
						select="concat('DMC-',dmRefIdent/dmCode/@modelIdentCode,'-',dmRefIdent/dmCode/@systemDiffCode, '-', dmRefIdent/dmCode/@systemCode, '-',dmRefIdent/dmCode/@subSystemCode,dmRefIdent/dmCode/@subSubSystemCode,'-',dmRefIdent/dmCode/@assyCode,'-',dmRefIdent/dmCode/@disassyCode,dmRefIdent/dmCode/@disassyCodeVariant,'-',dmRefIdent/dmCode/@infoCode,dmRefIdent/dmCode/@infoCodeVariant,'-',dmRefIdent/dmCode/@itemLocationCode)"
					/>
				</fo:block>
			</xsl:for-each>
		</xsl:for-each>-->
		<fo:block keep-with-previous="always">
			<fo:leader leader-length="100%" leader-pattern="rule" rule-style="solid" color="black"/>
		</fo:block>
	</xsl:template>

	<xsl:template match="detectedFault">
		<fo:block keep-with-next="always">
			<fo:leader leader-length="100%" leader-pattern="rule" rule-style="solid" color="black"/>
		</fo:block>
		<fo:block font-size="10pt" keep-with-next="always" font-weight="bold" space-before="1.5mm">
			<xsl:value-of select="concat('Fault code:', @faultCode)"/>
		</fo:block>
		<fo:table table-layout="fixed" width="100%">
			<fo:table-column width="33%"/>
			<fo:table-column width="34%"/>
			<fo:table-column width="33%"/>
			<fo:table-header>
				<fo:table-row>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid" border-left-style="solid">
						<fo:block font-size="10pt" font-weight="bold">Description</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid">
						<fo:block font-size="10pt" font-weight="bold">Fault message</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid" border-right-style="solid">
						<fo:block font-size="10pt" font-weight="bold">Fault condition</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid" border-left-style="solid">
						<fo:block font-size="10pt">
							<xsl:value-of select="faultDescr/descr"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid">
						<fo:block font-size="10pt" font-weight="bold"/>
					</fo:table-cell>
					<fo:table-cell padding-top="2pt" padding-bottom="2pt" border-top-style="solid"
						border-bottom-style="solid" border-right-style="solid">
						<fo:block font-size="10pt" font-weight="bold"/>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		<xsl:for-each select="faultDescr/refs">
			<fo:block keep-with-previous="always" space-before="1.5mm" font-size="10pt"
				font-weight="bold"> References: </fo:block>
			<xsl:for-each select="dmRef">
				<fo:block font-size="10pt" font-weight="bold" text-decoration="underline"
					color="blue">
					<xsl:value-of
						select="concat('DMC-',dmRefIdent/dmCode/@modelIdentCode,'-',dmRefIdent/dmCode/@systemDiffCode, '-', dmRefIdent/dmCode/@systemCode, '-',dmRefIdent/dmCode/@subSystemCode,dmRefIdent/dmCode/@subSubSystemCode,'-',dmRefIdent/dmCode/@assyCode,'-',dmRefIdent/dmCode/@disassyCode,dmRefIdent/dmCode/@disassyCodeVariant,'-',dmRefIdent/dmCode/@infoCode,dmRefIdent/dmCode/@infoCodeVariant,'-',dmRefIdent/dmCode/@itemLocationCode)"
					/>
				</fo:block>
			</xsl:for-each>
		</xsl:for-each>
		<fo:block keep-with-previous="always">
			<fo:leader leader-length="100%" leader-pattern="rule" rule-style="solid" color="black"/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="attentionSequentialList">
		<fo:list-block margin-left="5mm" space-before="4pt">
			<xsl:for-each select="./attentionSequentialListItem">
				<fo:list-item space-after="2pt">
					<fo:list-item-label end-indent="label-end()">
						<fo:block><xsl:number/>.</fo:block>
					</fo:list-item-label>
					<fo:list-item-body start-indent="body-start()">
						<fo:block hyphenate="false">
							<xsl:apply-templates/>
						</fo:block>
					</fo:list-item-body>
				</fo:list-item>
			</xsl:for-each>
		</fo:list-block>
	</xsl:template>
	
	<xsl:template match="attentionRandomList">
		<fo:list-block margin-left="5mm" space-before="4pt">
			<xsl:for-each select="./attentionRandomListItem">
				<fo:list-item space-after="2pt">
					<fo:list-item-label end-indent="label-end()">
						<fo:block>&#x2022;</fo:block>
					</fo:list-item-label>
					<fo:list-item-body start-indent="body-start()">
						<fo:block hyphenate="false">
							<xsl:apply-templates/>
						</fo:block>
					</fo:list-item-body>
				</fo:list-item>
			</xsl:for-each>
		</fo:list-block>
	</xsl:template>

	<xsl:template match="note">
		<fo:block text-align="center" text-decoration="underline" font-size="11pt" font-weight="bold">NOTE</fo:block>
		<!--<xsl:apply-templates/>-->
		<xsl:choose>
			<xsl:when test="count(./notePara) > 1">
				<fo:list-block margin-left="5mm" space-before="4pt">
					<xsl:for-each select="./notePara">
						<fo:list-item>
							<fo:list-item-label end-indent="label-end()">
								<fo:block>&#x2022;</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()">
								<fo:block>
									<xsl:apply-templates/>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</xsl:for-each>
				</fo:list-block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="notePara">
		<fo:block font-size="10pt" space-after="2pt" space-before="2pt">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="acronym">
		<fo:inline>
			<xsl:value-of select="acronymDefinition"/>
			<xsl:text> (</xsl:text>
			<xsl:value-of select="acronymTerm"/>
			<xsl:text>)</xsl:text>
		</fo:inline>
	</xsl:template>

	<!-- <xsl:template match="para">
		<fo:block font-size="10pt">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template> -->

	<xsl:template match="commonInfoDescrPara">
		<fo:block font-size="10pt">
			<!--space-before="2mm" space-after="2mm"-->
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="randomList">
		<fo:list-block margin-left="5mm" space-before="4pt">
			<xsl:for-each select="./listItem">
				<fo:list-item>
					<fo:list-item-label end-indent="label-end()">
						<fo:block>&#x2022;</fo:block>
					</fo:list-item-label>
					<fo:list-item-body start-indent="body-start()">
						<fo:block>
							<xsl:apply-templates/>
						</fo:block>
					</fo:list-item-body>
				</fo:list-item>
			</xsl:for-each>
		</fo:list-block>
	</xsl:template>
	
	<xsl:template match="sequentialList">
		<fo:list-block margin-left="5mm" space-before="4pt" keep-with-previous="always">
			<xsl:for-each select="./listItem">
				<fo:list-item>
					<fo:list-item-label end-indent="label-end()">
						<fo:block><xsl:number format="1."/></fo:block>
					</fo:list-item-label>
					<fo:list-item-body start-indent="body-start()">
						<fo:block>
							<xsl:apply-templates/>
						</fo:block>
					</fo:list-item-body>
				</fo:list-item>
			</xsl:for-each>
		</fo:list-block>
	</xsl:template>
	
	<xsl:template match="sequentialList[@caveat='cv01']">
		<fo:list-block margin-left="5mm" space-before="4pt">
			<xsl:for-each select="./listItem">
				<fo:list-item>
					<fo:list-item-label end-indent="label-end()">
						<fo:block><xsl:number format="a."/></fo:block>
					</fo:list-item-label>
					<fo:list-item-body start-indent="body-start()">
						<fo:block>
							<xsl:apply-templates/>
						</fo:block>
					</fo:list-item-body>
				</fo:list-item>
			</xsl:for-each>
		</fo:list-block>
	</xsl:template>

	<xsl:template match="faultIsolationProcedure">
		<fo:block id="{@id}">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="faultDescr">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="descr">
		<fo:block break-before="page">
			<fo:inline font-weight="bold" font-size="12pt">Fault Description: </fo:inline><fo:inline font-size="10pt" font-weight="normal"><xsl:value-of select="."/></fo:inline>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="quantity">
		<xsl:apply-templates/>
	</xsl:template>
	
	
	<xsl:template match="quantityGroup">
		<xsl:variable name="uom" select="@quantityUnitOfMeasure"/>
		<xsl:variable name="val" select="quantityValue"/>
		<xsl:if test="./quantityTolerance">
			<xsl:for-each select=".">
				<xsl:value-of select="quantityValue"/>
			</xsl:for-each>
			<xsl:for-each select="quantityTolerance">
				<xsl:if test="not(./following-sibling::*[1][self::quantityTolerance]) and not(preceding-sibling::*[1][self::quantityTolerance])">
					<xsl:if test="@quantityToleranceType = 'plusorminus'">
						<xsl:if test="$uom='um51'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' VDC')"/>
							<!-- <xsl:value-of select="concat(./quantityValue,' VDC')"/> -->
						</xsl:if>
						<xsl:if test="$uom='um52'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' VAC')"/>
						</xsl:if>
						<xsl:if test="$uom='mV'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' mV')"/>
						</xsl:if>
						<xsl:if test="$uom='in'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(' &#xB1; ', ., ' inches')"/><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="not(quantityValue &gt; 1)">
								<xsl:value-of select="concat(' &#xB1; ', ., ' inch')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<!--<xsl:if test="$uom='in'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' in')"/>
						</xsl:if>-->
						<xsl:if test="$uom='ohm'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' ')"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--&#x2126;-->
						</xsl:if>
						<xsl:if test="$uom='in2'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' in')"/><fo:inline vertical-align="super" font-size="6pt">2</fo:inline><!--&#x2126;-->
						</xsl:if>
						<xsl:if test="$uom='Mohm'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' M')"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--'M','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='mohm'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(' &#xB1; ', ., ' milliohms')"/><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="quantityValue &lt;= 1">
								<xsl:value-of select="concat(' &#xB1; ', ., ' milliohm')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<xsl:if test="$uom='uF'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' uF')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='pF'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' pF')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='lbm'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' lbs.')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='lbf'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' lbs. of force')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='mL'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' mL')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='mA'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' mA')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='A'">
							<xsl:value-of select="concat(' &#xB1; ', ., ' A')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='lbf.in'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(' &#xB1; ', ., ' inch pounds')"/><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="quantityValue &lt;= 1">
								<xsl:value-of select="concat(' &#xB1; ', .,  ' inch pound')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<xsl:if test="$uom='um53'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(' &#xB1; ', .,  ' inch ounces')"/><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="quantityValue &lt;= 1">
								<xsl:value-of select="concat(' &#xB1; ', .,  ' inch ounce')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<xsl:if test="$uom='ft.lbf'">
							<xsl:if test="$val &gt; 1">
								<xsl:value-of select="concat(' &#xB1; ', ., ' foot pounds')"/>
								<!-- <xsl:value-of select="concat(quantityValue, ' foot-pounds')"/> --><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="$val &lt;= 1">
								<xsl:value-of select="concat(' &#xB1; ', ., ' foot pound')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<xsl:if test="$uom = 'mi/h'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(' &#xB1; ', .,  ' miles per hour')"/>
							</xsl:if>
						</xsl:if>
					</xsl:if>
				</xsl:if>
				<xsl:if test="./following-sibling::*[1][self::quantityTolerance]">
					<xsl:for-each select=".">
						<xsl:value-of select="concat(' + ', .)"/>
					</xsl:for-each>
					<xsl:for-each select="./following-sibling::*[1][self::quantityTolerance]">
						<xsl:if test="$uom='um51'">
							<xsl:value-of select="concat(', - ', ., ' VDC')"/>
							<!-- <xsl:value-of select="concat(./quantityValue,' VDC')"/> -->
						</xsl:if>
						<xsl:if test="$uom='um52'">
							<xsl:value-of select="concat(', - ', ., ' VAC')"/>
						</xsl:if>
						<xsl:if test="$uom='mV'">
							<xsl:value-of select="concat(', - ', ., ' mV')"/>
						</xsl:if>
						<xsl:if test="$uom='in'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(', - ', .,  ' inches')"/><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="quantityValue &lt;= 1">
								<xsl:value-of select="concat(', - ', ., ' inch')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<!--<xsl:if test="$uom='in'">
							<xsl:value-of select="concat(', - ', ., ' in')"/>
						</xsl:if>-->
						<xsl:if test="$uom='ohm'">
							<xsl:value-of select="concat(', - ', . )"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--&#x2126;-->
						</xsl:if>
						<xsl:if test="$uom='in2'">
							<xsl:value-of select="concat(', - ', ., ' in')"/><fo:inline vertical-align="super" font-size="6pt">2</fo:inline><!--&#x2126;-->
						</xsl:if>
						<xsl:if test="$uom='Mohm'">
							<xsl:value-of select="concat(', - ', ., ' M')"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--'M','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='mohm'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(', - ', ., ' milliohms')"/><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="quantityValue &lt;= 1">
								<xsl:value-of select="concat(', - ', ., ' milliohm')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<xsl:if test="$uom='uF'">
							<xsl:value-of select="concat(', - ', ., ' uF')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='pF'">
							<xsl:value-of select="concat(', - ', ., ' pF')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='lbm'">
							<xsl:value-of select="concat(', - ', ., ' lbs.')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='lbf'">
							<xsl:value-of select="concat(', - ', ., ' lbs. of force')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='mL'">
							<xsl:value-of select="concat(' - ', ., ' mL')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='mA'">
							<xsl:value-of select="concat(', - ', .,  ' mA')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='A'">
							<xsl:value-of select="concat(', - ', .,  ' A')"/><!--'m','&#x2126';-->
						</xsl:if>
						<xsl:if test="$uom='lbf.in'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(', - ', .,  ' inch pounds')"/><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="quantityValue &lt;= 1">
								<xsl:value-of select="concat(', - ', ., ' inch pound')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<xsl:if test="$uom='um53'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(', - ', .,  ' inch ounces')"/><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="quantityValue &lt;= 1">
								<xsl:value-of select="concat(', - ', .,  ' inch ounce')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<xsl:if test="$uom='ft.lbf'">
							<xsl:if test="$val &gt; 1">
								<xsl:value-of select="concat(', - ', ., ' foot pounds')"/>
								<!-- <xsl:value-of select="concat(quantityValue, ' foot-pounds')"/> --><!--'m','&#x2126';-->
							</xsl:if>
							<xsl:if test="$val &lt;= 1">
								<xsl:value-of select="concat(' &#xB1; ', ., ' foot pound')"/><!--'m','&#x2126';-->
							</xsl:if>
						</xsl:if>
						<xsl:if test="$uom = 'mi/h'">
							<xsl:if test="quantityValue &gt; 1">
								<xsl:value-of select="concat(', - ', ., ' miles per hour')"/>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="./following-sibling::*[1][self::quantityGroup]">
			<xsl:for-each select=".">
				<!--<xsl:value-of select="concat(./quantityValue, ' - ')"/>-->
				<xsl:if test="@quantityUnitOfMeasure='um51'">
					<xsl:value-of select="concat(./quantityValue,' VDC')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='um52'">
					<xsl:value-of select="concat(./quantityValue,' VAC')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='mV'">
					<xsl:value-of select="concat(./quantityValue,' mV')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='psi'">
					<xsl:value-of select="concat(./quantityValue,' psi')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='psig'">
					<xsl:value-of select="concat(./quantityValue,' psig')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='ohm'">
					<xsl:value-of select="quantityValue"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='in2'">
					<xsl:value-of select="quantityValue"/><fo:inline vertical-align="super" font-size="6pt">2</fo:inline><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='degF'">
					<xsl:value-of select="quantityValue"/><fo:inline font-family="Symbol">&#xB0; </fo:inline><xsl:text>F</xsl:text><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='degC'">
					<xsl:value-of select="quantityValue"/><fo:inline font-family="Symbol">&#xB0; </fo:inline><xsl:text>C</xsl:text><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='K'">
					<xsl:value-of select="concat(quantityValue, 'K')"/><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='Mohm'">
					<xsl:value-of select="concat(quantityValue, ' M')"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--'M','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='mohm'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(quantityValue, ' milliohms')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(quantityValue, ' milliohm')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='uF'">
					<xsl:value-of select="concat(quantityValue, ' uF')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='pF'">
					<xsl:value-of select="concat(quantityValue, ' pF')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='lbm'">
					<xsl:value-of select="concat(quantityValue, ' lbs.')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='lbf'">
					<xsl:value-of select="concat(quantityValue, ' lbs. of force')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='mL'">
					<xsl:value-of select="concat(quantityValue, ' mL')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='mA'">
					<xsl:value-of select="concat(quantityValue, ' mA')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='A'">
					<xsl:value-of select="concat(quantityValue, ' A')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='lbf.in'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(quantityValue, ' inch-pounds')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(quantityValue, ' inch-pound')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure = 'in'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(quantityValue, ' inches')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(quantityValue, ' inch')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure = 'ft'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(quantityValue, ' feet')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(quantityValue, ' foot')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure = 'mi'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(quantityValue, ' miles')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(quantityValue, ' feet')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='um53'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(quantityValue, ' inch-ounces')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(quantityValue, ' inch-ounce')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='ft.lbf'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(quantityValue, ' foot-pounds')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(quantityValue, ' foot-pound')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure = 'mi/h'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(quantityValue, ' miles per hour')"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="./following-sibling::*[1][self::quantityGroup]">
				<!-- <xsl:apply-templates/> -->
				<xsl:if test="@quantityUnitOfMeasure='um51'">
					<xsl:value-of select="concat(' - ',./quantityValue,' VDC')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='um52'">
					<xsl:value-of select="concat(' - ',./quantityValue,' VAC')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='mV'">
					<xsl:value-of select="concat(' - ',./quantityValue,' mV')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='psi'">
					<xsl:value-of select="concat(' - ',./quantityValue,' psi')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='psig'">
					<xsl:value-of select="concat(' - ',./quantityValue,' psig')"/>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='ohm'">
					<xsl:value-of select="concat(' - ',quantityValue)"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='in2'">
					<xsl:value-of select="concat(' - ',quantityValue, ' in')"/><fo:inline vertical-align="super" font-size="6pt">2</fo:inline><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='degF'">
					<xsl:value-of select="concat(' - ',quantityValue)"/><fo:inline font-family="Symbol">&#xB0; </fo:inline><xsl:text>F</xsl:text><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='degC'">
					<xsl:value-of select="concat(' - ',quantityValue)"/><fo:inline font-family="Symbol">&#xB0; </fo:inline><xsl:text>C</xsl:text><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='K'">
					<xsl:value-of select="concat(' - ',quantityValue, 'K')"/><!--&#x2126;-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='Mohm'">
					<xsl:value-of select="concat(' - ',quantityValue, ' M')"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--'M','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='mohm'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' milliohms')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' milliohm')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='uF'">
					<xsl:value-of select="concat(' - ',quantityValue, ' uF')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='pF'">
					<xsl:value-of select="concat(' - ',quantityValue, ' pF')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='lbm'">
					<xsl:value-of select="concat(' - ',quantityValue, ' lbs.')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='lbf'">
					<xsl:value-of select="concat(' - ',quantityValue, ' lbs. of force')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='mA'">
					<xsl:value-of select="concat(' - ',quantityValue, ' mA')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='mL'">
					<xsl:value-of select="concat(' - ',quantityValue, ' mL')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='A'">
					<xsl:value-of select="concat(' - ',quantityValue, ' A')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='lbf.in'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' inch-pounds')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' inch-pound')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure = 'in'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' inches')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' inch')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure = 'ft'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' feet')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' foot')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure = 'mi'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' miles')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' feet')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='um53'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' inch-ounces')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' inch-ounce')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure='ft.lbf'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' foot-pounds')"/><!--'m','&#x2126';-->
					</xsl:if>
					<xsl:if test="quantityValue &lt;= 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' foot-pound')"/><!--'m','&#x2126';-->
					</xsl:if>
				</xsl:if>
				<xsl:if test="@quantityUnitOfMeasure = 'mi/h'">
					<xsl:if test="quantityValue &gt; 1">
						<xsl:value-of select="concat(' - ',quantityValue, ' miles per hour')"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="not(./following-sibling::*[1][self::quantityGroup]) and not(./preceding-sibling::*[1][self::quantityGroup]) and not(./quantityTolerance)">
			<xsl:if test="@quantityUnitOfMeasure='um51'">
					<xsl:value-of select="concat(./quantityValue,' VDC')"/>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='um52'">
				<xsl:value-of select="concat(./quantityValue,' VAC')"/>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='mV'">
				<xsl:value-of select="concat(./quantityValue,' mV')"/>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='psi'">
				<xsl:value-of select="concat(./quantityValue,' psi')"/>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='psig'">
				<xsl:value-of select="concat(./quantityValue,' psig')"/>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='ohm'">
				<xsl:value-of select="quantityValue"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--&#x2126;-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='in2'">
				<xsl:value-of select="concat(quantityValue, ' in')"/><fo:inline vertical-align="super" font-size="6pt">2</fo:inline><!--&#x2126;-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='degF'">
				<xsl:value-of select="quantityValue"/><fo:inline font-family="Symbol">&#xB0;</fo:inline><xsl:text>F</xsl:text><!--&#x2126;-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='degC'">
				<xsl:value-of select="quantityValue"/><fo:inline font-family="Symbol">&#xB0;</fo:inline><xsl:text>C</xsl:text><!--&#x2126;-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='K'">
				<xsl:value-of select="concat(quantityValue, 'K')"/><!--&#x2126;-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='Mohm'">
				<xsl:value-of select="concat(quantityValue, ' M')"/><fo:inline font-family="Symbol">&#x2126;</fo:inline><!--'M','&#x2126';-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='mohm'">
				<xsl:if test="quantityValue &gt; 1">
					<xsl:value-of select="concat(quantityValue, ' milliohms')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="quantityValue &lt;= 1">
					<xsl:value-of select="concat(quantityValue, ' milliohm')"/><!--'m','&#x2126';-->
				</xsl:if>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='uF'">
				<xsl:value-of select="concat(quantityValue, ' uF')"/><!--'m','&#x2126';-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='pF'">
				<xsl:value-of select="concat(quantityValue, ' pF')"/><!--'m','&#x2126';-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='lbm'">
				<xsl:value-of select="concat(quantityValue, ' lbs.')"/><!--'m','&#x2126';-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='lbf'">
				<xsl:value-of select="concat(quantityValue, ' lbs. of force')"/><!--'m','&#x2126';-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='mA'">
				<xsl:value-of select="concat(quantityValue, ' mA')"/><!--'m','&#x2126';-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='mL'">
				<xsl:value-of select="concat(quantityValue, ' mL')"/><!--'m','&#x2126';-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='A'">
				<xsl:value-of select="concat(quantityValue, ' A')"/><!--'m','&#x2126';-->
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='lbf.in'">
				<xsl:if test="quantityValue &gt; 1">
					<xsl:value-of select="concat(quantityValue, ' inch-pounds')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="quantityValue &lt;= 1">
					<xsl:value-of select="concat(quantityValue, ' inch-pound')"/><!--'m','&#x2126';-->
				</xsl:if>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure = 'in'">
				<xsl:if test="quantityValue &gt; 1">
					<xsl:value-of select="concat(quantityValue, ' inches')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="quantityValue &lt;= 1">
					<xsl:value-of select="concat(quantityValue, ' inch')"/><!--'m','&#x2126';-->
				</xsl:if>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure = 'ft'">
				<xsl:if test="quantityValue &gt; 1">
					<xsl:value-of select="concat(quantityValue, ' feet')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="quantityValue &lt;= 1">
					<xsl:value-of select="concat(quantityValue, ' foot')"/><!--'m','&#x2126';-->
				</xsl:if>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure = 'mi'">
				<xsl:if test="quantityValue &gt; 1">
					<xsl:value-of select="concat(quantityValue, ' miles')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="quantityValue &lt;= 1">
					<xsl:value-of select="concat(quantityValue, ' mile')"/><!--'m','&#x2126';-->
				</xsl:if>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='um53'">
				<xsl:if test="quantityValue &gt; 1">
					<xsl:value-of select="concat(quantityValue, ' inch-ounces')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="quantityValue &lt;= 1">
					<xsl:value-of select="concat(quantityValue, ' inch-ounce')"/><!--'m','&#x2126';-->
				</xsl:if>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure='ft.lbf'">
				<xsl:if test="quantityValue &gt; 1">
					<xsl:value-of select="concat(quantityValue, ' foot-pounds')"/><!--'m','&#x2126';-->
				</xsl:if>
				<xsl:if test="quantityValue &lt;= 1">
					<xsl:value-of select="concat(quantityValue, ' foot-pound')"/><!--'m','&#x2126';-->
				</xsl:if>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure = 'mi/h'">
				<xsl:if test="quantityValue &gt; 1">
					<xsl:value-of select="concat(quantityValue, ' miles per hour')"/>
				</xsl:if>
				<xsl:if test="quantityValue &lt;= 1">
					<xsl:value-of select="concat(quantityValue, ' mile per hour')"/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure = 'rev/min'">
				<xsl:value-of select="concat(quantityValue, ' rpm')"/>
			</xsl:if>
			<xsl:if test="@quantityUnitOfMeasure = 'ft/s2'">
				<xsl:if test="quantityValue &gt; 1">
					<xsl:value-of select="concat(quantityValue, ' ft/sec')"/><fo:inline vertical-align="super" font-size="6">2</fo:inline>
				</xsl:if>
				<!--<xsl:if test="quantityValue &lt;= 1">
					<xsl:value-of select="concat(quantityValue, ' mile per hour')"/>
				</xsl:if>-->
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="//levelledPara/title">
		<fo:block space-after="8pt" keep-with-next="always" font-weight="bold">
			<fo:inline font-weight="bold">
				<!-- <xsl:value-of select="."/> -->
				<xsl:apply-templates/>
			</fo:inline>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="//levelledPara/title" mode="toc">
			<fo:inline>
			<!-- <xsl:value-of select="concat('&#x9;',./title, '&#x20;')"/> -->
				<!-- <xsl:value-of select="."/> -->
				<!-- <xsl:value-of select="concat('&#x9;','')"/> -->
				<xsl:apply-templates/>
				<fo:leader leader-pattern="dots"/>
				<!-- <xsl:value-of select="concat('&#x20;','')"/> -->
			</fo:inline>
	</xsl:template>
	
	<xsl:template match="commonInfo">
		<fo:block space-before="2mm" font-size="12pt" font-weight="bold" font-style="italic"
			keep-with-next="always" text-align="center" id="common-01">Common information</fo:block>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="isolationProcedure">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="processing-instruction(Pub)">
			&#xA;
	</xsl:template>

	<xsl:template match="closeRqmts">
		<xsl:variable name="closeId">
			<xsl:if test="parent::procedure">
				<xsl:value-of select="concat('close','req-01')"/>
			</xsl:if>
			<xsl:if test="parent::isolationProcedure">
				<xsl:value-of select="concat(../../@id,'-closereqs')"/>
			</xsl:if>
		</xsl:variable>
		<fo:block font-size="12pt" font-weight="bold" font-style="italic" text-align="center"
			space-before="5mm" space-after="2mm" keep-with-next="always" id="{$closeId}">Closing
			requirements</fo:block><!--id="clsrqt-01"-->
		<fo:block>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="preliminaryRqmts">
		<xsl:variable name="prelId">
			<xsl:if test="parent::procedure">
				<xsl:value-of select="concat('pre','lreq-01')"/>
			</xsl:if>
			<xsl:if test="parent::isolationProcedure">
				<xsl:value-of select="concat(../../@id,'-prelreqs')"/>
			</xsl:if>
		</xsl:variable>
		<fo:block font-size="12pt" font-weight="bold" font-style="italic" text-align="center"
			space-before="2mm" space-after="2mm" keep-with-next="always" id="{$prelId}">Preliminary Requirements</fo:block><!--id="prelreqs-01"-->
		<xsl:apply-templates/>
	</xsl:template>
		
	<xsl:template match="verbatimText">
		<xsl:if test="@verbatimStyle = 'vs01'">
			<fo:inline font-family="monospace" font-weight="bold">
				<xsl:value-of select="."/>
			</fo:inline>
		</xsl:if>
		<xsl:if test="not(@verbatimStyle = 'vs01')">
			<fo:block white-space-treatment="preserve" linefeed-treatment="preserve" font-size="10pt" font-family="monospace" font-weight="bold" space-after="3pt" keep-with-previous="always" margin-left="6mm">
				<xsl:analyze-string select="." regex="(&lt;/?)([^\s>]+)(>?)">
					<xsl:matching-substring>
						<fo:inline white-space-treatment="preserve" linefeed-treatment="preserve" color="#0000FF"><xsl:value-of select="concat(regex-group(1),'&#xFEFF;',regex-group(2),
							if (regex-group(3)) then '&#xFEFF;>' else '')"/></fo:inline><!--blue text-->
					</xsl:matching-substring>
					<xsl:non-matching-substring>
						<xsl:analyze-string select="." regex="(\s)([^=&lt;]+=['&quot;])([^'&quot;]+)(['&quot;])(>?)">
							<xsl:matching-substring>
								<xsl:value-of select="regex-group(1)"/>
								<fo:inline white-space-treatment="preserve" linefeed-treatment="preserve"  color="#FF0000"><xsl:value-of select="regex-group(2)"/></fo:inline><!--red text-->
								<xsl:value-of select="regex-group(3)"/>
								<fo:inline  white-space-treatment="preserve" linefeed-treatment="preserve" color="#FF0000"><xsl:value-of select="regex-group(4)"/></fo:inline>
									<!-- <xsl:value-of select="concat(regex-group(4),
									if (regex-group(5)) then '&#xFEFF;>' else '')"/> -->
									<!-- broke out group(5) into seperate in-line to make the closing '>' blue-->
									<fo:inline color="#0000FF">
										<xsl:value-of select="regex-group(5)"/>
									</fo:inline>
							</xsl:matching-substring>
							<xsl:non-matching-substring>
								<xsl:value-of select="."/>
							</xsl:non-matching-substring>
						</xsl:analyze-string>
					</xsl:non-matching-substring>
				</xsl:analyze-string>                            
			</fo:block>
		</xsl:if>
    </xsl:template>
	
	<xsl:template match="internalRef">
		<xsl:variable name="refId" select="./@internalRefId"/>
		<fo:inline>
			<fo:basic-link internal-destination="{$refId}" color="blue" text-decoration="underline">
				<xsl:value-of select="."/>
			</fo:basic-link>
		</fo:inline>
	</xsl:template>
	
	<xsl:template match="internalRef[@internalRefTargetType='hotspot']">
		<xsl:variable name="refId" select="./@internalRefId"/>
		<fo:inline>
			<xsl:value-of select="."/>
		</fo:inline>
	</xsl:template>
	
	<xsl:template match="internalRef[parent::action][@internalRefTargetType='step']">
		<xsl:variable name="refId" select="@internalRefId"/>
		<fo:inline>
			<fo:basic-link internal-destination="{$refId}" color="blue">
				<xsl:text>Step </xsl:text> 
				<xsl:apply-templates select="key('isoSteps',$refId)" mode="nbr"/>
			</fo:basic-link>
		</fo:inline>    
	</xsl:template>
	
	<xsl:template match="internalRef[not(parent::action)][@internalRefTargetType='step']">
        <xsl:variable name="refId" select="@internalRefId"/>
        <fo:inline>
            <fo:basic-link internal-destination="{$refId}" color="blue" 
                text-decoration="underline">
                <xsl:text>Step </xsl:text> 
                <xsl:apply-templates select="key('procSteps', $refId)" mode="nbr"/>
            </fo:basic-link>
        </fo:inline>    
	</xsl:template>
	
	<!--<xsl:template match="internalRef[@internalRefTargetType='step']">
		<xsl:variable name="refId" select="@internalRefId"/>
		<fo:inline>
			<fo:basic-link internal-destination="{$refId}" color="blue" 
				text-decoration="underline">
				<xsl:text>Step </xsl:text> 
				<xsl:apply-templates select="key('procSteps', $refId)" mode="nbr"/>
			</fo:basic-link>
		</fo:inline>    
	</xsl:template>-->
	
	<xsl:template match="internalRef[@internalRefTargetType='para']">
        <xsl:variable name="refId" select="@internalRefId"/>
        <fo:inline>
            <fo:basic-link internal-destination="{$refId}" color="blue" 
                text-decoration="underline">
                <xsl:text>Para </xsl:text> 
                <xsl:apply-templates select="//levelledPara[@id=$refId]" mode="nbr"/>
            </fo:basic-link>
        </fo:inline>    
	</xsl:template>
	
	<xsl:template match="internalRef[@internalRefTargetType = 'supequip']">
		<xsl:variable name="refId" select="@internalRefId"/>
		<fo:inline>
			<fo:basic-link internal-destination="{$refId}" color="blue">
				<!--<xsl:text>Table </xsl:text>--> 
				<xsl:apply-templates select="//supportEquipDescr[@id=$refId]" mode="ref"/>
			</fo:basic-link>
		</fo:inline>
	</xsl:template>
	
	<xsl:template match="internalRef[@internalRefTargetType = 'supply']">
		<xsl:variable name="refId" select="@internalRefId"/>
		<fo:inline>
			<fo:basic-link internal-destination="{$refId}" color="blue">
				<!--<xsl:text>Table </xsl:text>--> 
				<xsl:apply-templates select="//supplyDescr[@id=$refId]" mode="ref"/>
			</fo:basic-link>
		</fo:inline>
	</xsl:template>
	
	<xsl:template match="internalRef[@internalRefTargetType='table']">
        <xsl:variable name="refId" select="@internalRefId"/>
        <fo:inline>
            <fo:basic-link internal-destination="{$refId}" color="blue" 
                text-decoration="underline">
                <xsl:text>Table </xsl:text> 
                <xsl:apply-templates select="//table[@id=$refId]" mode="nbr"/>
            </fo:basic-link>
        </fo:inline>    
    </xsl:template>
	
	<xsl:template match="internalRef[@internalRefTargetType='figure']">
        <xsl:variable name="refId" select="@internalRefId"/>
        <fo:inline>
            <fo:basic-link internal-destination="{$refId}" color="blue">
                <xsl:text>Figure </xsl:text> 
                <xsl:apply-templates select="//figure[@id=$refId]" mode="nbr"/>
            </fo:basic-link>
        </fo:inline>    
	</xsl:template>
	
	<xsl:template match="supportEquipDescr" mode="ref">
		<xsl:value-of select="./name"/>
	</xsl:template>
	
	<xsl:template match="supplyDescr" mode="ref">
		<xsl:value-of select="./name"/>
	</xsl:template>
	
	<xsl:template match="proceduralStep/title">
		<!--<xsl:apply-templates/>-->
	</xsl:template>
	
	<xsl:template match="proceduralStep/warning"></xsl:template>
	<xsl:template match="proceduralStep/caution"></xsl:template>
	<xsl:template match="proceduralStep/note"></xsl:template>

	<xsl:template match="proceduralStep" mode="nbr">
        <xsl:variable name="origNbr">
            <!--<xsl:number level="multiple" format="1.a.1.a.1"/> -->
        	<xsl:number level="multiple" format="1.1.1.1"/> 
        </xsl:variable>
		<xsl:value-of select="$origNbr"/>
        <!--<xsl:for-each select="tokenize($origNbr,'\.')">
            <xsl:value-of select="if (position()=(3,4)) then concat('(',.,')') 
                else if (position()=5) then . else concat(.,'.')"/>
        </xsl:for-each>-->
    </xsl:template>
	
	<xsl:template match="table" mode="nbr">
        <xsl:variable name="origNbr">
            <xsl:number level="any" format="1"/>            
        </xsl:variable>
        <xsl:value-of select="$origNbr"/>
    </xsl:template>
	
	<xsl:template match="figure" mode="nbr">
        <xsl:variable name="origNbr">
            <xsl:number level="any" format="1"/>            
        </xsl:variable>
        <xsl:value-of select="$origNbr"/>
    </xsl:template>
	
	<xsl:template match="levelledPara" mode="nbr">
        <xsl:variable name="origNbr">
            <xsl:number level="multiple" format="1.1.1.1.1"/>            
        </xsl:variable>
        <!-- <xsl:for-each select="tokenize($origNbr,'\.')">
            <xsl:value-of select="if (position()=(3,4)) then concat('(',.,')') 
                else if (position()=5) then . else concat(.,'.')"/>
        </xsl:for-each> -->
		<xsl:value-of select="$origNbr"/>
    </xsl:template>
	
	<xsl:template match="superScript">
		<fo:inline vertical-align="super" font-size="6pt">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>

	<xsl:template match="reqCondGroup">
		<!-- create table here, then for each reqCondDm or reqCondNoRef make table rows -->
		<fo:block font-weight="bold" text-align="left" space-after="1.5mm" keep-with-next="always"
			>Required conditions</fo:block>
		<fo:block space-after="3mm" font-size="10pt" keep-with-previous="always">
			<fo:table table-layout="fixed" width="100%" space-after="2mm">
				<fo:table-column column-width="50%"/>
				<fo:table-column column-width="50%"/>
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Condition</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Data Module</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-footer>
					<fo:table-row>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-footer>
				<fo:table-body>
					<xsl:for-each select="./noConds">
						<fo:table-row>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block>None</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block/>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
					<xsl:for-each select="./reqCondNoRef">
						<fo:table-row>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block>
									<xsl:value-of select="./reqCond"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block/>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
					<xsl:for-each select="./reqCondDm">
						<fo:table-row>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block>
									<!--<xsl:value-of select="./reqCond"/>-->
									<xsl:apply-templates select="./reqCond"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block>
									<xsl:apply-templates select="./dmRef"/>
									<!--<xsl:for-each select="./dmRef">
										<xsl:variable name="dmc" select="concat(dmRefIdent//dmCode/@modelIdentCode,'-',dmRefIdent//dmCode/@systemDiffCode, '-', dmRefIdent//dmCode/@systemCode, '-',dmRefIdent//dmCode/@subSystemCode,dmRefIdent//dmCode/@subSubSystemCode,'-',dmRefIdent//dmCode/@assyCode,'-',dmRefIdent//dmCode/@disassyCode,dmRefIdent/dmCode/@disassyCodeVariant,'-',dmRefIdent//dmCode/@infoCode,dmRefIdent//dmCode/@infoCodeVariant,'-',dmRefIdent//dmCode/@itemLocationCode)"/>
										<xsl:variable name="dmcPdf" select="concat('DMC-',$dmc,'.pdf')"/>
										<xsl:choose>
											<xsl:when test="descendant::wrapper">
												<fo:inline background-color="yellow" color="blue">
													<fo:basic-link external-destination="{$dmcPdf}"><xsl:value-of select="$dmc"/></fo:basic-link>
												</fo:inline>
											</xsl:when>
											<xsl:otherwise>
												<fo:inline color="blue">
													<fo:basic-link external-destination="{$dmcPdf}"><xsl:value-of select="$dmc"/></fo:basic-link>
												</fo:inline>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>-->
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="wrapper">
		<fo:inline background-color="yellow">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	
	<xsl:template match="reqCond">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="reqSupportEquips">
		<!-- create table here, then for each reqCondDm or reqCondNoRef make table rows -->
		<fo:block font-weight="bold" text-align="left" space-after="1.5mm" keep-with-next="always"
			>Support equipment</fo:block>
		<fo:block space-after="3mm" font-size="10pt" keep-with-previous="always">
			<fo:table table-layout="fixed" width="100%" space-after="2mm">
				<fo:table-column column-width="30%"/>
				<fo:table-column column-width="30%"/>
				<fo:table-column column-width="20%"/>
				<fo:table-column column-width="20%"/>
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Nomenclature</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Identification no.</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Qty</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Remarks</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-footer>
					<fo:table-row>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-footer>
				<fo:table-body>
					<xsl:if test="./noSupportEquips">
						<fo:table-row>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block>None</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block> </fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="./supportEquipDescrGroup">
						<xsl:for-each select="./supportEquipDescrGroup/supportEquipDescr">
							<xsl:variable name="sid" select="@id"/>
							<fo:table-row>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block id="{$sid}">
										<xsl:value-of select="./name"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block>
										<xsl:value-of select="./identNumber/partAndSerialNumber/partNumber"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block>
										<xsl:value-of select="./reqQuantity"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block> </fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</xsl:if>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template match="reqSupplies">
		<!-- create table here, then for each reqCondDm or reqCondNoRef make table rows -->
		<fo:block font-weight="bold" text-align="left" keep-with-next="always" space-after="1.5mm"
			>Consumables, materials, and expendables</fo:block>
		<fo:block keep-with-previous="always" space-after="3mm" font-size="10pt">
			<fo:table table-layout="fixed" width="100%" space-after="2mm">
				<fo:table-column column-width="30%"/>
				<fo:table-column column-width="30%"/>
				<fo:table-column column-width="20%"/>
				<fo:table-column column-width="20%"/>
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Nomenclature</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Identification no.</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Qty</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Remarks</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-footer>
					<fo:table-row>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-footer>
				<fo:table-body>
					<xsl:if test="./noSupplies">
						<fo:table-row>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block>None</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block> </fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="./supplyDescrGroup">
						<xsl:for-each select="./supplyDescrGroup/supplyDescr">
							<xsl:variable name="sid" select="@id"/>
							<fo:table-row>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block id="{$sid}">
										<xsl:value-of select="./name"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block>
										<xsl:value-of select="./identNumber/partAndSerialNumber/partNumber"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block>
										<xsl:value-of select="./reqQuantity"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block> </fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</xsl:if>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template match="reqSpares">
		<!-- create table here, then for each reqCondDm or reqCondNoRef make table rows -->
		<fo:block font-weight="bold" text-align="left" keep-with-next="always" space-after="1.5mm"
			>Spares</fo:block>
		<fo:block space-after="3mm" font-size="10pt" keep-with-previous="always">
			<fo:table table-layout="fixed" width="100%" space-after="2mm">
				<fo:table-column column-width="30%"/>
				<fo:table-column column-width="30%"/>
				<fo:table-column column-width="20%"/>
				<fo:table-column column-width="20%"/>
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Nomenclature</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Identification no.</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Qty</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1pt" padding-bottom="1pt"
							border-top-style="solid" border-top-color="black"
							border-bottom-style="solid" border-bottom-color="black"
							border-collapse="collapse">
							<fo:block>Remarks</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-footer>
					<fo:table-row>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
						<fo:table-cell border-top-style="solid" border-top-color="black"
							border-collapse="collapse">
							<fo:block/>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-footer>
				<fo:table-body>
					<xsl:if test="./noSpares">
						<fo:table-row>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block>None</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell padding-top="1pt" padding-bottom="1pt">
								<fo:block> </fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="./spareDescrGroup">
						<xsl:for-each select="./spareDescrGroup/spareDescr">
							<xsl:variable name="sid" select="@id"/>
							<fo:table-row>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block id="{$sid}">
										<xsl:value-of select="./name"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block>
										<xsl:value-of select="./identNumber/partAndSerialNumber/partNumber"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block>
										<xsl:value-of select="./reqQuantity"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block> </fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</xsl:if>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template match="reqSafety">
		<fo:block font-weight="bold" text-align="left" keep-with-next="always" space-after="1.5mm"
			>Safety conditions</fo:block>
		<xsl:if test="./noSafety">
			<fo:block>None</fo:block>
		</xsl:if>
		<xsl:if test="./safetyRqmts">
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="warning">
		<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
			text-align="center"> WARNING </fo:block>
		<xsl:apply-templates/>
		<!--<xsl:choose>
			<xsl:when test="count(./warningAndCautionPara) > 1">
				<fo:list-block margin-left="5mm" space-before="2pt" space-after="2pt">
					<xsl:for-each select="./warningAndCautionPara">
						<fo:list-item>
							<fo:list-item-label end-indent="label-end()">
								<fo:block>&#x2022;</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()">
								<fo:block hyphenate="false">
									<xsl:apply-templates/>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</xsl:for-each>
				</fo:list-block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>-->
	</xsl:template>

	<xsl:template match="caution">
		<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
			text-align="center"> CAUTION </fo:block>
		<!--<xsl:apply-templates/>-->
		<xsl:choose>
			<xsl:when test="count(./warningAndCautionPara) > 1">
				<fo:list-block margin-left="5mm" space-before="4pt">
					<xsl:for-each select="./warningAndCautionPara">
						<fo:list-item>
							<fo:list-item-label end-indent="label-end()">
								<fo:block>&#x2022;</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()">
								<fo:block>
									<xsl:apply-templates/>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</xsl:for-each>
				</fo:list-block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="warningAndCautionPara">
		<fo:block font-size="10pt" space-after="2pt" space-before="2pt" hyphenate="false">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="isolationMainProcedure">
		<fo:block space-before="4mm" keep-with-next="always" font-size="12pt" font-weight="bold"
			font-style="italic" text-align="center">Procedure</fo:block> <!--id="proc-01"-->
		<fo:block space-after="5mm">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
	<!--<xsl:template match="proceduralStep" mode="nbr">
		<xsl:variable name="origNbr">
			<!-\-<xsl:number level="multiple" format="1.a.1.a.1"/> -\->
			<xsl:number level="multiple" format="1.1.1.1"/> 
		</xsl:variable>
		<xsl:for-each select="tokenize($origNbr,'\.')">
			<xsl:value-of select="if (position()=(3,4)) then concat('(',.,')') 
				else if (position()=5) then . else concat(.,'.')"/>
		</xsl:for-each>
	</xsl:template>-->
	
	<xsl:template match="isolationStep | isolationProcedureEnd" mode="nbr">
		<xsl:variable name="origNbr">
			<xsl:number level="single" format="1" count="*"/>            
		</xsl:variable>
		<xsl:value-of select="$origNbr"/>
	</xsl:template>

	<xsl:template match="isolationStep | isolationProcedureEnd">
		<xsl:for-each select="note">
			<fo:block font-weight="bold">Note</fo:block>
			<xsl:apply-templates/>
		</xsl:for-each>
		<xsl:for-each select="caution">
			<fo:block font-weight="bold" text-align="center">CAUTION</fo:block>
			<xsl:apply-templates/>
		</xsl:for-each>
		<xsl:for-each select="warning">
			<fo:block font-weight="bold" text-align="center">WARNING</fo:block>
			<xsl:apply-templates/>
		</xsl:for-each>
		<fo:block id="{@id}" padding="5pt" font-size="10pt">
			<!-- border-style="solid"
				  border-width=".1mm"-->
			<!--<xsl:apply-templates/>-->
			<fo:list-block space-after="2mm">
				<fo:list-item>
					<fo:list-item-label end-indent="label-end()">
						<fo:block>
							<xsl:number level="multiple" count="isolationMainProcedure/isolationStep | isolationProcedureEnd" format="1."/>
						</fo:block>
					</fo:list-item-label>
					<fo:list-item-body start-indent="body-start()">
						<fo:block>
							<!--<xsl:apply-templates select="title"/>-->
							<xsl:choose>
								<xsl:when test="count(action) &gt; 1">
									<xsl:for-each select="action">
										<fo:list-block space-after="2mm">
											<fo:list-item>
												<fo:list-item-label end-indent="label-end()">
												<fo:block>
												<xsl:number format="a."/>
												</fo:block>
												</fo:list-item-label>
												<fo:list-item-body start-indent="body-start()">
												<fo:block>
												<xsl:apply-templates/>
												</fo:block>
												</fo:list-item-body>
											</fo:list-item>
										</fo:list-block>
										<!--<xsl:apply-templates/>-->
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<xsl:for-each select="action">
										<fo:block>
											<xsl:apply-templates/>
										</fo:block>
										<!--<xsl:apply-templates/>-->
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:apply-templates select="isolationStepQuestion"/>
							<xsl:apply-templates select="isolationStepAnswer"/>
						</fo:block>
					</fo:list-item-body>
				</fo:list-item>
			</fo:list-block>
		</fo:block>
	</xsl:template>

	<!-- <xsl:template match="title">
		<fo:block keep-with-next="always" font-weight="bold">
			
			<xsl:value-of select="."/>
		</fo:block>
	</xsl:template> -->

	<xsl:template match="action">
		<fo:block border-style="solid" border-color="blue" border-width=".1mm">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="isolationStepQuestion">
		<fo:block font-weight="bold">
			<xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="yesNoAnswer">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="yesAnswer">
		<xsl:variable name="ref" select="@nextActionRefId"/>
		<fo:block space-before="4pt" space-after="4pt" keep-with-previous="always">
			<fo:inline><xsl:text>Yes: Go to </xsl:text>
				<fo:basic-link internal-destination="{@nextActionRefId}" color="blue">Step  <!--<xsl:value-of select="$yesref2"/>-->
					<xsl:apply-templates select="key('isoSteps',$ref)" mode="nbr"/>
				</fo:basic-link></fo:inline>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="noAnswer">
		<xsl:variable name="ref" select="@nextActionRefId"/>
		<fo:block keep-with-previous="always">
			<fo:inline>
				<xsl:text>No: Go to </xsl:text>
				<fo:basic-link internal-destination="{@nextActionRefId}" color="blue">Step 
					<xsl:apply-templates select="key('isoSteps',$ref)" mode="nbr"/>
				</fo:basic-link></fo:inline>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="isolationStepAnswer">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="listOfChoices">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="table">
		<xsl:variable name="TId" select="@id"/>
		<xsl:variable name="tCount">
			<xsl:number level="any" count="table" format="1"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="name(..) = 'proceduralStep' or name(..) = 'levelledPara'">
				<fo:table table-layout="fixed" width="93%" id="{$TId}" margin-left="-10mm"><!--margin-left="-10mm" -->
					<fo:table-column column-width="proportional-column-width(1)"/>
					<fo:table-header>
						<fo:table-row>
							<fo:table-cell>
								<xsl:if test="title/text()">
									<fo:block keep-with-next="always" text-align="center" padding-top="8pt" padding-bottom="2pt" space-after="2pt" margin-left="-10mm">
										<fo:inline font-style="italic">Table <xsl:value-of select="$tCount"/>
											<xsl:value-of select="concat(' - ', ./title)"/></fo:inline>
										<fo:retrieve-table-marker retrieve-class-name="tab-cont" 
											retrieve-position-within-table="first-starting" 
											retrieve-boundary-within-table="table"/>
									</fo:block>
								</xsl:if>
								<xsl:if test="not(title/text())">
									<fo:block keep-with-next="always" text-align="center" space-after="2pt">
										<fo:inline font-style="italic">Table <xsl:value-of select="$tCount"/>
										</fo:inline>
										<fo:retrieve-table-marker retrieve-class-name="tab-cont" 
											retrieve-position-within-table="first-starting" 
											retrieve-boundary-within-table="table"/>
									</fo:block>
								</xsl:if>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:marker marker-class-name="tab-cont"/>
								<fo:block/>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:marker marker-class-name="tab-cont">&#x00A0;- (Continued)</fo:marker>
								<fo:block keep-with-previous="always">
									<fo:marker marker-class-name="tab-cont">&#x00A0;- (Continued)</fo:marker>
									<fo:table table-layout="fixed" width="100%">
										<xsl:for-each select="./tgroup/colspec">
											<fo:table-column column-width="proportional-column-width({@colwidth})"/>
										</xsl:for-each>
										<fo:table-header>
											<xsl:for-each select="./tgroup/thead/row">
												<fo:table-row>
													<xsl:apply-templates/>
												</fo:table-row>
											</xsl:for-each>
										</fo:table-header>
										<fo:table-footer>
											<fo:table-row>
												<xsl:for-each select="./tgroup/thead/row[1]/entry"><!--[position() &gt; 1]-->
													<fo:table-cell border-top-style="solid" border-top-color="black" border-collapse="collapse">
														<fo:block/>
													</fo:table-cell>
												</xsl:for-each>
											</fo:table-row>
										</fo:table-footer>
										<fo:table-body>
											<xsl:for-each select="./tgroup/tbody/row">
												<fo:table-row>
													<xsl:apply-templates/>
												</fo:table-row>
											</xsl:for-each>
											<xsl:if test="./tgroup/tfoot">
												<xsl:for-each select="./tgroup/tfoot/row">
													<fo:table-row>
														<xsl:apply-templates/>
													</fo:table-row>
												</xsl:for-each>
											</xsl:if>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</xsl:when>
			<xsl:otherwise>
				<fo:table table-layout="fixed" width="100%" id="{$TId}"><!--margin-left="-10mm" -->
					<fo:table-column column-width="proportional-column-width(1)"/>
					<fo:table-header>
						<fo:table-row>
							<fo:table-cell>
								<xsl:if test="title/text()">
									<fo:block keep-with-next="always" text-align="center" padding-top="8pt" padding-bottom="2pt" space-after="2pt">
										<fo:inline font-style="italic">Table <xsl:value-of select="$tCount"/>
											<xsl:value-of select="concat(' - ', ./title)"/></fo:inline>
										<fo:retrieve-table-marker retrieve-class-name="tab-cont" 
											retrieve-position-within-table="first-starting" 
											retrieve-boundary-within-table="table"/>
									</fo:block>
								</xsl:if>
								<xsl:if test="not(title/text())">
									<fo:block keep-with-next="always" text-align="center" space-after="2pt">
										<fo:inline font-style="italic">Table <xsl:value-of select="$tCount"/>
										</fo:inline>
										<fo:retrieve-table-marker retrieve-class-name="tab-cont" 
											retrieve-position-within-table="first-starting" 
											retrieve-boundary-within-table="table"/>
									</fo:block>
								</xsl:if>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:marker marker-class-name="tab-cont"/>
								<fo:block/>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:marker marker-class-name="tab-cont">&#x00A0;- (Continued)</fo:marker>
								<fo:block keep-with-previous="always">
									<fo:marker marker-class-name="tab-cont">&#x00A0;- (Continued)</fo:marker>
									<fo:table table-layout="fixed" width="100%">
										<xsl:for-each select="./tgroup/colspec">
											<fo:table-column column-width="proportional-column-width({@colwidth})"/>
										</xsl:for-each>
										<fo:table-header>
											<xsl:for-each select="./tgroup/thead/row">
												<fo:table-row>
													<xsl:apply-templates/>
												</fo:table-row>
											</xsl:for-each>
										</fo:table-header>
										<fo:table-footer>
											<fo:table-row>
												<xsl:for-each select="./tgroup/thead/row[1]/entry"><!--[position() &gt; 1]-->
													<fo:table-cell border-top-style="solid" border-top-color="black" border-collapse="collapse">
														<fo:block/>
													</fo:table-cell>
												</xsl:for-each>
											</fo:table-row>
										</fo:table-footer>
										<fo:table-body>
											<xsl:for-each select="./tgroup/tbody/row">
												<fo:table-row>
													<xsl:apply-templates/>
												</fo:table-row>
											</xsl:for-each>
											<xsl:if test="./tgroup/tfoot">
												<xsl:for-each select="./tgroup/tfoot/row">
													<fo:table-row>
														<xsl:apply-templates/>
													</fo:table-row>
												</xsl:for-each>
											</xsl:if>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template match="colspec" mode="position">
		<xsl:number format="1"/>
	</xsl:template>
	
	<xsl:template match="entry">
		<xsl:choose>
			<xsl:when test="@nameend and @namest and @morerows and ancestor::proceduralStep">
				<xsl:variable name="stname" select="@namest"/>
				<xsl:variable name="endname" select="@nameend"/>
				<xsl:variable name="cname" select="@colname"/>
				<xsl:variable name="start">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $stname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="end">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $endname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="colnum">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $cname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="diff" select="($end - $start)+1"/>
				<!--number-columns-spanned="$end - $start" -->
				<xsl:choose>
					<xsl:when test="parent::row[parent::thead]">
						<fo:table-cell column-number="{$colnum}" number-rows-spanned="{@morerows + 1}" number-columns-spanned="{$diff}" display-align="after" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block font-weight="bold" text-align="left" margin-left="-8mm"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:when>
					<xsl:otherwise>
						<fo:table-cell column-number="{$colnum}" number-rows-spanned="{@morerows + 1}" number-columns-spanned="{$diff}" display-align="before" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block text-align="left" margin-left="-8mm"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@nameend and @namest and @morerows and not(ancestor::proceduralStep)">
				<xsl:variable name="stname" select="@namest"/>
				<xsl:variable name="endname" select="@nameend"/>
				<xsl:variable name="cname" select="@colname"/>
				<xsl:variable name="start">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $stname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="end">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $endname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="colnum">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $cname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="diff" select="($end - $start)+1"/>
				<!--number-columns-spanned="$end - $start" -->
				<xsl:choose>
					<xsl:when test="parent::row[parent::thead]">
						<fo:table-cell column-number="{$colnum}" number-rows-spanned="{@morerows + 1}" number-columns-spanned="{$diff}" display-align="after" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block font-weight="bold" text-align="left"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:when>
					<xsl:otherwise>
						<fo:table-cell column-number="{$colnum}" number-rows-spanned="{@morerows + 1}" number-columns-spanned="{$diff}" display-align="before" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block text-align="left"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@nameend and @namest and ancestor::proceduralStep">
				<xsl:variable name="stname" select="@namest"/>
				<xsl:variable name="endname" select="@nameend"/>
				<xsl:variable name="cname" select="@colname"/>
				<xsl:variable name="start">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $stname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="end">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $endname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="colnum">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $cname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="diff" select="($end - $start)+1"/>
				<!--number-columns-spanned="$end - $start" -->
				<xsl:choose>
					<xsl:when test="parent::row[parent::thead]">
						<fo:table-cell column-number="{$colnum}" number-columns-spanned="{$diff}" display-align="after" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block font-weight="bold" text-align="left" margin-left="-8mm"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:when>
					<xsl:otherwise>
						<fo:table-cell column-number="{$colnum}" number-columns-spanned="{$diff}" display-align="before" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block text-align="left" margin-left="-8mm"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@nameend and @namest and not(ancestor::proceduralStep)">
				<xsl:variable name="stname" select="@namest"/>
				<xsl:variable name="endname" select="@nameend"/>
				<xsl:variable name="cname" select="@colname"/>
				<xsl:variable name="start">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $stname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="end">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $endname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="colnum">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $cname]" mode="position"/>
				</xsl:variable>
				<xsl:variable name="diff" select="($end - $start)+1"/>
				<!--number-columns-spanned="$end - $start" -->
				<xsl:choose>
					<xsl:when test="parent::row[parent::thead]">
						<fo:table-cell column-number="{$colnum}" number-columns-spanned="{$diff}" display-align="after" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block font-weight="bold" text-align="left"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:when>
					<xsl:otherwise>
						<fo:table-cell column-number="{$colnum}" number-columns-spanned="{$diff}" display-align="before" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block text-align="left"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@morerows">
				<xsl:variable name="cname" select="@colname"/>
				<xsl:variable name="colnum">
					<xsl:apply-templates select="ancestor::table[1]/tgroup/colspec[@colname = $cname]" mode="position"/>
				</xsl:variable>
				<!--number-columns-spanned="$end - $start" -->
				<xsl:choose>
					<xsl:when test="parent::row[parent::thead]">
						<fo:table-cell column-number="{$colnum}" number-rows-spanned="{@morerows + 1}" display-align="after" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block font-weight="bold" text-align="left" margin-left="-8mm"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:when>
					<xsl:otherwise>
						<fo:table-cell column-number="{$colnum}" number-rows-spanned="{@morerows + 1}" display-align="before" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block text-align="left" margin-left="-8mm"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="parent::row[parent::thead] and ancestor::proceduralStep">
						<fo:table-cell  display-align="after" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block font-weight="bold" text-align="left" margin-left="-8mm"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:when>
					<xsl:when test="parent::row[parent::thead] and not(ancestor::proceduralStep)">
						<fo:table-cell  display-align="after" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
							<fo:block font-weight="bold" text-align="left"><!-- margin-left="-6mm"-->
								<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
								<xsl:apply-templates/>
								<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
							</fo:block>
						</fo:table-cell>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="ancestor::proceduralStep">
								<fo:table-cell  display-align="before" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
									<fo:block text-align="left" margin-left="-8mm"><!-- margin-left="-6mm"-->
										<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
										<xsl:apply-templates/>
										<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
									</fo:block>
								</fo:table-cell>
							</xsl:when>
							<xsl:otherwise>
								<fo:table-cell  display-align="before" padding="2pt 2pt 2pt 2pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
									<fo:block text-align="left"><!-- margin-left="-6mm"-->
										<!--<xsl:for-each select="./tgroup/thead/row/entry[1]">-->
										<xsl:apply-templates/>
										<!--</xsl:for-each>--><!-- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -->
									</fo:block>
								</fo:table-cell>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="table[@tabstyle='3col']">
		<xsl:for-each select=".">
			<xsl:variable name="TId" select="@id"/>
			<xsl:variable name="tCount">
				<xsl:number level="any" count="table" format="1"/>
			</xsl:variable>
			<xsl:if test="./title">
				<fo:block keep-with-next="always" text-align="center" space-after="2pt">
					<fo:inline font-style="italic">Table <xsl:value-of select="$tCount"/><xsl:value-of select="concat(' - ', ./title)"/></fo:inline>
				</fo:block>
			</xsl:if>
			<fo:block id="{$TId}" space-before="2pt" space-after="4mm">
				<fo:table table-layout="fixed"  width="100%" margin-left="0mm">
					<fo:table-header>
						<fo:table-row>
							<xsl:for-each select="./tgroup/thead/row/entry">
								<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-left-style="solid" border-right-color="black" border-left-color="black" border-collapse="collapse" display-align="after">
									<fo:block font-weight="bold" text-align="left" margin-left="-18mm">
										<xsl:value-of select="para"/>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
							<!-- <fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-collapse="collapse">
								<fo:block font-weight="bold" text-align="left" margin-left="-18mm">
								<xsl:value-of select="./tgroup/thead/row/entry[2]/para"/>
								</fo:block>
								</fo:table-cell> -->
						</fo:table-row>
					</fo:table-header>
					<fo:table-footer>
						<fo:table-row>
							<fo:table-cell border-top-style="solid" border-top-color="black" border-collapse="collapse">
								<fo:block/>
							</fo:table-cell>
							<fo:table-cell border-top-style="solid" border-top-color="black" border-collapse="collapse">
								<fo:block/>
							</fo:table-cell>
							<fo:table-cell border-top-style="solid" border-top-color="black" border-collapse="collapse">
								<fo:block/>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-footer>
					<fo:table-body>
						<xsl:for-each select="./tgroup/tbody/row">
							<fo:table-row>
								<xsl:for-each select="entry">
									<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black">
										<fo:block margin-left="-18mm">
											<xsl:for-each select="para">
												<xsl:apply-templates/>
											</xsl:for-each>
										</fo:block>
									</fo:table-cell>
								</xsl:for-each>
								<!-- <fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block margin-left="-18mm">
									<xsl:for-each select="./entry[2]/para">
									<xsl:apply-templates/>
									</xsl:for-each>
									</fo:block>
									</fo:table-cell> -->
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="para">
		<xsl:if test="@caveat = 'cv01'">
			<fo:block font-weight="normal" line-height="1.25" space-before="4pt" space-after="4pt" font-size="10pt" margin-left="6mm" keep-with-previous="always">
				<xsl:apply-templates/>
			</fo:block>
		</xsl:if>
		<xsl:if test="not(@caveat = 'cv01')">
			<xsl:if test="./verbatimText[not(@verbatimStyle='vs01')]">
				<fo:block font-size="10pt" font-weight="normal" line-height="1.25" space-before="4pt" space-after="4pt" text-align="left">
					<xsl:apply-templates/>
				</fo:block>
			</xsl:if>
			<xsl:if test="not(./verbatimText[not(@verbatimStyle='vs01')])">
				<fo:block font-size="10pt" line-height="1.25" space-before="4pt" space-after="4pt" text-align="justify">
					<xsl:apply-templates/>
				</fo:block>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="//dmRef">
		<xsl:variable name="dmcForLink" select="concat(dmRefIdent//dmCode/@modelIdentCode,'-',dmRefIdent//dmCode/@systemDiffCode, '-', dmRefIdent//dmCode/@systemCode, '-',dmRefIdent//dmCode/@subSystemCode,dmRefIdent//dmCode/@subSubSystemCode,'-',dmRefIdent//dmCode/@assyCode,'-',dmRefIdent//dmCode/@disassyCode,dmRefIdent//dmCode/@disassyCodeVariant,'-',dmRefIdent//dmCode/@infoCode,dmRefIdent//dmCode/@infoCodeVariant,'-',dmRefIdent//dmCode/@itemLocationCode)"/>
		<xsl:variable name="dmc" select="concat(dmRefIdent//dmCode/@modelIdentCode,'&#x200B;-&#x200B;',dmRefIdent//dmCode/@systemDiffCode, '&#x200B;-&#x200B;', dmRefIdent//dmCode/@systemCode, '&#x200B;-&#x200B;',dmRefIdent//dmCode/@subSystemCode,dmRefIdent//dmCode/@subSubSystemCode,'&#x200B;-&#x200B;',dmRefIdent//dmCode/@assyCode,'&#x200B;-&#x200B;',dmRefIdent//dmCode/@disassyCode,dmRefIdent//dmCode/@disassyCodeVariant,'&#x200B;-&#x200B;',dmRefIdent//dmCode/@infoCode,dmRefIdent//dmCode/@infoCodeVariant,'&#x200B;-&#x200B;',dmRefIdent//dmCode/@itemLocationCode)"/>
		<xsl:variable name="dmcPdf" select="concat('DMC-',$dmcForLink,'.pdf')"/>
		<!--src="url('{$grph}')"-->
		<!--concat('file:/',$rootDir,unparsed-entity-uri(@infoEntityIdent))-->
		<xsl:choose>
			<xsl:when test="descendant::wrapper">
				<fo:inline background-color="yellow" color="blue">
					<fo:basic-link external-destination="{$dmcPdf}"><xsl:value-of select="$dmc"/></fo:basic-link>
				</fo:inline>
			</xsl:when>
			<xsl:otherwise>
				<fo:inline color="blue">
					<fo:basic-link external-destination="{$dmcPdf}"><xsl:value-of select="$dmc"/></fo:basic-link>
				</fo:inline>
			</xsl:otherwise>
		</xsl:choose>
		<!--<fo:inline color="blue">
			<fo:basic-link external-destination="url({$dmcPdf})"><xsl:value-of select="$dmc"/></fo:basic-link>
		</fo:inline>-->
	</xsl:template>

</xsl:stylesheet>
