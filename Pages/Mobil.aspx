<%@ Page Title="" Language="C#" MasterPageFile="~/Layouts/LayoutMaster.Master" AutoEventWireup="true" CodeBehind="Mobil.aspx.cs" Inherits="LatihanMaster.Pages.Mobil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding-left: 30px; padding-right: 30px;">
        <asp:Panel runat="server" ID="panelView">
            <h2>Lihat Mobil</h2>
            <hr />

            <asp:Button Text="+" ID="btnTambah" OnClick="btnTambah_Click" runat="server" />
            <asp:TextBox runat="server" ID="txtCari" placeholder="Pencarian" />
            <asp:Button Text="Cari" runat="server" ID="btnCari" OnClick="btnCari_Click" />

            <br />
            <br />

            <asp:GridView runat="server" ID="gridDataMobil" AutoGenerateColumns="false" EmptyDataText="Tidak ada Data Mobil"
                ShowHeader="true" ShowHeaderWhenEmpty="true" PageSize="5" AllowPaging="true" AllowSorting="false"
                DataKeyNames="id_mobil" OnPageIndexChanging="gridDataMobil_PageIndexChanging" OnRowCommand="gridDataMobil_RowCommand"
                HeaderStyle-HorizontalAlign="Center">

                <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" />

                <Columns>
                    <asp:BoundField DataField="rownum" HeaderText="No" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="nama_mobil" HeaderText="Nama Mobil" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="merk_mobil" HeaderText="Merk Mobil" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="harga_mobil" HeaderText="Harga Mobil" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="nama_jenis_mobil" HeaderText="Jenis Mobil" ItemStyle-HorizontalAlign="Center" />
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

            <asp:Label Text="Nama Mobil" ID="lblNamaMobil" runat="server" />
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtNamaMobil"
                ErrorMessage="Harus Diisi" ForeColor="Red" ValidationGroup="ValTambah"></asp:RequiredFieldValidator>
            <asp:Label CssClass="d-block" runat="server" />
            <asp:TextBox runat="server" ID="txtNamaMobil" CssClass="d-block mb-2" />

            <asp:Label Text="Merk Mobil" ID="lblMerkMobil" runat="server" />
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtMerkMobil"
                ErrorMessage="Harus Diisi" ForeColor="Red" ValidationGroup="ValTambah"></asp:RequiredFieldValidator>
            <asp:Label CssClass="d-block" runat="server" />
            <asp:TextBox runat="server" ID="txtMerkMobil" CssClass="d-block mb-2" />

            <asp:Label Text="Harga Mobil" ID="lblHargaMobil" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="txtHargaMobil" runat="server"
                ForeColor="Red" ErrorMessage="Harus Diisi" ValidationGroup="ValTambah"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="txtHargaMobil" runat="server"
                ForeColor="Red" Text="Hanya Angka" ValidationGroup="ValTambah" ValidationExpression="^[0-9]*$" />
            <asp:Label CssClass="d-block" runat="server" />
            <asp:TextBox runat="server" ID="txtHargaMobil" CssClass="d-block mb-2" />

            <asp:Label Text="Jenis Mobil" ID="lblJenisMobil" runat="server" />
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="ddlJenisMobil"
                ErrorMessage="Harus Dipilih" ForeColor="Red" ValidationGroup="ValTambah"></asp:RequiredFieldValidator>
            <asp:Label CssClass="d-block" runat="server" />
            <asp:DropDownList ID="DDLJenisMobil" CssClass="form-select d-block mb-2" runat="server"></asp:DropDownList>

            <asp:Button ID="btnKirim" OnClick="btnKirim_Click" runat="server" ValidationGroup="ValTambah" />
        </asp:Panel>
    </div>
</asp:Content>
