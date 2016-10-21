using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PokeDexWeb
{
    public partial class dex : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region 取得對應表
            // 取得type的ID,名稱對應表
            if (Session["TypeData"] == null)
            {
                Dictionary<int, string> typeDic = new Dictionary<int, string>();
                DataTable tmpDTData = DataBaseUsage.GetDataTableFromDB(DataBaseUsage.PokedexConnectionString, "SELECT ID, TypeNameTW FROM `Type`");

                if (tmpDTData.Rows.Count > 0)
                {
                    foreach (DataRow tmpRow in tmpDTData.Rows)
                    {
                        typeDic.Add(int.Parse(tmpRow["ID"].ToString()), tmpRow["TypeNameCHT"].ToString());
                    }
                }

                Session.Add("TypeData", typeDic);
            }

            // 取得EggGroup的ID,名稱對應表
            if (Session["EggGroupData"] == null)
            {
                Dictionary<int, string> eggGroupData = new Dictionary<int, string>();
                DataTable tmpDTData = DataBaseUsage.GetDataTableFromDB(DataBaseUsage.PokedexConnectionString, "SELECT ID, Name FROM `EggGroup`");

                if (tmpDTData.Rows.Count > 0)
                {
                    foreach (DataRow tmpRow in tmpDTData.Rows)
                    {
                        eggGroupData.Add(int.Parse(tmpRow["ID"].ToString()), tmpRow["Name"].ToString());
                    }
                }

                Session.Add("EggGroupData", eggGroupData);
            }

            // 取得GenderRatio的ID,名稱對應表
            if (Session["GenderRatioData"] == null)
            {
                Dictionary<int, string> genderRatioData = new Dictionary<int, string>();
                DataTable tmpDTData = DataBaseUsage.GetDataTableFromDB(DataBaseUsage.PokedexConnectionString, "SELECT ID, GenderRatio FROM `GenderRatio`");

                if (tmpDTData.Rows.Count > 0)
                {
                    foreach (DataRow tmpRow in tmpDTData.Rows)
                    {
                        genderRatioData.Add(int.Parse(tmpRow["ID"].ToString()), tmpRow["GenderRatio"].ToString());
                    }
                }

                Session.Add("GenderRatioData", genderRatioData);
            }

            // 取得特性的ID,內容對應表
            if (Session["AbilityData"] == null)
            {
                Dictionary<int, string[]> abilityDic = new Dictionary<int, string[]>();
                DataTable tmpDTData = DataBaseUsage.GetDataTableFromDB(DataBaseUsage.PokedexConnectionString, "SELECT * FROM `Ability`");

                if (tmpDTData.Rows.Count > 0)
                {
                    foreach (DataRow tmpRow in tmpDTData.Rows)
                    {
                        string[] abilityData = new string[4];
                        abilityData[0] = tmpRow["AbilityNameCHT"].ToString();
                        abilityData[1] = tmpRow["AbilityNameJPN"].ToString();
                        abilityData[2] = tmpRow["AbilityNameENG"].ToString();
                        abilityData[3] = tmpRow["AbilityInfo"].ToString();
                        abilityDic.Add(int.Parse(tmpRow["ID"].ToString()), abilityData);
                    }
                }

                Session.Add("AbilityData", abilityDic);
            }
            #endregion

            Dictionary<int, string> dicType = (Dictionary<int, string>)Session["TypeData"];
            Dictionary<int, string> dicEggGroup = (Dictionary<int, string>)Session["EggGroupData"];
            Dictionary<int, string> dicGenderRatio = (Dictionary<int, string>)Session["GenderRatioData"];
            Dictionary<int, string[]> dicAbility = (Dictionary<int, string[]>)Session["AbilityData"];

            DataTable tmpDT = new DataTable();
            string tmpSQL = string.Empty;
            Dictionary<string, string> SqlArgs = new Dictionary<string, string>();

            int pokenum = 1;

            if (!string.IsNullOrEmpty(Request.QueryString["n"])) pokenum = int.Parse(Request.QueryString["n"]);

            tmpSQL = @"
SELECT
    i.NameCHT, i.NameJPN, i.NameENG, d.Type1_ID, d.Type2_ID
    , d.Height, d.Weight, d.EggGroup1_ID, d.EggGroup2_ID, d.HatchCount
    , d.Stats_HP, d.Stats_Attack, d.Stats_Defence, d.`Stats_Sp.Attack`, d.`Stats_Sp.Defence`, d.Stats_Speed
    , d.EV_HP, d.EV_Attack, d.EV_Defence, d.`EV_Sp.Attack`, d.`EV_Sp.Defence`, d.EV_Speed
    , d.Ability1_ID, d.Ability2_ID, d.AbilityH_ID, i.GenderRatioID, d.ImgUrl
FROM PokemonDetail d
LEFT JOIN PokemonIndex i ON i.NationalNumber = d.NationalNumber
WHERE d.NationalNumber = @dexnum AND d.Forme = @forme";

            SqlArgs.Add("@dexnum", pokenum.ToString("000"));
            SqlArgs.Add("@forme", "normal");

            tmpDT = DataBaseUsage.GetDataTableFromDB(DataBaseUsage.PokedexConnectionString, tmpSQL, SqlArgs);

            if (tmpDT.Rows.Count > 0)
            {
                lblNationalNumber.Text = pokenum.ToString("000");
                lblNameCHT.Text = tmpDT.Rows[0]["NameCHT"].ToString();
                lblNameJPN.Text = tmpDT.Rows[0]["NameJPN"].ToString();
                lblNameENG.Text = tmpDT.Rows[0]["NameENG"].ToString();
            }
        }
    }
}