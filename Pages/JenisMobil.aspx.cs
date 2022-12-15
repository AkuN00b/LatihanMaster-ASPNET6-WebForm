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
    public partial class JenisMobil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadData();
            }

            gridDataJenisMobil.Width = Unit.Percentage(100);
        }

        protected void loadData()
        {
            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            connection.Open();

            SqlCommand cmd = new SqlCommand("sp_getDataJenisMobil", connection);
            cmd.Parameters.AddWithValue("@query", txtCari.Text);
            cmd.CommandType = CommandType.StoredProcedure;
            dt.Load(cmd.ExecuteReader());

            gridDataJenisMobil.DataSource = dt;
            gridDataJenisMobil.DataBind();

            connection.Close();
        }

        protected void btnTambah_Click(object sender, EventArgs e)
        {
            clearForm();
            panelView.Visible = false;
            panelManipulasiData.Visible = true;
            literalTitle.Text = "Form Tambah Data Jenis Mobil";
            btnKirim.Text = "Tambah";
        }

        protected void btnCari_Click(object sender, EventArgs e)
        {
            loadData();
        }

        protected void gridDataJenisMobil_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridDataJenisMobil.PageIndex = e.NewPageIndex;
            loadData();
        }

        protected void gridDataJenisMobil_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Page")
            {
                string tempId = gridDataJenisMobil.DataKeys[Convert.ToInt32(e.CommandArgument)].Value.ToString();

                if (e.CommandName == "Hapus")
                {
                    deleteDataJenisMobil(tempId);
                }
                else if (e.CommandName == "Ubah")
                {
                    hiddenID.Text = tempId;
                    panelView.Visible = false;
                    panelManipulasiData.Visible = true;
                    literalTitle.Text = "Form Ubah Data Jenis Mobil";
                    btnKirim.Text = "Perbarui";

                    try
                    {
                        DataTable dt = new DataTable();

                        SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                        conn.Open();

                        SqlCommand command = new SqlCommand("sp_getDataForUpdateJenisMobil", conn);
                        command.Parameters.AddWithValue("@id", tempId);
                        command.CommandType = CommandType.StoredProcedure;

                        dt.Load(command.ExecuteReader());

                        txtNamaJenisMobil.Text = dt.Rows[0][0].ToString();

                        conn.Close();
                    }
                    catch { }
                }
            }
        }

        protected void btnKirim_Click(object sender, EventArgs e)
        {
            if (hiddenID.Text.Equals(""))
                createDataJenisMobil();
            else
                updateDataJenisMobil(hiddenID.Text);

            panelView.Visible = true;
            panelManipulasiData.Visible = false;
        }

        protected void createDataJenisMobil()
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("sp_InsertJenisMobil", conn);
                command.Parameters.AddWithValue("@namaJenisMobil", txtNamaJenisMobil.Text);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }

        protected void updateDataJenisMobil(string id)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("sp_UpdateJenisMobil", conn);
                command.Parameters.AddWithValue("@id", id);
                command.Parameters.AddWithValue("@namaJenisMobil", txtNamaJenisMobil.Text);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }

        protected void deleteDataJenisMobil(string id)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("sp_DeleteJenisMobil", conn);
                command.Parameters.AddWithValue("@id", id);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }

        protected void clearForm()
        {
            hiddenID.Text = "";
            txtNamaJenisMobil.Text = "";
        }
    }
}