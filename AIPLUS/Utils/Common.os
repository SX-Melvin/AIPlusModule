package AIPLUS::Utils

public Object Common inherits AIPLUS::AiplusRoot
	
	function Void CreateIfNotExist(String path)
		List 	split = Str.Elements(path, "/")
		List	merge = {}
		String 	folder
		String	join
		
		for folder in split
			merge = {@merge, folder}
			join = Str.Join(merge,"/") + "/"
			if(!File.Exists(join))
				File.Create(join)
			end
		end
	end
	
	function Boolean IsPostgres()
		Boolean result = FALSE
		if($pSession.fDbConnect.fDbInfo.servtype == 'POSTGRESQL')
			result = TRUE
		end
		
		return result
	end
	
	public function String GetAdminServer(
		DAPINODE		node )
		
		String		adminServer
			
		if ( IsDefined( node ) && IsDefined( node.pExtendedData ) &&
				IsDefined( node.pExtendedData.AdminServer ) )
					
			adminServer = node.pExtendedData.AdminServer
		end
			
		return adminServer
	end
	
	public function List GetConnectionInfo(
		DAPINODE		node,
		String			adminServer		= '' )
			
		List		currentOTAdminConnectInfo = {}
			
		if ( ( Length( adminServer ) == 0 ) && IsDefined( node ) )
			adminServer = .GetAdminServer( node )
		end

		if ( Length( adminServer ) > 0 )
			String cnctName = $Kernel.SystemPreferences.GetPrefGeneral( 'DftConnection' )
			Assoc prgAssoc = $LLIApi.PrgSession.CreateNewNamed( cnctName, { "Admin", undefined } )
			currentOTAdminConnectInfo = $OTADMIN.GetConnectionInfo( prgAssoc.pSession, adminServer )
		end

		return currentOTAdminConnectInfo
	end
	
end
