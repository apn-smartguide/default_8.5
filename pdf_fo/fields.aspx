<!--<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>-->
<Apn:forEach  runat="server">
	<Apn:choosecontrol  runat="server">
		<Apn:whencontrol type="INPUT"  runat="server">
			<Apn:control id="input_control"  runat="server">
			<!--<% if(!input_control.Current.getAttribute("style").Equals("visibility:hidden;")) { %>-->
			<fo:table-row keep-together="always">
				<fo:table-cell  padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><Apn:label  runat="server"/></fo:block>
				</fo:table-cell>
				<fo:table-cell  padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start"><![CDATA[<Apn:value  runat="server"/>]]></fo:block>
				</fo:table-cell>
			</fo:table-row>						
			<!--<% } %>	-->
			</Apn:control>
		</Apn:whencontrol>
		<Apn:whencontrol type="DATE"  runat="server">
			<fo:table-row keep-together="always">
				<fo:table-cell  padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><Apn:label  runat="server"/></fo:block>
				</fo:table-cell>
				<fo:table-cell  padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start"><Apn:value  runat="server"/></fo:block>
				</fo:table-cell>
			</fo:table-row>
		</Apn:whencontrol>
		<Apn:whencontrol type="SELECT1"  runat="server">
			<!--==== Begin of SELECT1 ====-->
			<!-- For radio or drop, render as radio -->
			<Apn:control id="select1_control" runat="server">
			<fo:table-row>
				<fo:table-cell padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><Apn:label runat="server"/></fo:block>
				</fo:table-cell>
				<fo:table-cell padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:list-block provisional-label-separation="4mm" provisional-distance-between-starts="4mm">
						<Apn:forEach id="select1_control2" runat="server">
							<Apn:choosecontrol runat="server">
								<Apn:whencontrol type="optgroup" runat="server">
									<fo:list-item>
										<fo:list-item-label end-indent="label-end()"><fo:block >&#160;&#160;</fo:block></fo:list-item-label>
										<fo:list-item-body start-indent="body-start()"><fo:block><Apn:label runat="server"/></fo:block></fo:list-item-body>
									</fo:list-item>
									<Apn:forEach id="select1_control3" runat="server">
										<fo:list-item>
											<!--<%if (select1_control.Current.getValue().Equals(select1_control3.Current.getValue())){%>-->
											<!-- selected -->
											<fo:list-item-label end-indent="label-end()"><fo:block  font-family="ZapfDingbats">&#160;&#160;&#x25CF;</fo:block></fo:list-item-label>
											<fo:list-item-body><fo:block><![CDATA[ <%= select1_control3.Current.getLabel() %>]]></fo:block></fo:list-item-body>
											<!--<% } else { %>-->
											<!-- not selected -->														
											<fo:list-item-label end-indent="label-end()"><fo:block  font-family="ZapfDingbats">&#160;&#160;&#x274D;</fo:block></fo:list-item-label>
											<fo:list-item-body start-indent="body-start()"><fo:block><![CDATA[ <%= select1_control3.Current.getLabel() %>]]></fo:block></fo:list-item-body>
											<!--<% } %>-->
										</fo:list-item>
									</Apn:forEach>
								</Apn:whencontrol>
								<Apn:otherwise runat="server">
									<fo:list-item>
										<!--<%if (select1_control.Current.getValue().Equals(select1_control2.Current.getValue())){%>-->
										<!-- selected -->
										<fo:list-item-label end-indent="label-end()"><fo:block  font-family="ZapfDingbats">&#x25CF;</fo:block></fo:list-item-label>
										<fo:list-item-body start-indent="body-start()"><fo:block><![CDATA[ <%= select1_control2.Current.getLabel() %>]]></fo:block></fo:list-item-body>
										<!--<% } else { %>--> 
										<!-- not selected -->														
										<fo:list-item-label end-indent="label-end()"><fo:block  font-family="ZapfDingbats">&#x274D;</fo:block></fo:list-item-label>
										<fo:list-item-body start-indent="body-start()"><fo:block><![CDATA[ <%= select1_control2.Current.getLabel() %>]]></fo:block></fo:list-item-body>
										<!--<% } %>-->
									</fo:list-item>
								</Apn:otherwise>
							</Apn:choosecontrol>
						</Apn:forEach>
					</fo:list-block>
				</fo:table-cell>
			</fo:table-row>
			</Apn:control>		
		</Apn:whencontrol>
		<!--==== End of SELECT1 ====-->
		<Apn:whencontrol type="SELECT" runat="server">
			<!--==== Begin of SELECT ====-->
			<!-- For checkbox or list, render as checkbox -->
			<Apn:control id="select_control" runat="server">
			<fo:table-row>
				<fo:table-cell padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><Apn:label runat="server"/></fo:block>
				</fo:table-cell>
				<fo:table-cell padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:list-block provisional-label-separation="4mm" provisional-distance-between-starts="4mm">
						<Apn:forEach id="select_control2" runat="server">
							<Apn:choosecontrol runat="server">
								<Apn:whencontrol type="optgroup" runat="server">
									<fo:list-item>
										<fo:list-item-label end-indent="label-end()"><fo:block  font-family="ZapfDingbats">&#x2750;</fo:block></fo:list-item-label>
										<fo:list-item-body start-indent="body-start()"><fo:block><Apn:label runat="server"/></fo:block></fo:list-item-body>
									</fo:list-item>
									<Apn:forEach id="select_control3" runat="server">
										<fo:list-item>
											<fo:list-item-label end-indent="label-end()"><fo:block  font-family="ZapfDingbats">&#x2750;</fo:block></fo:list-item-label>
											<!--<%if (select_control.Current.getValue().Equals(select_control3.Current.getValue())){%>-->
											<fo:list-item-body><fo:block>
												<fo:inline font-family="ZapfDingbats">&#x2713;</fo:inline>
												<![CDATA[ <%= select_control3.Current.getLabel() %>]]>
											</fo:block></fo:list-item-body>
											<!--<% } else { %>--> 
											<fo:list-item-body start-indent="body-start()"><fo:block>
												<![CDATA[ <%= select_control3.Current.getLabel() %>]]>
											</fo:block></fo:list-item-body>
											<!--<% } %>-->
										</fo:list-item>
									</Apn:forEach>
								</Apn:whencontrol>
								<Apn:otherwise runat="server">
									<fo:list-item>
										<fo:list-item-label end-indent="label-end()"><fo:block font-family="ZapfDingbats">&#x2750;</fo:block></fo:list-item-label>
										<!--<%if (select_control.Current.getValue().Equals(select_control2.Current.getValue())){%>-->
										<fo:list-item-body><fo:block>
											<fo:inline font-family="ZapfDingbats">&#x2713;</fo:inline>
											<![CDATA[ <%= select_control2.Current.getLabel() %>]]>
										</fo:block></fo:list-item-body>
										<!--<% } else { %>--> 
										<fo:list-item-body start-indent="body-start()"><fo:block>
											<![CDATA[ <%= select_control2.Current.getLabel() %>]]>
										</fo:block></fo:list-item-body>
										<!--<% } %>-->
									</fo:list-item>
								</Apn:otherwise>
							</Apn:choosecontrol>
						</Apn:forEach>
					</fo:list-block>
				</fo:table-cell>
			</fo:table-row>
			</Apn:control>		
		</Apn:whencontrol>
		<!--==== End of SELECT ====-->	
		<Apn:whencontrol type="STATICTEXT" runat="server">
		<!--==== Begin of static text ===-->
			<Apn:control id="statictext_control" runat="server">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="2" padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><Apn:label runat="server"/></fo:block>
					<fo:block text-align="start"><Apn:value runat="server"/></fo:block>
				</fo:table-cell>
			</fo:table-row>						
			</Apn:control>
		</Apn:whencontrol>	
		<!--==== End of static text ===-->					
		<Apn:whencontrol type="TEXTAREA" runat="server">
		<!--==== Begin of textarea ===-->
			<Apn:control id="textarea_control" runat="server">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="2" padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><Apn:label runat="server"/></fo:block>
					<fo:block text-align="start"><![CDATA[<Apn:value runat="server"/>]]></fo:block>
				</fo:table-cell>
			</fo:table-row>
			</Apn:control>
		</Apn:whencontrol>	
		<!--==== End of textarea ===-->		
		<Apn:whencontrol type="IMAGE" runat="server">
		<!--==== Begin of static image ===-->
			<Apn:control id="image" runat="server">
			<fo:table-row keep-together="always">
				<fo:table-cell number-columns-spanned="2" padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><Apn:label runat="server"/></fo:block>
					<fo:block text-align="start"><fo:external-graphic content-height="scale-to-fit" height="2.00in"  content-width="2.00in" scaling="non-uniform" 
						text-align="start" display-align="before" src="<Apn:value runat='server'/>" /></fo:block>
				</fo:table-cell>
			</fo:table-row>						
			</Apn:control>
		</Apn:whencontrol>	
		<!--==== End of image ===-->
		<Apn:whencontrol type="RESULT" runat="server">	
		<!--==== Begin of knowledge base ===-->
			<Apn:control id="knowledge" runat="server">
			<fo:table-row>
				<fo:table-cell number-columns-spanned="2" padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><Apn:label runat="server"/></fo:block>
					<fo:list-block provisional-label-separation="4mm" provisional-distance-between-starts="4mm">
						<Apn:forEach begin="0" end="0" runat="server">
							<fo:list-item>
								<fo:list-item-label end-indent="label-end()"><fo:block  font-family="ZapfDingbats">&#x27A4;</fo:block></fo:list-item-label>
								<fo:list-item-body start-indent="body-start()"><fo:block><![CDATA[<Apn:value runat="server"/>]]></fo:block></fo:list-item-body>
							</fo:list-item>						
						</Apn:forEach>
						<Apn:forEach begin="1" runat="server">
							<Apn:choosecontrol runat="server">											
								<Apn:whencontrol type="RESULT_REPEAT" runat="server">																					
									<Apn:forEach runat="server">
										<Apn:control runat="server">
											<fo:list-item>
												<fo:list-item-label end-indent="label-end()"><fo:block  font-family="ZapfDingbats">&#160;&#160;&#160;&#160;&#x27A3;</fo:block></fo:list-item-label>
												<fo:list-item-body start-indent="body-start()">
													<fo:block><![CDATA[&#160;&#160;&#160;&#160;<Apn:forEach begin="0" end="0" runat="server"><Apn:value runat="server"/></Apn:forEach>]]></fo:block>
												</fo:list-item-body>
											</fo:list-item>
											<Apn:forEach begin="1" runat="server">
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()"><fo:block><![CDATA[&#160;&#160;&#160;&#160;]]></fo:block></fo:list-item-label>
													<fo:list-item-body start-indent="body-start()"><fo:block><![CDATA[&#160;&#160;&#160;&#160;<Apn:label runat="server"/> : <Apn:value runat="server"/>]]></fo:block></fo:list-item-body>
												</fo:list-item>
											</Apn:forEach>
										</Apn:control>	
									</Apn:forEach>	
								</Apn:whencontrol>
								<Apn:otherwise runat="server">
									<fo:list-item>
										<fo:list-item-label end-indent="label-end()"><fo:block><![CDATA[&#160;]]></fo:block></fo:list-item-label>
										<fo:list-item-body start-indent="body-start()"><fo:block><![CDATA[<Apn:label runat="server"/> : <Apn:value runat="server"/>]]></fo:block></fo:list-item-body>
									</fo:list-item>
								</Apn:otherwise> 
							</Apn:choosecontrol>
						</Apn:forEach>									
					</fo:list-block>
				</fo:table-cell>
			</fo:table-row>						
			</Apn:control>
		</Apn:whencontrol>				
		<!--==== End of knowledge base ===-->	
		<apn:whencontrol type="ROW" runat="server">
		<!--==== Begin of row ===-->
			<apn:control runat="server">
				<apn:forEach runat="server">											
					<apn:choosecontrol runat="server">
						<apn:whencontrol runat="server" type="COL">
							<% Server.Execute(Page.TemplateSourceDirectory + "/fields.aspx"); %>
						</apn:whencontrol>
					</apn:choosecontrol>
				</apn:forEach>
			</apn:control>
		</apn:whencontrol>	
		<!--==== End of row ===-->		
		<Apn:whencontrol type="GROUP" runat="server">
		<!--==== Begin of group ===-->
			<Apn:control id="group" runat="server">
			<fo:table-row>
				<fo:table-cell background-color="rgb(192,192,192)" number-columns-spanned="2" padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><![CDATA[<Apn:label runat="server"/>]]></fo:block>
				</fo:table-cell>
			</fo:table-row>	
			<fo:table-row>
				<fo:table-cell number-columns-spanned="2" padding="5mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:table border-collapse="collapse" height="17cm" border-color="rgb(192,192,192)" border-style="solid" border-width="0.1mm" table-layout="fixed" width="100%">
						<fo:table-column column-width="50%"/>
						<fo:table-column column-width="50%"/>
						<fo:table-body font-family="sans-serif" font-weight="normal" font-size="10pt">
							<% Server.Execute(Page.TemplateSourceDirectory + "/fields.aspx"); %>
						</fo:table-body>
					</fo:table>
				</fo:table-cell>
			</fo:table-row>	
			</Apn:control>
		</Apn:whencontrol>
		<!--==== End of group ===-->		
		<Apn:whencontrol type="REPEAT" runat="server">
		<!--==== Begin of repeat ===-->
			<Apn:control id="repeat" runat="server">
			<fo:table-row>
				<fo:table-cell background-color="rgb(192,192,192)" number-columns-spanned="2" padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:block text-align="start" ><![CDATA[<Apn:label runat="server"/>]]></fo:block>
				</fo:table-cell>
			</fo:table-row>	
			<fo:table-row>
				<fo:table-cell number-columns-spanned="2" padding="5mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
					<fo:table border-collapse="collapse" height="17cm" border-color="rgb(192,192,192)" border-style="solid" border-width="0.1mm" table-layout="fixed">
						<Apn:control type="default-instance" runat="server">
							<!-- <% Context.Items["instance_count"] = 0; %> -->
							<Apn:forEach runat="server">
							<Apn:forEach runat="server">
							<Apn:forEach runat="server" id="field">
								<!-- <% 
									if(!field.Current.getAttribute("style").Equals("visibility:hidden;") 
											&& !field.Current.getAttribute("visible").Equals("false") 
											&& !field.Current.getCSSClass().Contains("hide-from-list-view")) {
										Context.Items["instance_count"] = ((int) Context.Items["instance_count"])+1;
									} 
								%> -->
							</Apn:forEach>
							</Apn:forEach>
							</Apn:forEach>
							<!-- <%for (int i=0;i< (int)Context.Items["instance_count"];i++){ %> -->
							<!-- render table column definition -->
							<fo:table-column column-width="<%=100/((int)Context.Items["instance_count"])%>%"/>
							<!-- <% } %> -->
							<fo:table-header>
								<fo:table-row>
									<Apn:forEach runat="server"><!-- row -->
									<Apn:forEach runat="server"><!-- col -->
									<Apn:forEach runat="server" id="field1"><!-- field -->
									<!-- <% 
										if(!field1.Current.getAttribute("style").Equals("visibility:hidden;") 
												&& !field1.Current.getAttribute("visible").Equals("false") 
												&& !field1.Current.getCSSClass().Contains("hide-from-list-view")) { // Don't show if it's a hidden field1 
									%> -->
									<fo:table-cell background-color="rgb(192,192,192)" padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
										<fo:block text-align="start" ><![CDATA[ <Apn:label runat="server"/> &#160;]]></fo:block>
									</fo:table-cell>	
									<!-- <% } %> -->
									</Apn:forEach>
									</Apn:forEach>
									</Apn:forEach>
								</fo:table-row> 
							</fo:table-header>
						</Apn:control>
						<fo:table-body font-family="sans-serif" font-weight="normal" font-size="10pt">
							<!-- <% Context.Items["instance_count"] = 0; %> -->
							<Apn:forEach runat="server">
							<!-- <% Context.Items["instance_count"] = ((int) Context.Items["instance_count"])+1; %>-->
							<!-- begin of each repeat group -->
							<fo:table-row>
								<Apn:forEach runat="server"><!-- row -->
								<Apn:forEach runat="server"><!-- col -->
								<Apn:forEach runat="server" id="field2"><!-- field -->
									<!-- <% 
										if(!field2.Current.getAttribute("style").Equals("visibility:hidden;") 
											&& !field2.Current.getAttribute("visible").Equals("false") 
											&& !field2.Current.getCSSClass().Contains("hide-from-list-view")) { // Don't show if it's a hidden field2 
									%> -->
									<!-- begin of each group field -->
									<fo:table-cell padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
										<fo:block text-align="start" ><![CDATA[ <Apn:value runat="server"/> &#160;]]></fo:block>
									</fo:table-cell>	
									<!-- end of each group field -->
									<!-- <% } %> -->
								</Apn:forEach>
								</Apn:forEach>
								</Apn:forEach>
							</fo:table-row>
							<!-- end of each repeat group -->
							</Apn:forEach>
							<!-- <% if ( (int)Context.Items["instance_count"] == 0){ %> -->
							<Apn:control type="default-instance" runat="server">
								<Apn:forEach runat="server"><!-- row -->
								<Apn:forEach runat="server"><!-- col -->
								<Apn:forEach runat="server" id="field3">
									<!-- 
										<% if(!field3.Current.getAttribute("style").Equals("visibility:hidden;") 
											&& !field3.Current.getAttribute("visible").Equals("false") 
											&& !field3.Current.getCSSClass().Contains("hide-from-list-view")) { // Don't show if it's a hidden field3 
									%> -->
									<fo:table-cell padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
										<fo:block text-align="start" ><![CDATA[&#160;]]></fo:block>
									</fo:table-cell>	
									<!-- <% } %> -->
								</Apn:forEach>
								</Apn:forEach>
								</Apn:forEach>
							</Apn:control>
							<!-- <% } %> -->
						</fo:table-body>
					</fo:table>
				</fo:table-cell>
			</fo:table-row>	
			</Apn:control>
		</Apn:whencontrol>	
		<!--==== End of repeat ===-->	
		<Apn:whencontrol type="RECAP" runat="server">
		<!--==== Begin of summary ===-->	
			<Apn:control id="summary"  runat="server">
				<Apn:forEach runat="server">
					<!-- each page -->
					<fo:table-row>
						<fo:table-cell background-color="rgb(192,192,192)" number-columns-spanned="2" padding="1mm" border-before-width="0.5pt" border-after-width="0.25pt" border-start-width="0.25pt" border-end-width="0.25pt" border-color="rgb(192,192,192)" border-style="solid">
							<fo:block text-align="start" ><![CDATA[<Apn:label runat="server"/>]]></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<% Server.Execute(Page.TemplateSourceDirectory + "/fields.aspx"); %>
					<!-- end of eaach page -->
				</Apn:forEach>
			</Apn:control>
		</Apn:whencontrol>	
		<!--==== End of summary ===-->	
		
		
	</Apn:choosecontrol>
</Apn:forEach>