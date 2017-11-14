<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:strip-space elements="*"/>
	<xsl:template match="description/levelledPara">
		<xsl:variable name="Id" select="./@id"/>
		<fo:block font-size="10pt" id="{$Id}">
			<fo:list-block space-before="12pt">
				<fo:list-item>
					<fo:list-item-label end-indent="0mm">
						<fo:block>
							<xsl:number level="multiple" count="description/levelledPara" format="1"/>
						</fo:block>
					</fo:list-item-label>
					<fo:list-item-body start-indent="20mm">
						<!-- <fo:block space-after="8pt" keep-with-next="always">
							<xsl:for-each select="./title">
									<fo:inline font-weight="bold" font-size="12pt">
										<xsl:apply-templates/>
									</fo:inline>
								</xsl:for-each>
						</fo:block> -->
						<xsl:apply-templates/>
					</fo:list-item-body>
				</fo:list-item>
			</fo:list-block>
			<xsl:for-each select="./levelledPara">
				<xsl:variable name="Id1" select="./@id"/>
				<fo:list-block space-before="8pt" space-after="8pt"><!--space-before="8pt"-->
					<fo:list-item>
						<fo:list-item-label end-indent="0mm">
							<fo:block id="{$Id1}">
								<xsl:number level="multiple" count="description/levelledPara | levelledPara" format="1.1"/>
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="20mm">
							<!-- <fo:block space-after="8pt" keep-with-next="always" font-weight="bold">
								<xsl:for-each select="./title">
										<xsl:apply-templates/>
								</xsl:for-each>
							</fo:block> -->
							<xsl:apply-templates/>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>
				<xsl:for-each select="./levelledPara">
					<xsl:variable name="Id1" select="./@id"/>
					<fo:list-block space-after="8pt"><!--space-before="8pt"-->
						<fo:list-item>
							<fo:list-item-label end-indent="0mm">
								<fo:block id="{$Id1}">
									<xsl:number level="multiple" count="description/levelledPara/levelledPara | levelledPara" format="1.1.1"/>
								</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20mm">
								<xsl:apply-templates/>
							</fo:list-item-body>
						</fo:list-item>
					</fo:list-block>
					<xsl:for-each select="./levelledPara">
						<xsl:variable name="Id1" select="./@id"/>
						<fo:list-block space-after="8pt"><!--space-before="8pt"-->
							<fo:list-item>
								<fo:list-item-label end-indent="0mm">
									<fo:block id="{$Id1}">
										<xsl:number level="multiple" count="description/levelledPara/levelledPara/levelledPara | levelledPara" format="1.1.1.1"/>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="20mm">
									<xsl:apply-templates/>
								</fo:list-item-body>
							</fo:list-item>
						</fo:list-block>
						<xsl:for-each select="./levelledPara">
							<xsl:variable name="Id1" select="./@id"/>
							<fo:list-block space-after="8pt"><!--space-before="8pt"-->
								<fo:list-item>
									<fo:list-item-label end-indent="0mm">
										<fo:block id="{$Id1}">
											<xsl:number level="multiple" count="description/levelledPara/levelledPara/levelledPara/levelledPara | levelledPara" format="1.1.1.1.1"/>
										</fo:block>
									</fo:list-item-label>
									<fo:list-item-body start-indent="20mm">
										<xsl:apply-templates/>
									</fo:list-item-body>
								</fo:list-item>
							</fo:list-block>
							<xsl:for-each select="./levelledPara">
								<xsl:variable name="Id1" select="./@id"/>
								<fo:list-block space-after="8pt"><!--space-before="8pt"-->
									<fo:list-item>
										<fo:list-item-label end-indent="0mm">
											<fo:block id="{$Id1}">
												<xsl:number level="multiple" count="description/levelledPara/levelledPara/levelledPara/levelledPara/levelledPara | levelledPara" format="1.1.1.1.1.1"/>
											</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="20mm">
											<xsl:apply-templates/>
										</fo:list-item-body>
									</fo:list-item>
								</fo:list-block>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:for-each>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="levelledPara/levelledPara">
	
	</xsl:template>
	
	<!--<xsl:template match="table">
		<xsl:variable name="TId" select="@id"/>
		<xsl:variable name="tCount">
			<xsl:number level="any" count="table" format="1"/>
		</xsl:variable>
		<fo:table table-layout="fixed" width="100%" id="{$TId}" ><!-\-margin-left="-10mm" -\->
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
							<fo:table table-layout="fixed" width="93%" margin-left="0mm">
								<fo:table-header>
									<fo:table-row>
										<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-collapse="collapse">
											<fo:block font-weight="bold" text-align="left"><!-\- margin-left="-6mm"-\->
												<xsl:for-each select="./tgroup/thead/row/entry[1]">
													<xsl:apply-templates/>
												</xsl:for-each><!-\- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -\->
											</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-collapse="collapse">
											<fo:block font-weight="bold" text-align="left"><!-\- margin-left="-6mm"-\->
												<xsl:for-each select="./tgroup/thead/row/entry[2]">
													<xsl:apply-templates/>
												</xsl:for-each>
												<!-\- <xsl:value-of select="./tgroup/thead/row/entry[2]/para"/> -\->
											</fo:block>
										</fo:table-cell>
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
									</fo:table-row>
								</fo:table-footer>
								<fo:table-body>
									<xsl:for-each select="./tgroup/tbody/row">
										<fo:table-row>
											<fo:table-cell padding-top="4pt" padding-bottom="4pt" border-right-style="solid" border-right-color="black">
												<fo:block><!-\- margin-left="-6mm"-\->
													<xsl:for-each select="./entry[1]">
														<xsl:apply-templates/>
													</xsl:for-each>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell padding-top="4pt" padding-bottom="4pt">
												<fo:block><!-\- margin-left="-6mm"-\->
													<xsl:for-each select="./entry[2]">
														<xsl:apply-templates/>
													</xsl:for-each>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		</xsl:template>-->
	
	<!--<xsl:template match="table">
		<xsl:variable name="TId" select="@id"/>
		<xsl:variable name="tCount">
			<xsl:number level="any" count="table" format="1"/>
		</xsl:variable>
		<fo:table table-layout="fixed" width="93%" id="{$TId}" margin-left="-10mm"><!-\-margin-left="-10mm" -\->
			<fo:table-column column-width="proportional-column-width(1)"/>
			<fo:table-header>
				<fo:table-row>
					<fo:table-cell>
						<xsl:if test="title/text()">
							<!-\-border="1 solid black" -\-><fo:block keep-with-next="always" text-align="center" padding-top="8pt" padding-bottom="2pt" space-after="2pt" margin-left="-10mm">
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
								<fo:table-header>
									<fo:table-row>
										<xsl:for-each select="./tgroup/thead/row/entry">
											<fo:table-cell display-align="after" padding-top="1pt" padding-bottom="1pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black" border-collapse="collapse">
												<fo:block font-weight="bold" text-align="left" margin-left="-6mm"><!-\- margin-left="-6mm"-\->
													<!-\-<xsl:for-each select="./tgroup/thead/row/entry[1]">-\->
													<xsl:apply-templates/>
													<!-\-</xsl:for-each>-\-><!-\- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -\->
												</fo:block>
											</fo:table-cell>
										</xsl:for-each>
										<!-\-<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-right-color="black" border-collapse="collapse">
											<fo:block font-weight="bold" text-align="left"><!-\- margin-left="-6mm"-\->
											<xsl:for-each select="./tgroup/thead/row/entry[1]">
											<xsl:apply-templates/>
											</xsl:for-each><!-\- <xsl:value-of select="./tgroup/thead/row/entry[1]/para"/> -\->
											</fo:block>
											</fo:table-cell>
											<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-collapse="collapse">
											<fo:block font-weight="bold" text-align="left"><!-\- margin-left="-6mm"-\->
											<xsl:for-each select="./tgroup/thead/row/entry[2]">
											<xsl:apply-templates/>
											</xsl:for-each>
											<!-\- <xsl:value-of select="./tgroup/thead/row/entry[2]/para"/> -\->
											</fo:block>
											</fo:table-cell>-\->
									</fo:table-row>
								</fo:table-header>
								<fo:table-footer>
									<fo:table-row>
										<xsl:for-each select="./tgroup/thead/row[1]/entry"><!-\-[position() &gt; 1]-\->
											<fo:table-cell border-top-style="solid" border-top-color="black" border-collapse="collapse">
												<fo:block/>
											</fo:table-cell>
										</xsl:for-each>
									</fo:table-row>
								</fo:table-footer>
								<fo:table-body>
									<xsl:for-each select="./tgroup/tbody/row">
										<fo:table-row>
											<xsl:for-each select="./entry">
												<fo:table-cell padding-top="4pt" padding-bottom="4pt" border="1 solid black">
													<fo:block margin-left="-6mm"><!-\- margin-left="-6mm"-\->
														<!-\-<xsl:for-each select="./entry[1]">-\->
														<xsl:apply-templates/>
														<!-\-</xsl:for-each>-\->
													</fo:block>
												</fo:table-cell>
											</xsl:for-each>
											<!-\-<xsl:for-each select="./entry[position() = 1]">
												<fo:table-cell padding-top="4pt" padding-bottom="4pt" border-right-style="solid" border-right-color="black" border-left-style="solid" border-left-color="black">
												<fo:block margin-left="-6mm"><!-\- margin-left="-6mm"-\->
												<!-\-<xsl:for-each select="./entry[1]">-\->
												<xsl:apply-templates/>
												<!-\-</xsl:for-each>-\->
												</fo:block>
												</fo:table-cell>
												</xsl:for-each>-\->
											<!-\-<fo:table-cell padding-top="4pt" padding-bottom="4pt" border-right-style="solid" border-right-color="black">
												<fo:block><!-\- margin-left="-6mm"-\->
												<xsl:for-each select="./entry[1]">
												<xsl:apply-templates/>
												</xsl:for-each>
												</fo:block>
												</fo:table-cell>
												<fo:table-cell padding-top="4pt" padding-bottom="4pt">
												<fo:block><!-\- margin-left="-6mm"-\->
												<xsl:for-each select="./entry[2]">
												<xsl:apply-templates/>
												</xsl:for-each>
												</fo:block>
												</fo:table-cell>-\->
										</fo:table-row>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
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
								<fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-right-style="solid" border-left-style="solid" border-right-color="black" border-left-color="black" border-collapse="collapse">
									<fo:block font-weight="bold" text-align="left" margin-left="-18mm">
										<xsl:value-of select="para"/>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
							<!-\- <fo:table-cell padding-top="1pt" padding-bottom="1pt" border-top-style="solid" border-top-color="black" border-bottom-style="solid" border-bottom-color="black" border-collapse="collapse">
								<fo:block font-weight="bold" text-align="left" margin-left="-18mm">
									<xsl:value-of select="./tgroup/thead/row/entry[2]/para"/>
								</fo:block>
							</fo:table-cell> -\->
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
								<!-\- <fo:table-cell padding-top="1pt" padding-bottom="1pt">
									<fo:block margin-left="-18mm">
										<xsl:for-each select="./entry[2]/para">
											<xsl:apply-templates/>
										</xsl:for-each>
									</fo:block>
								</fo:table-cell> -\->
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</xsl:for-each>
	</xsl:template>-->
	
	
</xsl:stylesheet>