local _M = {
	Error={
		EType={
			None = 0,
			UserLoggedIn = 1,
			NoSetNickname = 2,
			NoneConfigID = 3,
			Config = 4,
			ID = 5,
			Unfinished = 6,
			NoAccept = 7,
			NoParam = 8,
			UnExpectedError = 10,
			ConfigError = 11,
			OutOfDate = 12,
			LessGold = 13,
			LessDiamond = 14,
			LessTimes = 15,
			LessProp = 16,
			LessTech = 17,
			NoneRole = 1001,
			NoneProp = 1002,
			NoneEquipment = 1003,
			NoneBox = 1004,
			NoneGold = 1005,
			NonoDiamond = 1006,
			NoneMission = 1011,
			OperationNotPermit = 2001,
			NotBuy = 3001,
		},
	},
	MissionEvent={
		MType={
			None = 0,
			Kill = 1,
			Collect = 2,
			MakeProp = 3,
			Build = 4,
			Alive = 5,
			UseDiamond = 6,
			UseTech = 7,
			UseItem = 8,
			UpgradeTech = 9,
			UpgradeTalent = 10,
			FinishMission = 11,
			FinishChapter = 12,
			MakeEquip = 13,
		},
	},
}
return table.readonly(_M)