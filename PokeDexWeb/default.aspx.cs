using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PokeDexWeb
{
    public partial class _default : System.Web.UI.Page
    {
        private class pminfo
        {
            private string num, name, imgUrl;
            private int gen = 0;

            public string ImgUrl
            {
                get
                {
                    return imgUrl;
                }

                set
                {
                    imgUrl = value;
                }
            }

            public string Name
            {
                get
                {
                    return name;
                }

                set
                {
                    name = value;
                }
            }

            public string Num
            {
                get
                {
                    return num;
                }

                set
                {
                    num = value;
                }
            }

            public int Gen
            {
                get
                {
                    return gen;
                }

                set
                {
                    gen = value;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string tmpSQL = @"SELECT i.NationalNumber AS 'num', i.NameCHT AS 'name', d.ImgUrl AS 'imgUrl'
FROM PokemonIndex i
LEFT JOIN PokemonDetail d ON i.NationalNumber = d.NationalNumber AND d.Forme = 'normal'
ORDER BY i.NationalNumber ASC";

            DataTable tmpDT = DataBaseUsage.GetDataTableFromMySqlDB(DataBaseUsage.PokedexConnectionString, tmpSQL);

            JavaScriptSerializer tmpSerializer = new JavaScriptSerializer();

            List<pminfo> pmList = new List<pminfo>();
            foreach (DataRow tmpRow in tmpDT.Rows)
            {
                pminfo tmpInfo = new pminfo();
                tmpInfo.Num = int.Parse(tmpRow["num"].ToString()).ToString("00#");
                tmpInfo.Name = tmpRow["name"].ToString();
                tmpInfo.ImgUrl = tmpRow["imgUrl"].ToString();

                int tmpNum = int.Parse(tmpRow["num"].ToString());
                if (tmpNum <= 151) tmpInfo.Gen = 1;
                else if (tmpNum > 151 && tmpNum <= 251) tmpInfo.Gen = 2;
                else if (tmpNum > 251 && tmpNum <= 386) tmpInfo.Gen = 3;
                else if (tmpNum > 386 && tmpNum <= 493) tmpInfo.Gen = 4;
                else if (tmpNum > 493 && tmpNum <= 649) tmpInfo.Gen = 5;
                else if (tmpNum > 649 && tmpNum <= 721) tmpInfo.Gen = 6;

                pmList.Add(tmpInfo);
            }

            jsDeclare.Text = "<script type='text/javascript'>var pm_list = " + tmpSerializer.Serialize(pmList) + ";</script>";
        }
    }

}