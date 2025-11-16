package AIPLUS::Database

public Object AIPlus inherits AIPLUS::AiplusRoot
	
	public string VersionsTable = "AIPlus_FileVersions"
	
	public function dynamic GetVersionByIDAndVersionNum(long nodeID)
		String		query
		dynamic result = Undefined
		
		query = Str.Format(
			"SELECT * FROM %1 " +
			"WHERE NodeID = :A1",
			.VersionsTable
		)
		dynamic data = .RunQuery(query, {nodeId})
		
		if(IsDefined(data[1]) && IsDefined(data[1].NodeID))
			result = data[1]
		end

		return result
	end
	
	public function void InsertVersion(long nodeID, long parentID, integer verNum, string name)
		dynamic getByNodeID = .GetVersionByIDAndVersionNum(nodeID)
		if(IsDefined(getByNodeID))
			.UpdateVersion(nodeId, parentID, verNum, name)
			return
		end
		
		string query = Str.Format(
			"INSERT INTO %1 " +
			"(VerNum, NodeID, Name, ParentID) " +
			"VALUES(:A1, :A2, :A3, :A4)",
			.VersionsTable
		)
		.RunQuery(query, {verNum, nodeId, name, parentID})
	end
	
	public function void UpdateVersion(long nodeID, long parentID, integer verNum, string name)
		string query = Str.Format(
			"UPDATE %1 " +
			"SET VerNum=:A1, Name=':A2', ParentID=:A3 " +
			"NodeID = :A4",
			.VersionsTable
		)
		.RunQuery(query, {verNum, name, parentID, nodeId})
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
			$aiplus.Logs.Err( errMsg )
			return result
		end

		return result
	end
end
