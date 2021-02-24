using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using FSantaFe.Facturacion.EntidadesDeNegocio;
using FSantaFe.Facturacion.LogicaDeNegocio;
using FSantaFe.Facturacion.UI.WinForm.Utilidades;

namespace FSantaFe.Facturacion.UI.WinForm
{
    public partial class FrmEstados : Form
    {
        public FrmEstados()
        {
            InitializeComponent();
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            FrmEstado frmEstado = new FrmEstado();
            frmEstado.StartPosition = FormStartPosition.CenterScreen;
            frmEstado.ShowDialog();
            MostrarEstados();
        }

        private void FrmEstados_Load(object sender, EventArgs e)
        {
            MostrarEstados();
        }

        private void MostrarEstados() {
            dgvEstados.DataSource = EstadoBL.ObtenerTodos();
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            byte id = (byte)UFormulario.ObtenerIdGrid(dgvEstados);
            if (id > 0)
            {
                FrmEstado frmEstado = new FrmEstado();
                frmEstado.StartPosition = FormStartPosition.CenterScreen;
                frmEstado._idEstado = id;
                frmEstado.ShowDialog();
                MostrarEstados();
            }
            else {
                MessageBox.Show("Debe seleccionar un registro para modificar");
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                byte id = (byte)UFormulario.ObtenerIdGrid(dgvEstados);
                if (id > 0)
                {
                    if (MessageBox.Show("Desea eliminar el registro", "Eliminar",
                        MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == DialogResult.Yes)
                    {
                        if (EstadoBL.Eliminar(new Estado { Id = id }) > 0)
                        {
                            MessageBox.Show("Registro eliminado");
                            MostrarEstados();
                        }
                    }
                }
                else
                {
                    MessageBox.Show("Debe seleccionar un registro");
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show("Error al eliminar un registro: "+ex.Message);
            }
        }
    }
}
