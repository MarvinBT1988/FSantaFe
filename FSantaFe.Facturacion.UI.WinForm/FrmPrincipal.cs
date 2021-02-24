using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FSantaFe.Facturacion.UI.WinForm
{
 public partial class FrmPrincipal : Form
 {
  public FrmPrincipal()
  {
   InitializeComponent();
  }

  private void cerrarSesiónToolStripMenuItem_Click(object sender, EventArgs e)
  {
   this.Close();
  }

  private void btnEstados_Click(object sender, EventArgs e)
  {
   FrmEstados frmEstados = new FrmEstados();
   frmEstados.StartPosition = FormStartPosition.CenterScreen;
   frmEstados.ShowDialog();
  }

  private void btnCargos_Click(object sender, EventArgs e)
  {
   FrmCargos frmCargos = new FrmCargos();
   frmCargos.StartPosition = FormStartPosition.CenterScreen;
   frmCargos.ShowDialog();
  }
 }
}
