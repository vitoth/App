using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;

namespace App.App_Code
{
    public class Entry
    {
        public int Id { get; set; }
        public int IdUser { get; set; }
        public DateTime SelectedDateStart { get; set; }
        public DateTime SelectedDateEnd { get; set; }


        public static List<Entry> LoadAll()
        {
            SqlConnection conn = new SqlConnection(@"Data Source = SQL5017.myASP.NET; Initial Catalog = DB_9DF6F6_db; User Id = DB_9DF6F6_db_admin; Password = database321;");
            List<Entry> all = new List<Entry>();
            try
            {
                using (conn)
                {
                    conn.Open();
                    using (SqlCommand command = new SqlCommand("SELECT * FROM Calendar", conn))
                    {
                        SqlDataReader reader = command.ExecuteReader();
                        while (reader.Read())
                        {
                            Entry e = new Entry();
                            e.Id = reader.GetInt32(0); 
                            e.IdUser = reader.GetInt32(1);
                            e.SelectedDateStart = reader.GetDateTime(2);
                            e.SelectedDateEnd = reader.GetDateTime(3);
                            all.Add(e);
                        }
                    }
                }
                return all;
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                conn.Close();
            }
        }

        public bool Add()
        {
            SqlConnection conn = new SqlConnection(@"Data Source = localhost\SQLEXPRESS; Initial Catalog = DemoDb; User Id = DemoDb; Password = DemoDb321;");
            try
            {
                using (conn)
                {
                    conn.Open();
                    string SQLI = "Insert into Entries (UserId, DateStart, DateEnd) VALUES (@IdUser, @SelectedDateStart, @SelectedDateEnd)";
                    SqlCommand command = new SqlCommand(SQLI, conn);
                    using (command)
                    {
                        if (command.ExecuteNonQuery() > 0)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                conn.Close();
            }
        }

        public bool Delete()
        {
            SqlConnection conn = new SqlConnection(@"Data Source = localhost\SQLEXPRESS; Initial Catalog = DemoDb; User Id = DemoDb; Password = DemoDb321;");
            try
            {
                using (conn)
                {
                    conn.Open();
                    string SQLI = "DELETE from Entries where Id=@Id";
                    SqlCommand command = new SqlCommand(SQLI, conn);
                    using (command)
                    {
                        command.Parameters.Add(new SqlParameter("Id", Id));
                        if (command.ExecuteNonQuery() > 0)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}