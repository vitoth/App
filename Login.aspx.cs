using App.App_Code;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace App
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string LoginUser(string username, string password, string rememberMe)
        {
            SqlConnection conn = new SqlConnection(@"Data Source = SQL5017.myASP.NET; Initial Catalog = DB_9DF6F6_db; User Id = DB_9DF6F6_db_admin; Password = database321;");
   
            try
            {
                bool remember = false;
                if (rememberMe == "true") remember = true;

                string returnUrl = "";

                using (conn)
                {
                    conn.Open();
                    string SQLI = "SELECT * FROM [User] WHERE Name = @Name1 AND Pass = @Pass1"; 
                    SqlCommand command = new SqlCommand(SQLI, conn);
                    using (command)
                    {
                        CultureInfo provider = CultureInfo.InvariantCulture;
                        command.Parameters.Add(new SqlParameter("Name1", username)); 
                        command.Parameters.Add(new SqlParameter("Pass1", password));
                        if (command.ExecuteReader().HasRows) 
                        {
                            
                            FormsAuthentication.SetAuthCookie(username, remember);
                            FormsAuthenticationTicket ticket;
                            if (remember)
                            {
                                ticket = new FormsAuthenticationTicket(
                                    1,
                                    username,
                                    DateTime.Now,
                                    DateTime.Now.AddDays(99),
                                    true,
                                    null 
                                    );
                            }
                            else
                            {
                                ticket = new FormsAuthenticationTicket(
                                    1,
                                    username,
                                    DateTime.Now,
                                    DateTime.Now.AddMinutes(10),
                                    false,
                                    null
                                    );
                            }
                           
                            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket));
                            HttpContext.Current.Response.Cookies.Add(cookie);

                            if (HttpContext.Current.Request.QueryString["ReturnUrl"] == null)
                            {
                                returnUrl = "Default.aspx";
                            }
                            else
                            {
                                returnUrl = HttpContext.Current.Request.QueryString["ReturnUrl"];
                            }

                            return returnUrl;
                        }
                        else
                        {
                            return "error";

                        }

                    }
                }



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