Best Practices

https://stackoverflow.com/questions/6698481/how-do-i-prevent-iis-7-5-from-caching-symlink-content

<!-- This section is to allow integrated pipeline mode in IIS 7.0 and later -->
<system.webServer>
	<!-- Uncomment below to increase max upload file size
	<security>
		<requestFiltering>
			<requestLimits maxAllowedContentLength="200000000" />
		</requestFiltering>
	</security> -->
	<staticContent>
		<clientCache cacheControlMode="DisableCache" />
	</staticContent>
	<handlers>
		<!-- add preCondition="integratedMode,runtimeVersionv2.0" to the handler below if your IIS also serves .Net 1.1 and you use integrated mode -->
		<add name="do.aspx" path="do.aspx" verb="*" type="com.alphinat.interview.si.xml.servlet.XMLHttpHandler, apn-sgs" />
	</handlers>
	<validation validateIntegratedModeConfiguration="false" />
	<caching enabled="false">
		<profiles>
			<add extension=".css" policy="DontCache" kernelCachePolicy="DisableCache" />
			<add extension=".js" policy="DontCache" kernelCachePolicy="DisableCache" />
			<add extension=".aspx" policy="DontCache" kernelCachePolicy="DisableCache" />
		</profiles>
	</caching>
</system.webServer>

In Development
	Set Debug=true
	Set Caching False
In Production
	Set Debug=false
	Set Caching True

Configure compression;
Modify the applicationHost.config under "%windir%\System32\inetsrv\config"

<httpCompression directory="%SystemDrive%\inetpub\temp\IIS Temporary Compressed Files">
	<scheme name="gzip" dll="%Windir%\system32\inetsrv\gzip.dll" />
	<staticTypes>
		<add mimeType="text/*" enabled="true" />
		<add mimeType="message/*" enabled="true" />
		<add mimeType="application/javascript" enabled="true" />
		<add mimeType="application/atom+xml" enabled="true" />
		<add mimeType="application/xaml+xml" enabled="true" />
		<add mimeType="image/svg+xml" enabled="true" />
		<add mimeType="*/*" enabled="false" />
	</staticTypes>
	<dynamicTypes>
		<add mimeType="text/*" enabled="true" />
		<add mimeType="message/*" enabled="true" />
		<add mimeType="application/javascript" enabled="true" />
		<add mimeType="*/*" enabled="false" />
	</dynamicTypes>
</httpCompression>