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
            DataTable tmpDT = new DataTable();
            string tmpSQL = string.Empty;
            Dictionary<string, string> SqlArgs = new Dictionary<string, string>();

            int pokenum = 1;

            if (!string.IsNullOrEmpty(Request.QueryString["n"])) pokenum = int.Parse(Request.QueryString["n"]);

            tmpSQL = @"
SELECT NationalNumber, NameCHT, NameJPN, NameENG
FROM PokemonIndex
WHERE NationalNumber = @dexnum";

            SqlArgs.Add("@dexnum", pokenum.ToString("000"));

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