package AIPLUS::Database

public Object OTCS inherits AIPLUS::AiplusRoot
	public string DTreeTable = "DTree"
	
	public function dynamic GetNodeByID(long nodeID)
		String		query
		dynamic result = {}
		
		query = Str.Format(
			"SELECT * FROM %1 " +
			"WHERE DataID = :A1",
			.DTreeTable
		)
		dynamic data = .RunQuery(query, {nodeId})
		
		if(IsDefined(data[1].DataID))
			result = data[1]
		end

		return result
	end
	
	function Dynamic RunQuery( String querySQL, List params = undefined )
		Dynamic     result
		String      errMsg
		
		String dbHostName = $KERNEL.SystemPreferences.GetPref($aiplus.CommonConfig.ConfigSection, 'OverrideDbServerName')
		String dbName = $KERNEL.SystemPreferences.GetPref($aiplus.CommonConfig.ConfigSection, 'OverrideDbName')
		
		CAPICONNECT connection = $pSession.fDBConnect.fConnection

		if(IsDefined(dbHostName) && IsDefined(dbName))
			Object dbInfoPkg = $LLIApi.DbInfoPkg
			String cnctName = $Kernel.SystemPreferences.GetPrefGeneral( 'DftConnection' )
			Dynamic sessionInfo = $LLIApi.DbInfoPkg.FindRec( cnctName )
			
			connection = CAPI.AllocConnect( \
				dbInfoPkg.MapServerType( sessionInfo ), \
				dbHostName, \
				dbName, \
				dbInfoPkg.GetConnectField( sessionInfo, 'username' ), \
				dbInfoPkg.GetConnectField( sessionInfo, 'password' ), \
				Undefined, \
				Undefined, \
				0 )			
		end
		
		if ( IsUndefined( params ) )
			$aiplus.Logs.Info(Str.Format("Executing: %1", querySQL))
			result = CAPI.Exec( connection, querySQL )
		else
			$aiplus.Logs.Info(Str.Format("Executing: %1 - Params: %2", querySQL, Str.Join(params, " | ")))
			result = CAPI.Exec( connection, querySQL, params )
		end
		
		if ( IsError( result ) )
			errMsg = "Error when executing the query:"
			errMsg += Str.Format( errMsg + " %1", result )
			errMsg += " | Executed query: "
			errMsg += querySQL
			$SystemMonitoring.LogsUtils.Err( errMsg )
			return result
		end

		return result
	end
end
