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
    public partial class FrmCargo : Form
    {
        Cargo cargo = new Cargo();
        public byte _idCargo = 0;

        public FrmCargo()
        {
            InitializeComponent();
        }

        private void FrmCargo_Load(object sender, EventArgs e)
        {
            cboEstado.DataSource = EstadoBL.ObtenerTodos();
            cboEstado.DisplayMember = "Nombre";
            cboEstado.ValueMember = "Id";

            cboEstado.SelectedItem = null;
            cboEstado.SelectedText = "SELECCIONAR";

            if (_idCargo > 0) {
                CargarDatos();
            }
        }

        private void CargarDatos()
        {
            cargo = CargoBL.BuscarPorId(_idCargo);
            if (cargo.Id > 0)
            {
                txtNombreCargo.Text = cargo.Nombre;
                cboEstado.SelectedValue = cargo.IdEstado;
            }
            else
            {
                MessageBox.Show("Ocurrio un problema al intentar cargar datos");
                this.Close();
            }
        }

        private bool ValidarDatosFormulario()
        {
            bool validar = false;

            if (txtNombreCargo.Text.Trim().Equals(""))
            {
                MessageBox.Show("Nombre Cargo, es obligario");
                validar = true;
            }

            //Operador Ternario ->  (Condicion) ? Condicion falso : Condicion verdadero 
            var idEstado = (cboEstado.SelectedValue == null) ? 0 : (byte)cboEstado.SelectedValue;
            if (idEstado == 0) {
                MessageBox.Show("Seleccionar Estado, es obligario");
                validar = true;
            }

            return validar;
        }

        private void Guardar()
        {
            try
            {
                if (!ValidarDatosFormulario())
                {
                    cargo.Nombre = txtNombreCargo.Text;
                    cargo.IdEstado = (byte)cboEstado.SelectedValue;
                    if (_idCargo <= 0)
                    {
                        if (CargoBL.Guardar(cargo) > 0)
                        {
                            MessageBox.Show("Registro exitoso");
                            this.Close();
                        }
                    }
                    else
                    {
                        if (CargoBL.Modificar(cargo) > 0)
                        {
                            MessageBox.Show("Registro exitoso");
                            this.Close();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ocurrio un error al intentar guardar");
            }
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            Guardar();
        }
    }
}
