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

namespace FSantaFe.Facturacion.UI.WinForm
{
    public partial class FrmEstado : Form
    {
        Estado estado = new Estado();
        public byte _idEstado = 0;

        public FrmEstado()
        {
            InitializeComponent();
        }

        private void FrmEstado_Load(object sender, EventArgs e)
        {
            if (_idEstado > 0) {
                CargarDatos();
            }
        }

        private void CargarDatos() {
            estado = EstadoBL.BuscarPorId(_idEstado);
            if (estado.Id > 0)
            {
                txtNombreEstado.Text = estado.Nombre;
            }
            else {
                MessageBox.Show("Ocurrio un problema al intentar cargar datos");
                this.Close();
            }
        }

        private bool ValidarDatosFormulario() {
            bool validar = false;

            if (txtNombreEstado.Text.Trim().Equals("")) {
                MessageBox.Show("Nombre Estado, es obligario");
                validar = true;
            }

            return validar;
        }

        private void Guardar() {
            try
            {
                if (!ValidarDatosFormulario()) {
                    estado.Nombre = txtNombreEstado.Text;
                    if (_idEstado <= 0)
                    {
                        if (EstadoBL.Guardar(estado) > 0)
                        {
                            MessageBox.Show("Registro exitoso");
                            this.Close();
                        }
                    }
                    else {
                        if (EstadoBL.Modificar(estado) > 0)
                        {
                            MessageBox.Show("Registro exitoso");
                            this.Close();
                        }
                    }
                }
            }
            catch (Exception) {
                MessageBox.Show("Ocurrio un error al intentar guardar");
            }
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            Guardar();
        }
    }
}
