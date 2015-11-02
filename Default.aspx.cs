using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace App
{
    public partial class Default : System.Web.UI.Page
    {
        static App_Code.User user = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            user = App_Code.User.LoadAll().FirstOrDefault(x => x.Name == Context.User.Identity.Name); 
            if (user != null)
            {
                this.lblUsername.Text = user.Name;
            }
            else
            {
                //Response.Redirect("Login.aspx");
            }
        }

        [WebMethod]
        public static string GetUsers()
        {
            //if (user.Group == "00")
            {
                var allUsers = App_Code.User.LoadAll();
                return DataSetToJSON(allUsers);
            }
            //else
            //{
            //    var allUsers = App_Code.User.LoadAll().Where(x => x.Id == user.Id); 
            //    return DataSetToJSON(allUsers);
            //}

        }

        [WebMethod]
        public static string GetEntries(string iduser)
        {
            return DataSetToJSON(App_Code.Entry.LoadAll().Where(x => x.IdUser == Int32.Parse(iduser)));
            
        }

        public static string DataSetToJSON(object o)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(o);
        }
    }
}