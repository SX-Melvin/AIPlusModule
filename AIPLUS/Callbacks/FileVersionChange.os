package AIPLUS::Callbacks

public Object FileVersionChange inherits LLIAPI::NodeCallbacks
	override	Boolean	fEnabled = TRUE
	override	List	fSubTypes = {144}

	/*
	 * Called after a version is added to an object.
	 *
	 * @param {Object} dapiCtx 
	 * @param {DAPINODE} node 
	 * @param {Dynamic} addVerInfo 
	 * @param {Dynamic} context 
	 *
	 * @return {Assoc} 
	 * @return {Boolean} ok 
	 * @return {String} errMsg 
	 * @return {Dynamic} apiError 
	 */
	override function Assoc CBAddVersionPost(
		Object			dapiCtx,
		DAPINODE		node,
		Dynamic			addVerInfo,
		Dynamic			context			= UNDEFINED )

		Assoc   rtnVal
		Dynamic apiError
		String  errMsg

		Boolean ok = TRUE
		
		$aiplus.AIPlusDatabase.InsertVersion(node.pID, node.pPARENTID, node.pVERSIONNUM, node.pNAME)

		rtnVal.ok = ok
		rtnVal.errMsg = errMsg
		rtnVal.apiError = apiError

		return rtnVal

	end

	override function Assoc CBDeleteInfo( DAPINODE node, Dynamic deleteInfo, Dynamic context = UNDEFINED )

		Assoc   rtnVal
		Dynamic apiError
		String  errMsg

		Integer status = DAPI.OK
		Boolean ok = TRUE

		$aiplus.AIPlusDatabase.DeleteVersion(node.pID)

		rtnVal.OK = ok
		rtnVal.ErrMsg = errMsg
		rtnVal.ApiError = apiError
		rtnVal.Status = status

		return rtnVal

	end

end
