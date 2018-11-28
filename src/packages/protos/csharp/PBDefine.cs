using Google.Protobuf;
using System.Collections.Generic;
namespace Pb{
    public enum PBDefine{
        Unknow,
        Pack = 1,
        Error = 2,
        Operation = 3,
        CreateRole = 4,
        Decompose = 41,
        EnterChapter = 5,
        EnterSection = 6,
        FinishMission = 51,
        OpenBox = 31,
        GainBox = 32,
        Delete = 11,
        Role = 101,
        Prop = 1071,
        Props = 107,
        Equipments = 103,
        Chapter = 1021,
        Chapters = 102,
        Section = 1051,
        Sections = 105,
        Mission = 1041,
        Missions = 104,
        Box = 1061,
        Boxes = 106,
        Rewards = 108,
        SigninRecord = 12,
        SigninGet = 13,
        ShopGet = 22,
        ShopRecord = 21,
        MapRecordSave = 15
    }

    public static class PBRegister
    {
        public static void Register(ref Dictionary<PBDefine, MessageParser>dict)
        {
            dict.Add(PBDefine.Pack, Pack.Parser);
            dict.Add(PBDefine.Error, Error.Parser);
            dict.Add(PBDefine.Operation, Operation.Parser);
            dict.Add(PBDefine.CreateRole, CreateRole.Parser);
            dict.Add(PBDefine.Decompose, Decompose.Parser);
            dict.Add(PBDefine.EnterChapter, EnterChapter.Parser);
            dict.Add(PBDefine.EnterSection, EnterSection.Parser);
            dict.Add(PBDefine.FinishMission, FinishMission.Parser);
            dict.Add(PBDefine.OpenBox, OpenBox.Parser);
            dict.Add(PBDefine.GainBox, GainBox.Parser);
            dict.Add(PBDefine.Delete, Delete.Parser);
            dict.Add(PBDefine.Role, Role.Parser);
            dict.Add(PBDefine.Prop, Prop.Parser);
            dict.Add(PBDefine.Props, Props.Parser);
            dict.Add(PBDefine.Equipments, Equipments.Parser);
            dict.Add(PBDefine.Chapter, Chapter.Parser);
            dict.Add(PBDefine.Chapters, Chapters.Parser);
            dict.Add(PBDefine.Section, Section.Parser);
            dict.Add(PBDefine.Sections, Sections.Parser);
            dict.Add(PBDefine.Mission, Mission.Parser);
            dict.Add(PBDefine.Missions, Missions.Parser);
            dict.Add(PBDefine.Box, Box.Parser);
            dict.Add(PBDefine.Boxes, Boxes.Parser);
            dict.Add(PBDefine.Rewards, Rewards.Parser);
            dict.Add(PBDefine.SigninRecord, SigninRecord.Parser);
            dict.Add(PBDefine.SigninGet, SigninGet.Parser);
            dict.Add(PBDefine.ShopGet, ShopGet.Parser);
            dict.Add(PBDefine.ShopRecord, ShopRecord.Parser);
            dict.Add(PBDefine.MapRecordSave, MapRecordSave.Parser);
        }
    }
}