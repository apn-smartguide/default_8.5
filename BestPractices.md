Best Practices

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