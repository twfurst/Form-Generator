<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<xsl:template match="proceduralStep/proceduralStep"></xsl:template>
	
	<xsl:template match="mainProcedure/proceduralStep">
		<fo:block font-size="10pt" id="{@id}">
			<fo:list-block space-before="8pt" space-after="8pt">
				<xsl:if test="./title">
					<fo:list-item space-before="2pt" space-after="4pt">
						<fo:list-item-label end-indent="0mm">
							<fo:block>
								
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="20mm">
							<xsl:for-each select="./title">
								<fo:block keep-with-next="always" font-weight="bold">
									<xsl:apply-templates/>
								</fo:block>
							</xsl:for-each>
						</fo:list-item-body>
					</fo:list-item>
				</xsl:if>
				<xsl:if test="./warning">
					<fo:list-item space-before="2pt" space-after="4pt">
						<fo:list-item-label end-indent="0mm">
							<fo:block>
								
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="20mm">
							<xsl:for-each select="./warning">
								<fo:block>
									<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
									text-align="center"> WARNING </fo:block>
									<xsl:apply-templates/>
								</fo:block>
							</xsl:for-each>
						</fo:list-item-body>
					</fo:list-item>
				</xsl:if>
				<xsl:if test="./caution">
					<fo:list-item space-before="2pt" space-after="2pt">
						<fo:list-item-label end-indent="0mm">
							<fo:block>
								
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="20mm">
							<xsl:for-each select="./caution">
								<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
									text-align="center"> CAUTION </fo:block>
								<xsl:apply-templates/>
							</xsl:for-each>
						</fo:list-item-body>
					</fo:list-item>
				</xsl:if>
				<xsl:if test="./note">
					<fo:list-item space-before="2pt" space-after="2pt">
						<fo:list-item-label end-indent="0mm">
							<fo:block>
								
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="20mm">
							<xsl:for-each select="./note">
								<fo:block text-align="center" text-decoration="underline" font-size="11pt" font-weight="bold">NOTE</fo:block>
								<xsl:apply-templates/>
							</xsl:for-each>
						</fo:list-item-body>
					</fo:list-item>
				</xsl:if>
				<fo:list-item space-before="2pt" space-after="2pt">
					<fo:list-item-label end-indent="0mm">
						<fo:block> <!--keep-with-next="always"-->
							<xsl:number level="multiple" count="mainProcedure/proceduralStep" format="1."/>
						</fo:block>
					</fo:list-item-label>
					<fo:list-item-body start-indent="20mm">
						<xsl:apply-templates/>
					</fo:list-item-body>
				</fo:list-item>
			</fo:list-block>
			<xsl:for-each select="./proceduralStep">
				<fo:block>
					<fo:list-block space-before="8pt" space-after="8pt">
						<xsl:if test="./warning">
							<fo:list-item space-before="2pt" space-after="2pt">
								<fo:list-item-label end-indent="0mm">
									<fo:block>
										
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="20mm">
									<xsl:for-each select="./warning">
										<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
											text-align="center"> WARNING </fo:block>
										<xsl:apply-templates/>
									</xsl:for-each>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
						<xsl:if test="./caution">
							<fo:list-item space-before="2pt" space-after="2pt">
								<fo:list-item-label end-indent="0mm">
									<fo:block>
										
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="20mm">
									<xsl:for-each select="./caution">
										<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
											text-align="center"> CAUTION </fo:block>
										<xsl:apply-templates/>
									</xsl:for-each>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
						<xsl:if test="./note">
							<fo:list-item space-before="2pt" space-after="2pt">
								<fo:list-item-label end-indent="0mm">
									<fo:block>
										
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="20mm">
									<xsl:for-each select="./note">
										<fo:block text-align="center" text-decoration="underline" font-size="11pt" font-weight="bold">NOTE</fo:block>
										<xsl:apply-templates/>
									</xsl:for-each>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
						<fo:list-item space-before="2pt" space-after="2pt">
							<fo:list-item-label end-indent="0mm">
								<fo:block id="{@id}">
									<xsl:number level="multiple" count="mainProcedure/proceduralStep | proceduralStep" format="1.1."/>
								</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20mm">
								<xsl:apply-templates/>
							</fo:list-item-body>
						</fo:list-item>
					</fo:list-block>
				</fo:block>
				<xsl:for-each select="./proceduralStep">
					<fo:block>
						<fo:list-block space-after="8pt">
							<xsl:if test="./warning">
								<fo:list-item space-before="2pt" space-after="2pt">
									<fo:list-item-label end-indent="0mm">
										<fo:block>
											
										</fo:block>
									</fo:list-item-label>
									<fo:list-item-body start-indent="20mm">
										<xsl:for-each select="./warning">
											<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
												text-align="center"> WARNING </fo:block>
											<xsl:apply-templates/>
										</xsl:for-each>
									</fo:list-item-body>
								</fo:list-item>
							</xsl:if>
							<xsl:if test="./caution">
								<fo:list-item space-before="2pt" space-after="2pt">
									<fo:list-item-label end-indent="0mm">
										<fo:block>
											
										</fo:block>
									</fo:list-item-label>
									<fo:list-item-body start-indent="20mm">
										<xsl:for-each select="./caution">
											<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
												text-align="center"> CAUTION </fo:block>
											<xsl:apply-templates/>
										</xsl:for-each>
									</fo:list-item-body>
								</fo:list-item>
							</xsl:if>
							<xsl:if test="./note">
								<fo:list-item space-before="2pt" space-after="2pt">
									<fo:list-item-label end-indent="0mm">
										<fo:block>
											
										</fo:block>
									</fo:list-item-label>
									<fo:list-item-body start-indent="20mm">
										<xsl:for-each select="./note">
											<fo:block text-align="center" text-decoration="underline" font-size="11pt" font-weight="bold">NOTE</fo:block>
											<xsl:apply-templates/>
										</xsl:for-each>
									</fo:list-item-body>
								</fo:list-item>
							</xsl:if>
							<fo:list-item space-before="2pt" space-after="2pt">
								<fo:list-item-label end-indent="0mm">
									<fo:block id="{@id}">
										<xsl:number level="multiple" count="mainProcedure/proceduralStep/proceduralStep | proceduralStep" format="1.1.1."/>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="20mm">
									<xsl:apply-templates/>
								</fo:list-item-body>
							</fo:list-item>
						</fo:list-block>
					</fo:block>
					<xsl:for-each select="./proceduralStep">
						<fo:block>
							<fo:list-block space-after="8pt">
								<xsl:if test="./warning">
									<fo:list-item space-before="2pt" space-after="2pt">
										<fo:list-item-label end-indent="0mm">
											<fo:block>
												
											</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="20mm">
											<xsl:for-each select="./warning">
												<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
													text-align="center"> WARNING </fo:block>
												<xsl:apply-templates/>
											</xsl:for-each>
										</fo:list-item-body>
									</fo:list-item>
								</xsl:if>
								<xsl:if test="./caution">
									<fo:list-item space-before="2pt" space-after="2pt">
										<fo:list-item-label end-indent="0mm">
											<fo:block>
												
											</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="20mm">
											<xsl:for-each select="./caution">
												<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
													text-align="center"> CAUTION </fo:block>
												<xsl:apply-templates/>
											</xsl:for-each>
										</fo:list-item-body>
									</fo:list-item>
								</xsl:if>
								<xsl:if test="./note">
									<fo:list-item space-before="2pt" space-after="2pt">
										<fo:list-item-label end-indent="0mm">
											<fo:block>
												
											</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="20mm">
											<xsl:for-each select="./note">
												<fo:block text-align="center" text-decoration="underline" font-size="11pt" font-weight="bold">NOTE</fo:block>
												<xsl:apply-templates/>
											</xsl:for-each>
										</fo:list-item-body>
									</fo:list-item>
								</xsl:if>
								<fo:list-item space-before="2pt" space-after="2pt">
									<fo:list-item-label end-indent="0mm">
										<fo:block id="{@id}">
											<xsl:number level="multiple" count="mainProcedure/proceduralStep/proceduralStep/proceduralStep | proceduralStep" format="1.1.1.1."/>
										</fo:block>
									</fo:list-item-label>
									<fo:list-item-body start-indent="20mm">
										<xsl:apply-templates/>
									</fo:list-item-body>
								</fo:list-item>
							</fo:list-block>
						</fo:block>
						<xsl:for-each select="./proceduralStep">
							<fo:block>
								<fo:list-block space-after="8pt">
									<xsl:if test="./warning">
										<fo:list-item space-before="2pt" space-after="2pt">
											<fo:list-item-label end-indent="0mm">
												<fo:block>
													
												</fo:block>
											</fo:list-item-label>
											<fo:list-item-body start-indent="20mm">
												<xsl:for-each select="./warning">
													<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
														text-align="center"> WARNING </fo:block>
													<xsl:apply-templates/>
												</xsl:for-each>
											</fo:list-item-body>
										</fo:list-item>
									</xsl:if>
									<xsl:if test="./caution">
										<fo:list-item space-before="2pt" space-after="2pt">
											<fo:list-item-label end-indent="0mm">
												<fo:block>
													
												</fo:block>
											</fo:list-item-label>
											<fo:list-item-body start-indent="20mm">
												<xsl:for-each select="./caution">
													<fo:block keep-with-next="always" font-weight="bold" text-decoration="underline"
														text-align="center"> CAUTION </fo:block>
													<xsl:apply-templates/>
												</xsl:for-each>
											</fo:list-item-body>
										</fo:list-item>
									</xsl:if>
									<xsl:if test="./note">
										<fo:list-item space-before="2pt" space-after="2pt">
											<fo:list-item-label end-indent="0mm">
												<fo:block>
													
												</fo:block>
											</fo:list-item-label>
											<fo:list-item-body start-indent="20mm">
												<xsl:for-each select="./note">
													<fo:block text-align="center" text-decoration="underline" font-size="11pt" font-weight="bold">NOTE</fo:block>
													<xsl:apply-templates/>
												</xsl:for-each>
											</fo:list-item-body>
										</fo:list-item>
									</xsl:if>
									<fo:list-item space-before="2pt" space-after="2pt">
										<fo:list-item-label end-indent="0mm">
											<fo:block id="{@id}">
												<xsl:number level="multiple" count="mainProcedure/proceduralStep/proceduralStep/proceduralStep/proceduralStep | proceduralStep" format="1.1.1.1.1."/>
											</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="20mm">
											<xsl:apply-templates/>
										</fo:list-item-body>
									</fo:list-item>
								</fo:list-block>
							</fo:block>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:for-each>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->