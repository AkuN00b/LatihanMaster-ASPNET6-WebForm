using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace LatihanMaster.Pages
{
    public partial class Mobil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadData();
                loadDDL();
            }

            gridDataMobil.Width = Unit.Percentage(100);
        }

        protected void loadData()
        {
            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            connection.Open();
                
            SqlCommand cmd = new SqlCommand("sp_getDataMobil", connection);
            cmd.Parameters.AddWithValue("@query", txtCari.Text);

            cmd.CommandType = CommandType.StoredProcedure;
            dt.Load(cmd.ExecuteReader());

            gridDataMobil.DataSource = dt;
            gridDataMobil.DataBind();

            connection.Close();
        }

        protected void loadDDL()
        {
            SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            conn.Open();

            DDLJenisMobil.DataSource = "";
            DDLJenisMobil.Items.Clear();
            SqlCommand com = new SqlCommand();
            com.Connection = conn;
            com.CommandText = "sp_getDataJenisMobil";
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@query", "");

            SqlDataAdapter adap = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            adap.Fill(dt);

            DDLJenisMobil.DataSource = dt;
            DDLJenisMobil.DataTextField = "nama_jenis_mobil";
            DDLJenisMobil.DataValueField = "id_jenis_mobil";
            DDLJenisMobil.DataBind();
            DDLJenisMobil.Items.Insert(0, new ListItem("-- Pilih Jenis Mobil --", ""));
        }

        protected void btnTambah_Click(object sender, EventArgs e)
        {
            clearForm();
            panelView.Visible = false;
            panelManipulasiData.Visible = true;
            literalTitle.Text = "Form Tambah Data Mobil";
            btnKirim.Text = "Tambah";
        }

        protected void clearForm()
        {
            hiddenID.Text = "";
            txtNamaMobil.Text = "";
            txtMerkMobil.Text = "";
            txtHargaMobil.Text = "";
        }

        protected void btnCari_Click(object sender, EventArgs e)
        {
            loadData();
        }

        protected void gridDataMobil_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridDataMobil.PageIndex = e.NewPageIndex;
            loadData();
        }

        protected void gridDataMobil_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Page")
            {
                string tempId = gridDataMobil.DataKeys[Convert.ToInt32(e.CommandArgument)].Value.ToString();

                if (e.CommandName == "Hapus")
                {
                    deleteDataMobil(tempId);
                }
                else if (e.CommandName == "Ubah")
                {
                    hiddenID.Text = tempId;
                    panelView.Visible = false;
                    panelManipulasiData.Visible = true;
                    literalTitle.Text = "Form Ubah Data Mobil";
                    btnKirim.Text = "Perbarui";

                    try
                    {
                        DataTable dt = new DataTable();

                        SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                        conn.Open();

                        SqlCommand command = new SqlCommand("sp_getDataForUpdateMobil", conn);
                        command.Parameters.AddWithValue("@id", tempId);
                        command.CommandType = CommandType.StoredProcedure;

                        dt.Load(command.ExecuteReader());

                        txtNamaMobil.Text = dt.Rows[0][0].ToString();
                        txtMerkMobil.Text = dt.Rows[0][1].ToString();
                        txtHargaMobil.Text = dt.Rows[0][2].ToString();
                        DDLJenisMobil.SelectedValue = dt.Rows[0][3].ToString();

                        conn.Close();
                    }
                    catch { }
                }
            }
        }

        protected void deleteDataMobil(string id)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("sp_DeleteMobil", conn);
                command.Parameters.AddWithValue("@id", id);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }

        protected void btnKirim_Click(object sender, EventArgs e)
        {
            if (hiddenID.Text.Equals(""))
                createDataMobil();
            else
                updateDataMobil(hiddenID.Text);

            panelView.Visible = true;
            panelManipulasiData.Visible = false;
        }

        protected void createDataMobil()
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("sp_InsertMobil", conn);
                command.Parameters.AddWithValue("@namaMobil", txtNamaMobil.Text);
                command.Parameters.AddWithValue("@merkMobil", txtMerkMobil.Text);
                command.Parameters.AddWithValue("@hargaMobil", txtHargaMobil.Text);
                command.Parameters.AddWithValue("@idJenisMobil", DDLJenisMobil.SelectedValue);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }

        protected void updateDataMobil(string id)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("sp_UpdateMobil", conn);
                command.Parameters.AddWithValue("@id", id);
                command.Parameters.AddWithValue("@namaMobil", txtNamaMobil.Text);
                command.Parameters.AddWithValue("@merkMobil", txtMerkMobil.Text);
                command.Parameters.AddWithValue("@hargaMobil", txtHargaMobil.Text);
                command.Parameters.AddWithValue("@idJenisMobil", DDLJenisMobil.SelectedValue);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }
    }
}
