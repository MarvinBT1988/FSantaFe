using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FSantaFe.Facturacion.UI.WinForm
{
    static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new FrmPrincipal());



            //string valorRadio = "";

            //if (rdMasculino.Checked) {
            //    valorRadio = rdMasculino.Text;
            //}else if (rdFemenino.Checked)
            //{
            //    valorRadio = rdFemenino.Text;
            //}

            //empleado.Sexo = valorRadio;

        }
    }
}
