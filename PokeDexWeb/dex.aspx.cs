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
                Dictionary<int, string[]> typeDic = new Dictionary<int, string[]>();
                DataTable tmpDTData = DataBaseUsage.GetDataTableFromMySqlDB(DataBaseUsage.PokedexConnectionString, "SELECT ID, TypeNameCHT, ClassName FROM `Type` ORDER BY ID");

                if (tmpDTData.Rows.Count > 0)
                {
                    foreach (DataRow tmpRow in tmpDTData.Rows)
                    {
                        string[] typeData = new string[2];
                        typeData[0] = tmpRow["TypeNameCHT"].ToString();
                        typeData[1] = tmpRow["ClassName"].ToString();
                        typeDic.Add(int.Parse(tmpRow["ID"].ToString()), typeData);
                    }
                }

                Session.Add("TypeData", typeDic);
            }

            // 取得EggGroup的ID,名稱對應表
            if (Session["EggGroupData"] == null)
            {
                Dictionary<int, string> eggGroupData = new Dictionary<int, string>();
                DataTable tmpDTData = DataBaseUsage.GetDataTableFromMySqlDB(DataBaseUsage.PokedexConnectionString, "SELECT ID, Name FROM `EggGroup`");

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
                DataTable tmpDTData = DataBaseUsage.GetDataTableFromMySqlDB(DataBaseUsage.PokedexConnectionString, "SELECT ID, GenderRatio FROM `GenderRatio`");

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
                DataTable tmpDTData = DataBaseUsage.GetDataTableFromMySqlDB(DataBaseUsage.PokedexConnectionString, "SELECT * FROM `Ability`");

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

            Dictionary<int, string[]> dicType = (Dictionary<int, string[]>)Session["TypeData"];
            Dictionary<int, string> dicEggGroup = (Dictionary<int, string>)Session["EggGroupData"];
            Dictionary<int, string> dicGenderRatio = (Dictionary<int, string>)Session["GenderRatioData"];
            Dictionary<int, string[]> dicAbility = (Dictionary<int, string[]>)Session["AbilityData"];

            DataTable tmpDT = new DataTable();
            string tmpSQL = string.Empty;
            Dictionary<string, string> SqlArgs = new Dictionary<string, string>();

            int pokeNum = (new Random(Guid.NewGuid().GetHashCode()).Next() % 720) + 1;
            string pokeForme = "normal";

            if (!string.IsNullOrEmpty(Request.QueryString["n"])) pokeNum = int.Parse(Request.QueryString["n"]);
            if (!string.IsNullOrEmpty(Request.QueryString["forme"])) pokeForme = Request.QueryString["forme"];

            // 上一隻、下一隻
            if (pokeNum > 1)
            {
                linkPrevious.Text = "<img src='Images/PM_icon/" + (pokeNum - 1).ToString() + ".png' /><span style='display: inline-block; vertical-align: middle;'>" + (pokeNum - 1).ToString("000") + "</span>";
                linkPrevious.NavigateUrl = "/dex.aspx?n=" + (pokeNum - 1).ToString();
                linkPrevious.Visible = true;
            }
            if (pokeNum < 720)
            {
                linkNext.Text = "<img src='Images/PM_icon/" + (pokeNum + 1).ToString() + ".png' /><span style='display: inline-block; vertical-align: middle;'>" + (pokeNum + 1).ToString("000") + "</span>";
                linkNext.NavigateUrl = "/dex.aspx?n=" + (pokeNum + 1).ToString();
                linkNext.Visible = true;
            }

            // 取得型態列表
            List<ListItem> formeList = new List<ListItem>();
            using (DataTable formeDT = DataBaseUsage.GetDataTableFromMySqlDB(DataBaseUsage.PokedexConnectionString, "SELECT DISTINCT Forme, FormeName FROM PokemonDetail WHERE NationalNumber = " + pokeNum.ToString()))
            {
                if (formeDT.Rows.Count > 0)
                {
                    foreach (DataRow tmpRow in formeDT.Rows)
                    {
                        ListItem Item = new ListItem(tmpRow["FormeName"].ToString(), tmpRow["Forme"].ToString());
                        formeList.Add(Item);
                    }
                }
            }
            ddlForme.Items.Clear();
            ddlForme.Items.AddRange(formeList.ToArray());
            ddlForme.SelectedValue = pokeForme;

            if (ddlForme.Items.Count <= 1)
            {
                ddlPanel.Visible = false;
            }

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

            SqlArgs.Add("@dexnum", pokeNum.ToString("000"));
            SqlArgs.Add("@forme", pokeForme);

            tmpDT = DataBaseUsage.GetDataTableFromMySqlDB(DataBaseUsage.PokedexConnectionString, tmpSQL, SqlArgs);

            int type1_ID = 0, type2_ID = 0;
            int eggGroup1_ID = 0, eggGroup2_ID = 0;

            if (tmpDT.Rows.Count > 0)
            {
                type1_ID = int.Parse(tmpDT.Rows[0]["Type1_ID"].ToString());
                if (!string.IsNullOrEmpty(tmpDT.Rows[0]["Type2_ID"].ToString())) type2_ID = int.Parse(tmpDT.Rows[0]["Type2_ID"].ToString());
                eggGroup1_ID = int.Parse(tmpDT.Rows[0]["EggGroup1_ID"].ToString());
                if (!string.IsNullOrEmpty(tmpDT.Rows[0]["EggGroup2_ID"].ToString())) eggGroup2_ID = int.Parse(tmpDT.Rows[0]["EggGroup2_ID"].ToString());

                // 編號
                lblNationalNumber.Text = pokeNum.ToString("000");

                // 圖片
                imgProfile.ImageUrl = tmpDT.Rows[0]["ImgUrl"].ToString();

                // 名稱
                lblNameCHT.Text = "No." + pokeNum.ToString("000") + " " + tmpDT.Rows[0]["NameCHT"].ToString();
                lblNameCHT.Attributes["style"] = "display: inline-block; vertical-align: middle;";
                lblNameJPN.Text = tmpDT.Rows[0]["NameJPN"].ToString();
                lblNameENG.Text = tmpDT.Rows[0]["NameENG"].ToString();

                // 屬性
                lblType1.Text = dicType[type1_ID][0];
                lblType1.CssClass = dicType[type1_ID][1];
                if (!string.IsNullOrEmpty(tmpDT.Rows[0]["Type2_ID"].ToString()))
                {
                    lblType2.Text = dicType[type2_ID][0];
                    lblType2.CssClass = dicType[type2_ID][1];
                }

                // 身高體重
                lblHeight.Text = decimal.Parse(tmpDT.Rows[0]["Height"].ToString()).ToString("0.0") + "m";
                lblWeight.Text = decimal.Parse(tmpDT.Rows[0]["Weight"].ToString()).ToString("0.0") + "kg";

                // 性別比
                lblGenderRatio.Text = dicGenderRatio[int.Parse(tmpDT.Rows[0]["GenderRatioID"].ToString())];

                // 蛋相關
                List<string> tmpEggGroupList = new List<string>();
                tmpEggGroupList.Add(dicEggGroup[eggGroup1_ID]);
                if (!string.IsNullOrEmpty(tmpDT.Rows[0]["EggGroup2_ID"].ToString())) tmpEggGroupList.Add(dicEggGroup[eggGroup2_ID]);
                lblEggGroup.Text = string.Join("、", tmpEggGroupList.ToArray());
                lblHatchCount.Text = tmpDT.Rows[0]["HatchCount"].ToString() + "步";

                // 種族
                lblStatsHP.Text = tmpDT.Rows[0]["Stats_HP"].ToString();
                lblStatsAttack.Text = tmpDT.Rows[0]["Stats_Attack"].ToString();
                lblStatsDefence.Text = tmpDT.Rows[0]["Stats_Defence"].ToString();
                lblStatsSpAttack.Text = tmpDT.Rows[0]["Stats_Sp.Attack"].ToString();
                lblStatsSpDefence.Text = tmpDT.Rows[0]["Stats_Sp.Defence"].ToString();
                lblStatsSpeed.Text = tmpDT.Rows[0]["Stats_Speed"].ToString();
                divValueBarHP.Attributes["aria-valuenow"] = tmpDT.Rows[0]["Stats_HP"].ToString();
                divValueBarAttack.Attributes["aria-valuenow"] = tmpDT.Rows[0]["Stats_Attack"].ToString();
                divValueBarDefence.Attributes["aria-valuenow"] = tmpDT.Rows[0]["Stats_Defence"].ToString();
                divValueBarSpAttack.Attributes["aria-valuenow"] = tmpDT.Rows[0]["Stats_Sp.Attack"].ToString();
                divValueBarSpDefence.Attributes["aria-valuenow"] = tmpDT.Rows[0]["Stats_Sp.Defence"].ToString();
                divValueBarSpeed.Attributes["aria-valuenow"] = tmpDT.Rows[0]["Stats_Speed"].ToString();

                // 努力
                lblEVsHP.Text = !tmpDT.Rows[0]["EV_HP"].ToString().Equals("0") ? tmpDT.Rows[0]["EV_HP"].ToString() : "";
                lblEVsAttack.Text = !tmpDT.Rows[0]["EV_Attack"].ToString().Equals("0") ? tmpDT.Rows[0]["EV_Attack"].ToString() : "";
                lblEVsDefence.Text = !tmpDT.Rows[0]["EV_Defence"].ToString().Equals("0") ? tmpDT.Rows[0]["EV_Defence"].ToString() : "";
                lblEVsSpAttack.Text = !tmpDT.Rows[0]["EV_Sp.Attack"].ToString().Equals("0") ? tmpDT.Rows[0]["EV_Sp.Attack"].ToString() : "";
                lblEVsSpDefence.Text = !tmpDT.Rows[0]["EV_Sp.Defence"].ToString().Equals("0") ? tmpDT.Rows[0]["EV_Sp.Defence"].ToString() : "";
                lblEVsSpeed.Text = !tmpDT.Rows[0]["EV_Speed"].ToString().Equals("0") ? tmpDT.Rows[0]["EV_Speed"].ToString() : "";

                // 特性
                #region 特性一
                if (!string.IsNullOrEmpty(tmpDT.Rows[0]["Ability1_ID"].ToString()))
                {
                    int abilityIndex = int.Parse(tmpDT.Rows[0]["Ability1_ID"].ToString());
                    TableRow hRow = new TableHeaderRow();
                    TableRow iRow = new TableHeaderRow();

                    // 名稱
                    TableHeaderCell[] hCells = new TableHeaderCell[4];
                    hCells[0] = new TableHeaderCell();
                    hCells[0].CssClass = "type";
                    hCells[0].Text = "特性一";
                    for (int i = 1; i < 4; i++)
                    {
                        hCells[i] = new TableHeaderCell();
                        hCells[i].CssClass = "name";
                        hCells[i].Text = dicAbility[abilityIndex][i - 1];
                    }
                    hRow.Cells.AddRange(hCells);
                    tableAbility.Rows.Add(hRow);

                    // 效果
                    TableCell iCell = new TableCell();
                    iCell.ColumnSpan = 4;
                    iCell.Text = dicAbility[abilityIndex][3];
                    iRow.Cells.Add(iCell);
                    tableAbility.Rows.Add(iRow);
                }
                #endregion

                #region 特性二
                if (!string.IsNullOrEmpty(tmpDT.Rows[0]["Ability2_ID"].ToString()))
                {
                    int abilityIndex = int.Parse(tmpDT.Rows[0]["Ability2_ID"].ToString());
                    TableRow hRow = new TableHeaderRow();
                    TableRow iRow = new TableHeaderRow();

                    // 名稱
                    TableHeaderCell[] hCells = new TableHeaderCell[4];
                    hCells[0] = new TableHeaderCell();
                    hCells[0].CssClass = "type";
                    hCells[0].Text = "特性二";
                    for (int i = 1; i < 4; i++)
                    {
                        hCells[i] = new TableHeaderCell();
                        hCells[i].CssClass = "name";
                        hCells[i].Text = dicAbility[abilityIndex][i - 1];
                    }
                    hRow.Cells.AddRange(hCells);
                    tableAbility.Rows.Add(hRow);

                    // 效果
                    TableCell iCell = new TableCell();
                    iCell.ColumnSpan = 4;
                    iCell.Text = dicAbility[abilityIndex][3];
                    iRow.Cells.Add(iCell);
                    tableAbility.Rows.Add(iRow);
                }
                #endregion

                #region 隱藏特性
                if (!string.IsNullOrEmpty(tmpDT.Rows[0]["AbilityH_ID"].ToString()))
                {
                    int abilityIndex = int.Parse(tmpDT.Rows[0]["AbilityH_ID"].ToString());
                    TableRow hRow = new TableHeaderRow();
                    TableRow iRow = new TableHeaderRow();

                    // 名稱
                    TableHeaderCell[] hCells = new TableHeaderCell[4];
                    hCells[0] = new TableHeaderCell();
                    hCells[0].CssClass = "type";
                    hCells[0].Text = "隱藏特性";
                    for (int i = 1; i < 4; i++)
                    {
                        hCells[i] = new TableHeaderCell();
                        hCells[i].CssClass = "name";
                        hCells[i].Text = dicAbility[abilityIndex][i - 1];
                    }
                    hRow.Cells.AddRange(hCells);
                    tableAbility.Rows.Add(hRow);

                    // 效果
                    TableCell iCell = new TableCell();
                    iCell.ColumnSpan = 4;
                    iCell.Text = dicAbility[abilityIndex][3];
                    iRow.Cells.Add(iCell);
                    tableAbility.Rows.Add(iRow);
                }
                #endregion
            }
        }
    }
}