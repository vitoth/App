using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace App.App_Code
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Pass { get; set; }
        public string Group { get; set; }
        
        public static List<User> LoadAll()
        {
            SqlConnection conn = new SqlConnection(@"Data Source = SQL5017.myASP.NET; Initial Catalog = DB_9DF6F6_db; User Id = DB_9DF6F6_db_admin; Password = database321;");

            List<User> all = new List<User>();
            try
            {
                using (conn)
                {
                    conn.Open();
                    using (SqlCommand command = new SqlCommand("SELECT * FROM [User]", conn))
                    {
                        SqlDataReader reader = command.ExecuteReader();
                        while (reader.Read())
                        {
                            User u = new User();
                            u.Id = reader.GetInt32(0);
                            u.Name = reader.GetString(1);
                            u.Pass = reader.GetString(2);
                            u.Group = reader.GetString(3);
                            all.Add(u);
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

    }
}