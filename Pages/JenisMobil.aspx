<%@ Page Title="" Language="C#" MasterPageFile="~/Layouts/LayoutMaster.Master" AutoEventWireup="true" CodeBehind="JenisMobil.aspx.cs" Inherits="LatihanMaster.Pages.JenisMobil" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding-left: 30px; padding-right: 30px;">
        <asp:Panel runat="server" ID="panelView">
            <h2>Lihat Jenis Mobil</h2>
            <hr />

            <asp:Button Text="+" ID="btnTambah" OnClick="btnTambah_Click" runat="server" />
            <asp:TextBox runat="server" ID="txtCari" placeholder="Pencarian" />
            <asp:Button Text="Cari" runat="server" ID="btnCari" OnClick="btnCari_Click" />

            <br />
            <br />

            <asp:GridView runat="server" ID="gridDataJenisMobil" AutoGenerateColumns="false" EmptyDataText="Tidak ada Data Jenis Mobil"
                ShowHeader="true" ShowHeaderWhenEmpty="true" PageSize="5" AllowPaging="true" AllowSorting="false"
                DataKeyNames="id_jenis_mobil" OnPageIndexChanging="gridDataJenisMobil_PageIndexChanging" OnRowCommand="gridDataJenisMobil_RowCommand"
                HeaderStyle-HorizontalAlign="Center">

                <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" />

                <Columns>
                    <asp:BoundField DataField="rownum" HeaderText="No" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="nama_jenis_mobil" HeaderText="Nama Jenis Mobil" ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="Aksi" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton Text="[Ubah]" ID="btnUbah" CommandName="Ubah" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>&nbsp;
                            <asp:LinkButton Text="[Hapus]" ID="btnHapus" CommandName="Hapus" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>

        <asp:Panel runat="server" ID="panelManipulasiData" Visible="false">
            <h2>
                <asp:Literal ID="literalTitle" runat="server" />
            </h2>
            <hr />

            <asp:TextBox runat="server" ID="hiddenID" Visible="false" />

            <asp:Label Text="Nama Jenis Mobil" ID="lblNamaJenisMobil" runat="server" />
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtNamaJenisMobil"
                ErrorMessage="Harus Diisi" ForeColor="Red" ValidationGroup="ValTambah"></asp:RequiredFieldValidator>
            <asp:Label CssClass="d-block" runat="server" />
            <asp:TextBox runat="server" ID="txtNamaJenisMobil" CssClass="d-block mb-2" />

            <asp:Button ID="btnKirim" OnClick="btnKirim_Click" runat="server" ValidationGroup="ValTambah" />
        </asp:Panel>
    </div>
</asp:Content>
