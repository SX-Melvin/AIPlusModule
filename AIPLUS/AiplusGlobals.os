package AIPLUS

public Object AiplusGlobals inherits KERNEL::Globals
	
	// CONFIGURATION
	public object CommonConfig = AIPlus::Config::Common
	
	// UTILS
	public object Logs = AIPlus::Utils::Logs
	public object CommonUtils = AIPlus::Utils::Common
	
	// Database
	public Object AIPlusDatabase = AIPlus::Database::AIPlus
	public Object OTCSDatabase = AIPlus::Database::OTCS
	
end
