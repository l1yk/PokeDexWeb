using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

public class DataBaseUsage
{
    public static string PokedexConnectionString = @"server=elric.ddns.net;uid=pokedex;database=pokedex;password=lo820510;";

    /// <summary>從MySQL資料庫取得DataTable</summary>
    /// <param name="connectionString">連接字串</param>
    /// <param name="sql">SQL查詢</param>
    /// <returns>含資料的DataTable</returns>
    public static DataTable GetDataTableFromDB(string connectionString, string sql)
    {
        return GetDataTableFromDB(connectionString, sql, null);
    }

    /// <summary>透過含參數的查詢，從MySQL資料庫取得DataTable</summary>
    /// <param name="connectionString">連接字串</param>
    /// <param name="sql">SQL查詢</param>
    /// <param name="args">參數</param>
    /// <returns>含資料的DataTable</returns>
    public static DataTable GetDataTableFromDB(string connectionString, string sql, Dictionary<string, string> args)
    {
        DataTable RsltDT = new DataTable();

        // 建立MySQL資料庫連接
        using (MySqlConnection conn = new MySqlConnection(connectionString))
        {

            // 開啟連接
            conn.Open();

            // 建立MySQL命令
            MySqlCommand SqlCmd = new MySqlCommand(sql, conn);

            if (args != null && args.Count > 0)
            {
                foreach (string param in args.Keys)
                {
                    SqlCmd.Parameters.AddWithValue(param, args[param]);
                }
            }

            // 執行命令並讀取資料後建立成DataTable
            try
            {
                using (MySqlDataReader reader = SqlCmd.ExecuteReader())
                {
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        RsltDT.Columns.Add(reader.GetName(i));
                    }
                    while (reader.Read())
                    {
                        if (reader.HasRows)
                        {
                            DataRow tmpRow = RsltDT.NewRow();
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                tmpRow[i] = reader[i];
                            }
                            RsltDT.Rows.Add(tmpRow);
                        }
                    }
                }
            }
            catch (Exception)
            {

            }
        }
        return RsltDT;
    }
}