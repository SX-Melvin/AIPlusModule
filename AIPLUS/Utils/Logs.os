package AIPLUS::Utils

public Object Logs inherits AIPLUS::AiplusRoot
	String  LogDateFormat = "%Y-%m-%d"
	String DateNowFormat = "%Y-%m-%d %H:%M:%S"
	
	// Print Debug Purpose File, Should Only Implemented During Development
	function File Deb(string text, string logPath = "./logs/AIPlus/debugs/", string fileName = "test.log")
		String iName
		File iFile
		
		iName = logPath + fileName
		
		if(!File.Exists(iName))
			$Aiplus.CommonUtils.CreateIfNotExist(logPath)
			iFile = File.Open( iName, File.WriteMode )
		else
			iFile = File.Open( iName, File.AppendMode )
		end
		
		File.Write(iFile, Date.DateToString(Date.NOW(), .DateNowFormat) + " [DEBUG] => " + text)
		File.Close(iFile)
		
		return iFile
	end
	
	// Used for step-by-step execution tracing, internal states, or diagnostic information that developers might need when debugging deeply
	function Void Trace(String text)
		File iFile = .GetLogFile()
		File.Write(iFile, Date.DateToString(Date.NOW(), .DateNowFormat) + " [TRACE] => " + text)
		File.Close(iFile)
	end
	
	// General application flow messages — things you want to know happened successfully
	function Void Info(String text)
		File iFile = .GetLogFile()
		File.Write(iFile, Date.DateToString(Date.NOW(), .DateNowFormat) + " [INFO] => " + text)
		File.Close(iFile)
	end
	
	// Indicates something unexpected happened, but the app can continue running
	function Void Warn(String text)
		File iFile = .GetLogFile()
		File.Write(iFile, Date.DateToString(Date.NOW(), .DateNowFormat) + " [WARNING] => " + text)
		File.Close(iFile)
	end
	
	// A problem occurred, and the operation failed, but the application is still running
	function Void Err(String text)
		File iFile = .GetLogFile()
		File.Write(iFile, Date.DateToString(Date.NOW(), .DateNowFormat) + " [ERROR] => " + text)
		File.Close(iFile)
	end
	
	// Returning file object for logging
	function File GetLogFile()
		String		logPath = $Aiplus.CommonConfig.LogsPathConfigDefault()
		File   		iFile
		
		//add last slash if there isn't any
		if(logPath[Length(logPath)] != "/")
			logPath += "/"
		end
		
		$Aiplus.CommonUtils.CreateIfNotExist(logPath)
		
		String 		dateStr 	= Date.DateToString(Date.NOW(), "%Y-%m-%d")
		String		iName = logPath + "AIPlus" + '_' + dateStr + '.log'
		
		if(!File.Exists(iName))
			File.Create(iName)
			iFile = File.Open( iName, File.WriteMode )
		else
			iFile = File.Open( iName, File.AppendMode )
		end
		
		return iFile
	end
end
